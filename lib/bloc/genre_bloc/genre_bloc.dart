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
      yield LoadingState();
      try{
        var genres = await repo.getGenre();
        yield FetchSuccess(genres: genres);
      }catch(e){
        print(e.toString());
        yield ErrorState(message: e.toString());
      }
    }

  }



}