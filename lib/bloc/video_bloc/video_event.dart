import 'package:equatable/equatable.dart';

class VideoEvent extends Equatable{
  @override
  List<Object> get props => [];

}

class FetchDataVideoEvent extends VideoEvent{
  final int movieID;

  FetchDataVideoEvent({this.movieID});
}