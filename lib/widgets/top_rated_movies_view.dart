import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_sdaia/bloc/Providers.dart';
import 'package:movie_app_sdaia/bloc/top_rated_movies/top_rated_movies_bloc.dart';
import 'package:movie_app_sdaia/bloc/top_rated_movies/top_rated_movies_event.dart';
import 'package:movie_app_sdaia/bloc/top_rated_movies/top_rated_movies_state.dart';
import 'package:movie_app_sdaia/colors.dart';
import 'package:movie_app_sdaia/custom_widgets/no_internet.dart';
import 'package:movie_app_sdaia/custom_widgets/place_holder.dart';
import 'package:movie_app_sdaia/custom_widgets/vote_stars.dart';
import 'package:movie_app_sdaia/screen/movie_details_screen.dart';

class TopRatedMoviesView extends StatefulWidget {
  @override
  _TopRatedMoviesViewState createState() => _TopRatedMoviesViewState();
}

class _TopRatedMoviesViewState extends State<TopRatedMoviesView> {

  TopRatedMoviesBloc bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<TopRatedMoviesBloc>(context);
    bloc.add(FetchDataTopRatedMoviesEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BlocBuilder<TopRatedMoviesBloc, TopRatedMoviesState>(
      builder: (context, state){
        if(state is TopRatedMoviesInitialState){
          return PlaceHolder();
        }
        else if(state is TopRatedMoviesLoadingState){
          return PlaceHolder();
        }
        else if(state is TopRatedMoviesFetchSuccess){
          return Container(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: state.topRatedMovies.length,
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
                            "https://image.tmdb.org/t/p/w200"+state.topRatedMovies[index].posterPath,
                            height: size.height * 0.23,
                          ),
                          SizedBox(height: 5,),
                          Text(
                            state.topRatedMovies[index].title.length > 20 ? state.topRatedMovies[index].title.substring(0, 19)+" ..." : state.topRatedMovies[index].title,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: Colors.white
                            ),
                          ),
                          SizedBox(height: 5,),
                          Row(
                            children: [
                              Text(
                                state.topRatedMovies[index].voteAverage.toString(),
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: Colors.white
                                ),
                              ),

                              SizedBox(width: 10,),

                              StarRating(
                                rating: state.topRatedMovies[index].voteAverage/2,
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
                                child: MovieDetailsScreen(movie: state.topRatedMovies[index])
                            );
                          }));
                    },
                  ),
                );
              },
            ),
          );
        }
        else if(state is TopRatedMoviesErrorState){
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
