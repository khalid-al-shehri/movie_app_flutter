import 'package:connectivity/connectivity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_sdaia/bloc/genre_bloc/genre_event.dart';
import 'package:movie_app_sdaia/bloc/genre_bloc/genre_state.dart';
import 'package:movie_app_sdaia/repository/repository.dart';

class GenreBloc extends Bloc<GenreEvent, GenreState>{
  Repository repo;
  GenreBloc(GenreState initialState, this.repo) : super(initialState);

  @override
  Stream<GenreState> mapEventToState(GenreEvent event) async*{

    if(event is FetchDataGenreEvent){
      yield GenreLoadingState();
      try{
        var connectivityResult = await (Connectivity().checkConnectivity());
        if (connectivityResult != ConnectivityResult.mobile && connectivityResult != ConnectivityResult.wifi) {
          yield GenreErrorState(message: "NO_INTERNET");
        } else {
          var genres = await repo.getGenre();
          yield GenreFetchSuccess(genres: genres);
        }
      }catch(e){
        print(e.toString());
        yield GenreErrorState(message: e.toString());
      }
    }

  }



}