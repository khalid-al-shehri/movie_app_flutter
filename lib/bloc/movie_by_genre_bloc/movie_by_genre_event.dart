import 'package:equatable/equatable.dart';

class MovieByGenreEvent extends Equatable{
  @override
  List<Object> get props => [];

}

class FetchDataMovieByGenreEvent extends MovieByGenreEvent{
  final int genreID;

  FetchDataMovieByGenreEvent({this.genreID});
}