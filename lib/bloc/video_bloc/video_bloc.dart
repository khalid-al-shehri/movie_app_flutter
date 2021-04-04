import 'package:connectivity/connectivity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_sdaia/bloc/video_bloc/video_event.dart';
import 'package:movie_app_sdaia/bloc/video_bloc/video_state.dart';

import 'package:movie_app_sdaia/repository/repository.dart';

class VideoBloc extends Bloc<VideoEvent, VideoState>{
  Repository repo;
  VideoBloc(VideoState initialState, this.repo) : super(initialState);

  @override
  Stream<VideoState> mapEventToState(VideoEvent event) async*{

    if(event is FetchDataVideoEvent){
      yield VideoLoadingState();
      try{
        var connectivityResult = await (Connectivity().checkConnectivity());
        if (connectivityResult != ConnectivityResult.mobile && connectivityResult != ConnectivityResult.wifi) {
          yield VideoErrorState(message: "NO_INTERNET");
        }else {
          var video = await repo.getVideo(event.movieID);
          yield VideoFetchSuccess(video: video);
        }
      }catch(e){
        print(e.toString());
        yield VideoErrorState(message: e.toString());
      }
    }

  }



}