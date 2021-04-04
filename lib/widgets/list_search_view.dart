import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_sdaia/bloc/Providers.dart';
import 'package:movie_app_sdaia/bloc/search_bloc/search_bloc.dart';
import 'package:movie_app_sdaia/bloc/search_bloc/search_event.dart';
import 'package:movie_app_sdaia/bloc/search_bloc/search_state.dart';
import 'package:movie_app_sdaia/colors.dart';
import 'package:movie_app_sdaia/custom_widgets/no_internet.dart';
import 'package:movie_app_sdaia/custom_widgets/place_holder.dart';
import 'package:movie_app_sdaia/custom_widgets/vote_stars.dart';
import 'package:movie_app_sdaia/screen/movie_details_screen.dart';

class ListSearchView extends StatefulWidget {
  @override
  _ListSearcState createState() => _ListSearcState();
}

class _ListSearcState extends State<ListSearchView>{

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state){
        if(state is SearchInitialState){
          return PlaceHolder();
        }
        else if(state is SearchLoadingState){
          return PlaceHolder();
        }
        else if(state is SearchFetchSuccess){
          if(state.search == null || state.search.length == 0){
            return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.search,
                      size: 85,
                      color: headerTextColor,
                    ),

                    SizedBox(height: 10,),

                    Text(
                      "No history of searches",
                      textScaleFactor: 1.3,
                      style: TextStyle(
                          color: Colors.white
                      ),
                    ),
                  ],
                )
            );
          }
          else{
            return ListView.builder(
              itemCount: state.search.length,
              itemBuilder: (context, index){
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
                  child: RawMaterialButton(
                    child: Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child: state.search[index].posterPath != null ?
                            Image.network(
                                "https://image.tmdb.org/t/p/w200"+state.search[index].posterPath
                            )
                                :
                            Container(
                              color: headerTextColor,
                              height: 165,
                              child: Center(
                                child: Icon(
                                  Icons.movie,
                                  size: 60,
                                  color: darkColor,
                                ),
                              ),
                            )
                        ),

                        SizedBox(width: 15,),

                        Expanded(
                          flex: 6,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                state.search[index].title,
                                style: TextStyle(
                                    color: Colors.white
                                ),
                              ),

                              SizedBox(height: 10,),

                              Row(
                                children: [
                                  Text(
                                    state.search[index].voteAverage.toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  StarRating(
                                    rating: state.search[index].voteAverage / 2,
                                    size: 20,
                                    color: goldColor,
                                  )
                                ],
                              ),

                              SizedBox(
                                height: 10,
                              ),

                              Text(
                                state.search[index].originalLanguage.toString().toUpperCase(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold
                                ),
                              ),

                            ],
                          ),
                        )
                      ],
                    ),
                    onPressed: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context){
                            return Providers().getMovieDetailsProvider(
                                child: MovieDetailsScreen(movie: state.search[index])
                            );
                          }));
                    },
                  ),
                );
              },
            );
          }
        }
        else if(state is SearchErrorState){
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
