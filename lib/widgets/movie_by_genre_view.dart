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
import 'package:movie_app_sdaia/colors.dart';
import 'package:movie_app_sdaia/custom_widgets/no_internet.dart';
import 'package:movie_app_sdaia/custom_widgets/place_holder.dart';
import 'package:movie_app_sdaia/custom_widgets/vote_stars.dart';
import 'package:movie_app_sdaia/repository/repository.dart';
import 'package:movie_app_sdaia/screen/movie_details_screen.dart';

class MovieByGenreView extends StatefulWidget {

  final int genreID;

  const MovieByGenreView({Key key, this.genreID}) : super(key: key);

  @override
  _MovieByGenreViewState createState() => _MovieByGenreViewState();
}

class _MovieByGenreViewState extends State<MovieByGenreView> {

  MovieByGenreBloc bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<MovieByGenreBloc>(context);
    bloc.add(FetchDataMovieByGenreEvent(genreID: widget.genreID));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BlocBuilder<MovieByGenreBloc, MovieByGenreState>(
      builder: (context, state){
        if(state is MovieByGenreInitialState){
          return PlaceHolder();
        }
        else if(state is MovieByGenreLoadingState){
          return PlaceHolder();
        }
        else if(state is MovieByGenreFetchSuccess){
          return Container(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: state.movieByGenres.length,
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

                          Image.network(
                            "https://image.tmdb.org/t/p/w200"+state.movieByGenres[index].posterPath,
                            height: size.height * 0.23,
                          ),
                          SizedBox(height: 5,),
                          Text(
                            state.movieByGenres[index].title.length > 20 ? state.movieByGenres[index].title.substring(0, 19)+" ..." : state.movieByGenres[index].title,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: Colors.white
                            ),
                          ),
                          SizedBox(height: 5,),
                          Row(
                            children: [
                              Text(
                                state.movieByGenres[index].voteAverage.toString(),
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: Colors.white
                                ),
                              ),

                              SizedBox(width: 10,),

                              StarRating(
                                rating: state.movieByGenres[index].voteAverage/2,
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
                              child: MovieDetailsScreen(movie: state.movieByGenres[index])
                            );
                          }));
                    },
                  ),
                );
              },
            ),
          );
        }
        else if(state is MovieByGenreErrorState){
          return state.message == "NO_INTERNET" ? Container() : Padding(
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
