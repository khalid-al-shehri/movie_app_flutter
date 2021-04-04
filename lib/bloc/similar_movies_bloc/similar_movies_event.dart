import 'package:equatable/equatable.dart';

class SimilarMoviesEvent extends Equatable{
  @override
  List<Object> get props => [];

}

class FetchDataSimilarMoviesEvent extends SimilarMoviesEvent{
  final int movieID;

  FetchDataSimilarMoviesEvent({this.movieID});
}