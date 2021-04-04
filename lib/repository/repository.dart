import 'dart:convert';
import 'package:movie_app_sdaia/model/casts_model.dart';
import 'package:movie_app_sdaia/model/genre_model.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app_sdaia/model/movie_details_model.dart';
import 'package:movie_app_sdaia/model/movie_model.dart';
import 'package:movie_app_sdaia/model/trending_persons_model.dart';
import 'package:connectivity/connectivity.dart';
import 'package:movie_app_sdaia/model/video_model.dart';

class Repository{

  static String apiKey = "9f11e1d3bb79deff6ae49d6475b1896e";
  static String baseUrl = "api.themoviedb.org";
  var getTopRatedMoviesUrl = '/3/movie/top_rated';
  var getMoviesUrl = '/3/discover/movie';
  var getPlayingUrl = '/3/movie/now_playing';
  var getGenresUrl = "/3/genre/movie/list";
  var getTrendingPersonsUrl = "/3/trending/person/week";
  var getSearchUrl = "/3/search/movie";
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

      return movieByGenre;
    }

  }

  Future<List<MovieModel>> search(String searchValue) async{

    List<MovieModel> moviesSearch = [];

    var response = await http.get(Uri.https(baseUrl, getSearchUrl, {"api_key": apiKey, "language": "en-US", "query": searchValue.toString()}));
    if(response.statusCode == 200){
      var data = json.decode(response.body)['results'];
      print(data);
      data.map((movie){
        moviesSearch.add(MovieModel.fromJson(movie));
      }).toList();

      return moviesSearch;
    }

  }

  Future<List<TrendingPersonsModel>> getTrendingPersons() async{

    List<TrendingPersonsModel> trendingPersons = [];

    var response = await http.get(Uri.https(baseUrl, getTrendingPersonsUrl, {"api_key": apiKey}));
    if(response.statusCode == 200){
      var data = json.decode(response.body)['results'];
      data.map((movie){
        trendingPersons.add(TrendingPersonsModel.fromJson(movie));
      }).toList();

      return trendingPersons;
    }

  }

  Future<List<MovieModel>> getTopRatedMovies() async{

    List<MovieModel> topRatedMovies = [];

    var response = await http.get(Uri.https(baseUrl, getTopRatedMoviesUrl, {"api_key": apiKey, "language": "en-US", "page": "1"}));
    if(response.statusCode == 200){
      var data = json.decode(response.body)['results'];
      data.map((movie){
        topRatedMovies.add(MovieModel.fromJson(movie));
      }).toList();

      return topRatedMovies;
    }

  }

  Future<List<MovieDetailsModel>> getMovieDetails(int movieID) async{

    List<MovieDetailsModel> movieInfo = [];

    var response = await http.get(Uri.https(baseUrl, movieUrl+"/${movieID.toString()}", {"api_key": apiKey, "language": "en-US"}));
    if(response.statusCode == 200){
      List dataInList = [];
      var data = json.decode(response.body);
      dataInList.add(data);
      dataInList.map((movie){
        movieInfo.add(MovieDetailsModel.fromJson(movie));
      }).toList();

      return movieInfo;
    }

  }

  Future<List<CastsModel>> getCasts(int movieID) async{

    List<CastsModel> casts = [];

    var response = await http.get(Uri.https(baseUrl, movieUrl+"/${movieID.toString()}"+"/credits", {"api_key": apiKey, "language": "en-US"}));
    if(response.statusCode == 200){
      var data = json.decode(response.body)['cast'];
      data.map((cast){
        casts.add(CastsModel.fromJson(cast));
      }).toList();

      return casts;
    }

  }

  Future<List<MovieModel>> getSimilarMovies(int movieID) async{

    List<MovieModel> similarMovies = [];

    var response = await http.get(Uri.https(baseUrl, movieUrl+"/${movieID.toString()}"+"/similar", {"api_key": apiKey, "language": "en-US"}));
    if(response.statusCode == 200){
      var data = json.decode(response.body)['results'];
      data.map((movie){
        similarMovies.add(MovieModel.fromJson(movie));
      }).toList();

      return similarMovies;
    }

  }

  Future<List<VideoModel>> getVideo(int movieID) async{

    List<VideoModel> movieViedos = [];

    var response = await http.get(Uri.https(baseUrl, movieUrl+"/${movieID.toString()}"+"/videos", {"api_key": apiKey, "language": "en-US"}));
    if(response.statusCode == 200){
      var data = json.decode(response.body)['results'];
      data.map((video){
        movieViedos.add(VideoModel.fromJson(video));
      }).toList();

      return movieViedos;
    }

  }

}