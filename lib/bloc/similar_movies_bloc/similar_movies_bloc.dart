import 'package:connectivity/connectivity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_sdaia/bloc/similar_movies_bloc/similar_movies_event.dart';
import 'package:movie_app_sdaia/bloc/similar_movies_bloc/similar_movies_state.dart';
import 'package:movie_app_sdaia/repository/repository.dart';

class SimilarMoviesBloc extends Bloc<SimilarMoviesEvent, SimilarMoviesState>{
  Repository repo;
  SimilarMoviesBloc(SimilarMoviesState initialState, this.repo) : super(initialState);

  @override
  Stream<SimilarMoviesState> mapEventToState(SimilarMoviesEvent event) async*{

    if(event is FetchDataSimilarMoviesEvent){
      yield SimilarMoviesLoadingState();
      try{
        var connectivityResult = await (Connectivity().checkConnectivity());
        if (connectivityResult != ConnectivityResult.mobile && connectivityResult != ConnectivityResult.wifi) {
          yield SimilarMoviesErrorState(message: "NO_INTERNET");
        } else {
          var similarMovies = await repo.getSimilarMovies(event.movieID);
          yield SimilarMoviesFetchSuccess(similarMovies: similarMovies);
        }
      }catch(e){
        print(e.toString());
        yield SimilarMoviesErrorState(message: e.toString());
      }
    }

  }



}