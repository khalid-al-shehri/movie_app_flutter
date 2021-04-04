import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_sdaia/bloc/movie_details_bloc/movie_details_bloc.dart';
import 'package:movie_app_sdaia/bloc/movie_details_bloc/movie_details_event.dart';
import 'package:movie_app_sdaia/bloc/movie_details_bloc/movie_details_state.dart';
import 'package:movie_app_sdaia/colors.dart';

class MovieDetailsView extends StatefulWidget {

  final int id;

  const MovieDetailsView({Key key, this.id}) : super(key: key);

  @override
  _MovieDetailsViewState createState() => _MovieDetailsViewState();
}

class _MovieDetailsViewState extends State<MovieDetailsView> {

  MovieDetailsBloc bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<MovieDetailsBloc>(context);
    bloc.add(FetchDataMovieDetailsEvent(movieID: widget.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
      builder: (context, state){
        if(state is MovieDetailsFetchSuccess){
          return Column(
            children: [
              Row(
                children: [

                  // Ratings
                  Expanded(
                    child: Column(
                      children: [

                        // Ratings (Label)
                        Text(
                          "Ratings".toUpperCase(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: headerTextColor
                          ),
                        ),

                        SizedBox(
                          height: 5,
                        ),

                        // Ratings
                        Text(
                          state.movieDetails[0].ratings.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: goldColor
                          ),
                        ),

                      ],
                    ),
                  ),

                  // Release Year
                  Expanded(
                    child: Column(
                      children: [

                        // Release Year (Label)
                        Text(
                          "Release Year".toUpperCase(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: headerTextColor
                          ),
                        ),

                        SizedBox(
                          height: 5,
                        ),

                        // Release Year
                        Text(
                          state.movieDetails[0].releaseYear.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: goldColor
                          ),
                        ),

                      ],
                    ),
                  ),

                  // Duration
                  Expanded(
                    child: Column(
                      children: [

                        // Duration (Label)
                        Text(
                          "Duration".toUpperCase(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: headerTextColor
                          ),
                        ),

                        SizedBox(
                          height: 5,
                        ),

                        // Duration
                        Text(
                          state.movieDetails[0].duration.toString()+" min",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: goldColor
                          ),
                        ),

                      ],
                    ),
                  )

                ],
              ),

              SizedBox(height: 15,),

              Container(
                height: 60,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.zero,
                  itemCount: state.movieDetails[0].genres.length,
                  itemBuilder: (context, index){
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            child: Text(
                              state.movieDetails[0].genres[index]['name'].toString().toUpperCase(),
                              textScaleFactor: 0.9,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          );
        }
        else{
          return Container();
        }
      },
    );
  }
}
