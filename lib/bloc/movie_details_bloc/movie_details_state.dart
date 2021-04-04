import 'package:equatable/equatable.dart';
import 'package:movie_app_sdaia/model/movie_details_model.dart';

class MovieDetailsState extends Equatable{
  @override
  List<Object> get props => [];

}

class MovieDetailsInitialState extends MovieDetailsState {}

class MovieDetailsLoadingState extends MovieDetailsState {}

class MovieDetailsFetchSuccess extends MovieDetailsState{

  List<MovieDetailsModel> movieDetails;
  MovieDetailsFetchSuccess({this.movieDetails});

}

class MovieDetailsErrorState extends MovieDetailsState{
  String message;
  MovieDetailsErrorState({this.message});
}