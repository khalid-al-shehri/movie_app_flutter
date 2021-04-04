import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

class SQFLite_helper {

  static SQFLite_helper _databaseHelper;
  static Database _database;

  SQFLite_helper._createInstance();

  static final _dbName = 'MovieApp.db';
  static final _dbVersion = 1;
  static final _tableFavorite = 'Favorite';
  static final _tableSearch = 'Search';

  // Columns Favorite
  static final columnMovieId = 'ID';
  static final columnMovieName = 'MovieName';
  static final columnMoviePoster = 'Poster';

  // Columns Search
  static final columnSearchId = 'ID';
  static final columnSearchValue = 'SearchValue';

  factory SQFLite_helper() {

    if (_databaseHelper == null) {
      _databaseHelper = SQFLite_helper._createInstance();
    }
    return _databaseHelper;
  }

  Future<Database> initializeDatabase() async {
    // Get the directory path for both Android and iOS to store database.
    // Directory directory = await getApplicationDocumentsDirectory();
    String directory = await getDatabasesPath();
    String path = p.join(directory, '$_dbName');

    // Open/create the database at a given path
    var quotesDatabase = await openDatabase(
        path,
        version: _dbVersion,
        onCreate: _createTableDb);

    return quotesDatabase;
  }

  void _createTableDb(Database db, int version) async {
    await db.execute(
      'CREATE TABLE $_tableFavorite($columnMovieId INTEGER PRIMARY KEY, $columnMovieName TEXT, $columnMoviePoster TEXT)',
    );

    await db.execute(
      'CREATE TABLE $_tableSearch($columnSearchId INTEGER PRIMARY KEY autoincrement, $columnSearchValue TEXT)',
    );
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  // Favorite
  Future<int> insertFavorite({int movieId, String movieName, String moviePoster}) async {
    Database db = await this.database;
    return await db.insert(
      // add to this table
        '$_tableFavorite',
        // values to add
        {
          "$columnMovieId": movieId,
          "$columnMovieName": movieName,
          "$columnMoviePoster": moviePoster
        }
    );
  }

  Future<void> removeFavorite({int movieId}) async {
    Database db = await this.database;
    await db.delete(
        '$_tableFavorite',
        where: "$columnMovieId = ?",
        whereArgs: [movieId]
    );


  }

  Future<List> getAllFavorite() async {
    Database db = await this.database;
    final List getAll = await db.query('$_tableFavorite');
    return getAll;
  }

  Future<bool> isFavorite({int movieID})async{
    Database db = await this.database;
    List res = await db.query(
        '$_tableFavorite',
        where: "$columnMovieId = ?",
        whereArgs: [movieID]
    );
    return res.length > 0 ? true : false;
  }

  // Search
  Future<int> insertSearch({String searchValue}) async {
    Database db = await this.database;
    return await db.insert(
      // add to this table
        '$_tableSearch',
        // values to add
        {
          "$columnSearchValue": searchValue,
        }
    );
  }

  Future<void> removeSearch({int searchId}) async {
    Database db = await this.database;
    await db.delete(
        '$_tableSearch',
        where: "$columnSearchId = ?",
        whereArgs: [searchId]
    );
  }

  Future<List> getAllSearch() async {
    Database db = await this.database;
    final List getAll = await db.query('$_tableSearch');
    return getAll;
  }

}