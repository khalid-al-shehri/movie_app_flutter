import 'package:connectivity/connectivity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_sdaia/bloc/movie_details_bloc/movie_details_event.dart';
import 'package:movie_app_sdaia/bloc/movie_details_bloc/movie_details_state.dart';
import 'package:movie_app_sdaia/repository/repository.dart';

class MovieDetailsBloc extends Bloc<MovieDetailsEvent, MovieDetailsState>{
  Repository repo;
  MovieDetailsBloc(MovieDetailsState initialState, this.repo) : super(initialState);

  @override
  Stream<MovieDetailsState> mapEventToState(MovieDetailsEvent event) async*{

    if(event is FetchDataMovieDetailsEvent){
      yield MovieDetailsLoadingState();
      try{
        var connectivityResult = await (Connectivity().checkConnectivity());
        if (connectivityResult != ConnectivityResult.mobile && connectivityResult != ConnectivityResult.wifi) {
          yield MovieDetailsErrorState(message: "NO_INTERNET");
        }else {
          var movieDetails = await repo.getMovieDetails(event.movieID);
          yield MovieDetailsFetchSuccess(movieDetails: movieDetails);
        }
      }catch(e){
        print(e.toString());
        yield MovieDetailsErrorState(message: e.toString());
      }
    }

  }



}