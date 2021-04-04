import 'package:movie_app_sdaia/model/movie_details_model.dart';
import 'package:movie_app_sdaia/model/video_model.dart';
import 'package:movie_app_sdaia/repository/repository.dart';
import 'package:share/share.dart';

class ShareHelper{

  share(int movieID) async{

    List<MovieDetailsModel> movieDetails = await Repository().getMovieDetails(movieID);
    List<VideoModel> movieVideo = await Repository().getVideo(movieID);

    Share.share(
        movieVideo[0].key == null || movieVideo[0].key == ""
            ?
        "Check out this movie : ${movieDetails[0].title}"
            :
        "Check out this movie : ${movieDetails[0].title} \n \n https://www.youtube.com/watch?v=${movieVideo[0].key}"
    );
  }

}