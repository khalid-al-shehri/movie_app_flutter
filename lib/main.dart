import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_sdaia/bloc/casts_bloc/casts_bloc.dart';
import 'package:movie_app_sdaia/bloc/casts_bloc/casts_state.dart';
import 'package:movie_app_sdaia/bloc/genre_bloc/genre_bloc.dart';
import 'package:movie_app_sdaia/bloc/movie_by_genre_bloc/movie_by_genre_bloc.dart';
import 'package:movie_app_sdaia/bloc/movie_by_genre_bloc/movie_by_genre_state.dart';
import 'package:movie_app_sdaia/bloc/movie_details_bloc/movie_details_bloc.dart';
import 'package:movie_app_sdaia/bloc/movie_details_bloc/movie_details_state.dart';
import 'package:movie_app_sdaia/bloc/top_rated_movies/top_rated_movies_bloc.dart';
import 'package:movie_app_sdaia/bloc/top_rated_movies/top_rated_movies_state.dart';
import 'package:movie_app_sdaia/bloc/trending_persons_bloc/trending_persons_bloc.dart';
import 'package:movie_app_sdaia/bloc/trending_persons_bloc/trending_persons_state.dart';
import 'package:movie_app_sdaia/repository/repository.dart';
import 'package:movie_app_sdaia/screen/main_screen.dart';
import 'bloc/genre_bloc/genre_state.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MultiBlocProvider(
        providers: [
          BlocProvider<GenreBloc>(create: (context) => GenreBloc(GenreInitialState(), Repository())),
          BlocProvider<MovieByGenreBloc>(create: (context) => MovieByGenreBloc(MovieByGenreInitialState(), Repository())),
          BlocProvider<TrendingPersonsBloc>(create: (context) => TrendingPersonsBloc(TrendingPersonsInitialState(), Repository())),
          BlocProvider<TopRatedMoviesBloc>(create: (context) => TopRatedMoviesBloc(TopRatedMoviesInitialState(), Repository())),
        ],
        child: MainScreen(),
      ),
    )
  );
}
