
import 'dart:convert';

import 'package:movie_app_sdaia/model/genreModel.dart';
import 'package:http/http.dart' as http;

class Repository{

  static String apiKey = "8a1227b5735a7322c4a43a461953d4ff";
  static String baseUrl = "api.themoviedb.org";
  var getPopularUrl = '$baseUrl/movie/top_rated';
  var getMoviesUrl = '$String/discover/movie';
  var getPlayingUrl = '$String/movie/now_playing';
  var getGenresUrl = "/3/genre/movie/list";
  var getPersonsUrl = "$String/trending/person/week";
  var movieUrl = "$String/movie";

  Future<List<GenreModel>> getGenre() async{

    List<GenreModel> genres = [];

    var response = await http.get(Uri.https(baseUrl, getGenresUrl, {"api_key": apiKey, "language": "en-US"}));
    if(response.statusCode == 200){
      var data = json.decode(response.body)['genres'];
      data.map((genre) => genres.add(GenreModel.fromJson(genre))).toList();

      print(genres.toString());

      return genres;
    }
  }

}