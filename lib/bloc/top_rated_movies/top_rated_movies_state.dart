import 'package:equatable/equatable.dart';
import 'package:movie_app_sdaia/model/movie_model.dart';

class TopRatedMoviesState extends Equatable{
  @override
  List<Object> get props => [];

}

class TopRatedMoviesInitialState extends TopRatedMoviesState {}

class TopRatedMoviesLoadingState extends TopRatedMoviesState {}

class TopRatedMoviesFetchSuccess extends TopRatedMoviesState{

  List<MovieModel> topRatedMovies;
  TopRatedMoviesFetchSuccess({this.topRatedMovies});

}

class TopRatedMoviesErrorState extends TopRatedMoviesState{
  String message;
  TopRatedMoviesErrorState({this.message});
}