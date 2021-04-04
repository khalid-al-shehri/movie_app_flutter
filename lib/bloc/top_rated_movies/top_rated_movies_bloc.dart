import 'package:connectivity/connectivity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_sdaia/bloc/genre_bloc/genre_event.dart';
import 'package:movie_app_sdaia/bloc/genre_bloc/genre_state.dart';
import 'package:movie_app_sdaia/bloc/top_rated_movies/top_rated_movies_event.dart';
import 'package:movie_app_sdaia/bloc/top_rated_movies/top_rated_movies_state.dart';
import 'package:movie_app_sdaia/repository/repository.dart';

class TopRatedMoviesBloc extends Bloc<TopRatedMoviesEvent, TopRatedMoviesState>{
  Repository repo;
  TopRatedMoviesBloc(TopRatedMoviesState initialState, this.repo) : super(initialState);

  @override
  Stream<TopRatedMoviesState> mapEventToState(TopRatedMoviesEvent event) async*{

    if(event is FetchDataTopRatedMoviesEvent){
      yield TopRatedMoviesLoadingState();
      try{
        var connectivityResult = await (Connectivity().checkConnectivity());
        if (connectivityResult != ConnectivityResult.mobile && connectivityResult != ConnectivityResult.wifi) {
          yield TopRatedMoviesErrorState(message: "NO_INTERNET");
        } else {
          var topRatedMovies = await repo.getTopRatedMovies();
          yield TopRatedMoviesFetchSuccess(topRatedMovies: topRatedMovies);
        }
      }catch(e){
        print(e.toString());
        yield TopRatedMoviesErrorState(message: e.toString());
      }
    }

  }



}