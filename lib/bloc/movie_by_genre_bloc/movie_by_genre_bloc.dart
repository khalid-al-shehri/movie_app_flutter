

import 'package:connectivity/connectivity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_sdaia/bloc/movie_by_genre_bloc/movie_by_genre_event.dart';
import 'package:movie_app_sdaia/bloc/movie_by_genre_bloc/movie_by_genre_state.dart';
import 'package:movie_app_sdaia/repository/repository.dart';

class MovieByGenreBloc extends Bloc<MovieByGenreEvent, MovieByGenreState>{
  Repository repo;
  MovieByGenreBloc(MovieByGenreState initialState, this.repo) : super(initialState);

  @override
  Stream<MovieByGenreState> mapEventToState(MovieByGenreEvent event) async*{

    if(event is FetchDataMovieByGenreEvent){
      yield MovieByGenreLoadingState();
      try{
        var connectivityResult = await (Connectivity().checkConnectivity());
        if (connectivityResult != ConnectivityResult.mobile && connectivityResult != ConnectivityResult.wifi) {
          yield MovieByGenreErrorState(message: "NO_INTERNET");
        }else {
          var movieByGenres = await repo.getMovieByGenre(event.genreID);
          yield MovieByGenreFetchSuccess(movieByGenres: movieByGenres);
        }
      }catch(e){
        print(e.toString());
        yield MovieByGenreErrorState(message: e.toString());
      }
    }

  }



}