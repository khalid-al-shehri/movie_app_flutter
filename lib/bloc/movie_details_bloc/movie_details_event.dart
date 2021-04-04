import 'package:equatable/equatable.dart';

class MovieDetailsEvent extends Equatable{
  @override
  List<Object> get props => [];

}

class FetchDataMovieDetailsEvent extends MovieDetailsEvent{
  final int movieID;

  FetchDataMovieDetailsEvent({this.movieID});
}