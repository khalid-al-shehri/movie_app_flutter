import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_sdaia/bloc/Providers.dart';
import 'package:movie_app_sdaia/bloc/casts_bloc/casts_bloc.dart';
import 'package:movie_app_sdaia/bloc/casts_bloc/casts_state.dart';
import 'package:movie_app_sdaia/bloc/movie_by_genre_bloc/movie_by_genre_bloc.dart';
import 'package:movie_app_sdaia/bloc/movie_by_genre_bloc/movie_by_genre_event.dart';
import 'package:movie_app_sdaia/bloc/movie_by_genre_bloc/movie_by_genre_state.dart';
import 'package:movie_app_sdaia/bloc/movie_details_bloc/movie_details_bloc.dart';
import 'package:movie_app_sdaia/bloc/movie_details_bloc/movie_details_state.dart';
import 'package:movie_app_sdaia/bloc/similar_movies_bloc/similar_movies_bloc.dart';
import 'package:movie_app_sdaia/bloc/similar_movies_bloc/similar_movies_event.dart';
import 'package:movie_app_sdaia/bloc/similar_movies_bloc/similar_movies_state.dart';
import 'package:movie_app_sdaia/colors.dart';
import 'package:movie_app_sdaia/custom_widgets/no_internet.dart';
import 'package:movie_app_sdaia/custom_widgets/place_holder.dart';
import 'package:movie_app_sdaia/custom_widgets/vote_stars.dart';
import 'package:movie_app_sdaia/repository/repository.dart';
import 'package:movie_app_sdaia/screen/movie_details_screen.dart';

class SimilarMovieView extends StatefulWidget {

  final int movieID;

  const SimilarMovieView({Key key, this.movieID}) : super(key: key);

  @override
  _SimilarMovieViewState createState() => _SimilarMovieViewState();
}

class _SimilarMovieViewState extends State<SimilarMovieView> {

  SimilarMoviesBloc bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<SimilarMoviesBloc>(context);
    bloc.add(FetchDataSimilarMoviesEvent(movieID: widget.movieID));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BlocBuilder<SimilarMoviesBloc, SimilarMoviesState>(
      builder: (context, state){
        if(state is SimilarMoviesInitialState){
          return PlaceHolder();
        }
        else if(state is SimilarMoviesLoadingState){
          return PlaceHolder();
        }
        else if(state is SimilarMoviesFetchSuccess){
          if(state.similarMovies.length == 0){
            return Center(
              child: Text(
                "No similar movies",
                style: TextStyle(
                  color: Colors.white.withOpacity(0.65)
                ),
              ),
            );
          }else{
            return Container(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: state.similarMovies.length,
                itemBuilder: (context, index){
                  return Container(
                    color: darkColor,
                    width: size.width * 0.36,
                    child: RawMaterialButton(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [

                            state.similarMovies[index].posterPath != null
                                ?
                            Image.network(
                              "https://image.tmdb.org/t/p/w200"+state.similarMovies[index].posterPath,
                              height: size.height * 0.23,
                            )
                                :
                            Container(
                              color: headerTextColor,
                              height: 200,
                              child: Center(
                                child: Icon(
                                  Icons.movie,
                                  size: 85,
                                ),
                              ),
                            ),
                            SizedBox(height: 5,),
                            Text(
                              state.similarMovies[index].title.length > 20 ? state.similarMovies[index].title.substring(0, 19)+" ..." : state.similarMovies[index].title,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: Colors.white
                              ),
                            ),
                            SizedBox(height: 5,),
                            Row(
                              children: [
                                Text(
                                  state.similarMovies[index].voteAverage.toString(),
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      color: Colors.white
                                  ),
                                ),

                                SizedBox(width: 10,),

                                StarRating(
                                  rating: state.similarMovies[index].voteAverage/2,
                                  color: goldColor,
                                )
                              ],
                            ),

                          ],
                        ),
                      ),
                      onPressed: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context){
                              return Providers().getMovieDetailsProvider(
                                  child: MovieDetailsScreen(movie: state.similarMovies[index])
                              );
                            }));
                      },
                    ),
                  );
                },
              ),
            );
          }

        }
        else if(state is SimilarMoviesErrorState){
          return state.message == "NO_INTERNET" ? NoInternet() : Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              state.message,
              style: TextStyle(
                  color: Colors.red
              ),
            ),
          );;
        }
        else{
          return Container();
        }
      },
    );
  }
}
