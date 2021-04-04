import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_app_sdaia/colors.dart';
import 'package:movie_app_sdaia/custom_widgets/vote_stars.dart';
import 'package:movie_app_sdaia/helper_methods/share_helper.dart';
import 'package:movie_app_sdaia/model/movie_model.dart';
import 'package:movie_app_sdaia/widgets/casts_view.dart';
import 'package:movie_app_sdaia/widgets/favorite_button.dart';
import 'package:movie_app_sdaia/widgets/movie_details_view.dart';
import 'package:movie_app_sdaia/widgets/play_video_view.dart';
import 'package:movie_app_sdaia/widgets/similar_movies_view.dart';

class MovieDetailsScreen extends StatefulWidget {

  final MovieModel movie;

  const MovieDetailsScreen({Key key, this.movie}) : super(key: key);

  @override
  _MovieDetailsScreenState createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: darkColor,
      body: Stack(
        children: [
          ListView(
            padding: EdgeInsets.zero,
            children: [

              // Poster Image + AppBar + back button
              Stack(
                children: [
                  // Poster Image
                  Container(
                    height: size.height * 0.30,
                    child: widget.movie.backdropPath != null ?
                    Image.network(
                      "https://image.tmdb.org/t/p/original/"+widget.movie.backdropPath,
                      fit: BoxFit.cover,
                    )
                        :
                    Container(
                      color: headerTextColor,
                      child: Center(
                        child: Icon(
                          Icons.movie,
                          size: 85,
                        ),
                      ),
                    ),
                  ),

                  // Video Play button
                  PlayVideoView(movieID: widget.movie.id,)
                ],
              ),

              //title
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10.0),
                child: Row(
                  children: [

                    Expanded(
                      flex: 8,
                      child: Text(
                        widget.movie.title,
                        textScaleFactor: 1.4,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),

                    Expanded(
                      flex: 3,
                      child: Row(
                        children: [

                          IconButton(
                            icon: Icon(
                              Icons.share,
                              color: headerTextColor,
                            ),
                            onPressed: (){
                              ShareHelper().share(widget.movie.id);
                            },
                          ),

                          // Favorite button
                          FavoriteButton(
                            movieID: widget.movie.id,
                            movieName: widget.movie.title,
                            moviePoster: widget.movie.posterPath,
                          )

                        ],
                      ),
                    )

                  ],
                )
              ),

              // rate
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8.0),
                child: Row(
                  children: [
                    Text(
                      widget.movie.voteAverage.toString(),
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: Colors.white
                      ),
                    ),

                    SizedBox(width: 10,),

                    StarRating(
                      rating: widget.movie.voteAverage/2,
                      size: 17,
                      color: goldColor,
                    )
                  ],
                ),
              ),

              // OverView (Label)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
                child: Container(
                  child: Text(
                    "Overview".toUpperCase(),
                    textScaleFactor: 1.1,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: headerTextColor
                    ),
                  ),
                ),
              ),

              // OverView
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0,),
                child: Container(
                  child: Text(
                    widget.movie.overview,
                    style: TextStyle(
                        color: Colors.white,
                        height: 1.35
                    ),
                  ),
                ),
              ),

              SizedBox(height: 15,),
              // Details (rating, release year, duration)
              Padding(
                padding: EdgeInsets.only(right: 10, left: 10, top: 15.0, bottom: 15),
                child: MovieDetailsView(id: widget.movie.id),
              ),

              SizedBox(height: 15,),

              // List of actors
              // Casts (Label)
              Container(
                height: size.height * 0.19,
                decoration: BoxDecoration(
                    color: darkColor
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header (Trending persons on this week)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                      child: Container(
                        child: Text(
                          "Casts".toUpperCase(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: headerTextColor
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: CastsView(
                        movieID: widget.movie.id,
                      ),
                    )
                  ],
                ),
              ),

              // Similar Movies
              Container(
                height: size.height * 0.37,
                decoration: BoxDecoration(
                    color: darkColor
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header (Trending persons on this week)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                      child: Container(
                        child: Text(
                          "Similar Movies".toUpperCase(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: headerTextColor
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: SimilarMovieView(
                        movieID: widget.movie.id,
                      ),
                    )
                  ],
                ),
              ),

              // similar movies
            ],
          ),

          // AppBar + back button
          Padding(
            padding: const EdgeInsets.only(top: 35.0, left: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.30),
                    shape: BoxShape.circle
                  ),
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    onPressed: (){
                      Navigator.pop(context);
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      )


    );
  }
}
