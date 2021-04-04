import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_sdaia/bloc/video_bloc/video_bloc.dart';
import 'package:movie_app_sdaia/bloc/video_bloc/video_event.dart';
import 'package:movie_app_sdaia/bloc/video_bloc/video_state.dart';
import 'package:movie_app_sdaia/colors.dart';
import 'package:movie_app_sdaia/screen/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class PlayVideoView extends StatefulWidget {
  final int movieID;

  const PlayVideoView({Key key, this.movieID}) : super(key: key);

  @override
  _PlayVideoViewState createState() => _PlayVideoViewState();
}

class _PlayVideoViewState extends State<PlayVideoView>{

  VideoBloc bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<VideoBloc>(context);
    bloc.add(FetchDataVideoEvent(movieID: widget.movieID));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return BlocBuilder<VideoBloc, VideoState>(
      builder: (context, state){
        if(state is VideoFetchSuccess){
          if(state.video != null && state.video.length > 0){
            return Container(
              height: size.height * 0.30,
              width: size.width,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RawMaterialButton(
                      child: Icon(
                        Icons.play_circle_fill_sharp,
                        color: goldColor,
                        size: 70,
                      ),
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => VideoPlayerScreen(
                              controller: YoutubePlayerController(
                                initialVideoId: state.video[0].key,
                                flags: YoutubePlayerFlags(
                                  autoPlay: true,
                                  mute: true,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
            );
          }else{
            return Container();
          }

        }else{
          return Container();
        }
      },
    );
  }
}
