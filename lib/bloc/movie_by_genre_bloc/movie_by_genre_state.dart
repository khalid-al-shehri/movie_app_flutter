import 'package:equatable/equatable.dart';
import 'package:movie_app_sdaia/model/movie_model.dart';

class MovieByGenreState extends Equatable{
  @override
  List<Object> get props => [];

}

class MovieByGenreInitialState extends MovieByGenreState {}

class MovieByGenreLoadingState extends MovieByGenreState {}

class MovieByGenreFetchSuccess extends MovieByGenreState{

  List<MovieModel> movieByGenres;
  MovieByGenreFetchSuccess({this.movieByGenres});

}

class MovieByGenreErrorState extends MovieByGenreState{
  String message;
  MovieByGenreErrorState({this.message});
}