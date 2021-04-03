import 'package:equatable/equatable.dart';
import 'package:movie_app_sdaia/model/genreModel.dart';

class GenreState extends Equatable{
  @override
  List<Object> get props => [];

}

class InitialState extends GenreState {}

class LoadingState extends GenreState {}

class FetchSuccess extends GenreState{

  List<GenreModel> genres;
  FetchSuccess({this.genres});

}

class ErrorState extends GenreState{
  String message;
  ErrorState({this.message});
}