
import 'dart:convert';

import 'package:movie_app_sdaia/model/genreModel.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app_sdaia/model/movieModel.dart';

class Repository{

  static String apiKey = "8a1227b5735a7322c4a43a461953d4ff";
  static String baseUrl = "api.themoviedb.org";
  var getPopularUrl = '/3/movie/top_rated';
  var getMoviesUrl = '/3/discover/movie';
  var getPlayingUrl = '/3/movie/now_playing';
  var getGenresUrl = "/3/genre/movie/list";
  var getPersonsUrl = "/3/trending/person/week";
  var movieUrl = "/3/movie";

  Future<List<GenreModel>> getGenre() async{

    List<GenreModel> genres = [];

    var response = await http.get(Uri.https(baseUrl, getGenresUrl, {"api_key": apiKey, "language": "en-US"}));
    if(response.statusCode == 200){
      var data = json.decode(response.body)['genres'];
      data.map((genre) => genres.add(GenreModel.fromJson(genre))).toList();

      return genres;
    }
  }

  Future<List<MovieModel>> getMovieByGenre(int genreID) async{

    List<MovieModel> movieByGenre = [];

    var response = await http.get(Uri.https(baseUrl, getMoviesUrl, {"api_key": apiKey, "language": "en-US", "with_genres": genreID.toString(), "page": "1"}));
    if(response.statusCode == 200){
      var data = json.decode(response.body)['results'];
      data.map((movie){
        movieByGenre.add(MovieModel.fromJson(movie));
      }).toList();

      print(movieByGenre.length);

      return movieByGenre;
    }

  }



}