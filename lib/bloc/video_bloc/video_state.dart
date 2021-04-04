import 'package:equatable/equatable.dart';
import 'package:movie_app_sdaia/model/video_model.dart';

class VideoState extends Equatable{
  @override
  List<Object> get props => [];

}

class VideoInitialState extends VideoState {}

class VideoLoadingState extends VideoState {}

class VideoFetchSuccess extends VideoState{

  List<VideoModel> video;
  VideoFetchSuccess({this.video});

}

class VideoErrorState extends VideoState{
  String message;
  VideoErrorState({this.message});
}