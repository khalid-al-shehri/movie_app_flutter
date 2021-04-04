import 'package:equatable/equatable.dart';
import 'package:movie_app_sdaia/model/genre_model.dart';

class GenreState extends Equatable{
  @override
  List<Object> get props => [];

}

class GenreInitialState extends GenreState {}

class GenreLoadingState extends GenreState {}

class GenreFetchSuccess extends GenreState{

  List<GenreModel> genres;
  GenreFetchSuccess({this.genres});

}

class GenreErrorState extends GenreState{
  String message;
  GenreErrorState({this.message});
}