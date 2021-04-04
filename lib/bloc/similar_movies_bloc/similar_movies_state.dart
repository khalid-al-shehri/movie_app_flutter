import 'package:equatable/equatable.dart';
import 'package:movie_app_sdaia/model/movie_model.dart';

class SimilarMoviesState extends Equatable{
  @override
  List<Object> get props => [];

}

class SimilarMoviesInitialState extends SimilarMoviesState {}

class SimilarMoviesLoadingState extends SimilarMoviesState {}

class SimilarMoviesFetchSuccess extends SimilarMoviesState{

  List<MovieModel> similarMovies;
  SimilarMoviesFetchSuccess({this.similarMovies});

}

class SimilarMoviesErrorState extends SimilarMoviesState{
  String message;
  SimilarMoviesErrorState({this.message});
}