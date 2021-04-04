import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_sdaia/bloc/Providers.dart';
import 'package:movie_app_sdaia/bloc/top_rated_movies/top_rated_movies_bloc.dart';
import 'package:movie_app_sdaia/bloc/top_rated_movies/top_rated_movies_event.dart';
import 'package:movie_app_sdaia/bloc/top_rated_movies/top_rated_movies_state.dart';
import 'package:movie_app_sdaia/colors.dart';
import 'package:movie_app_sdaia/custom_widgets/no_internet.dart';
import 'package:movie_app_sdaia/custom_widgets/place_holder.dart';
import 'package:movie_app_sdaia/screen/movie_details_screen.dart';

class Top10Movies extends StatefulWidget {
  @override
  _Top10MoviesState createState() => _Top10MoviesState();
}

class _Top10MoviesState extends State<Top10Movies> {

  TopRatedMoviesBloc bloc;

  PageController _pageController = PageController();
  int imageInShow = 0;

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
            height: size.height * 0.30,
            child: Stack(
              children: [
                // Image Slider
                PageView.builder(
                    onPageChanged: (value){
                      setState(() {
                        imageInShow = value;
                      });
                    },
                    controller: _pageController,
                    itemCount: state.topRatedMovies.take(10).length == null ? 0 : state.topRatedMovies.take(10).length,
                    itemBuilder: (context, index) {
                      return RawMaterialButton(
                        child: AnimatedBuilder(
                            animation: _pageController,
                            builder: (context, widget) {
                              return SizedBox(
                                width: size.width,
                                child: widget,
                              );
                            },
                            child: Stack(
                              children: [

                                Container(
                                    child: Image.network(
                                      "https://image.tmdb.org/t/p/original/"+state.topRatedMovies[index].backdropPath,
                                      fit: BoxFit.cover,
                                    )
                                ),

                                Stack(
                                  children: [
                                    // Slider movies
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Stack(
                                          children: [
                                            // gradient offer image
                                            Container(
                                              decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                      begin: Alignment.bottomCenter,
                                                      end: Alignment.topCenter,
                                                      colors: [
                                                        darkColor,
                                                        Colors.transparent,
                                                      ],
                                                      stops: [
                                                        0.38,
                                                        0.9
                                                      ]
                                                  )
                                              ),
                                              height: 150,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),

                                    // Title
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(left: 15, bottom: 40),
                                          child: Text(
                                            state.topRatedMovies[index].title,
                                            textScaleFactor: 1.6,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                )
                              ],
                            )
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
                      );
                    }
                ),

                // Image tracker, points
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(state.topRatedMovies.take(10).length, (index){
                            return Container(
                              margin: EdgeInsets.symmetric(horizontal: 5),
                              height: 6,
                              width: 6,
                              decoration: BoxDecoration(
                                color: index == imageInShow ? goldColor  : Colors.grey[500],
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 3.0,
                                    color: index == imageInShow ? goldColor : Colors.black.withOpacity(0.50),
                                    offset: Offset(0,0),
                                  ),
                                ],
                              ),
                            );
                          })
                      ),
                    ),
                  ],
                )
              ],
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
