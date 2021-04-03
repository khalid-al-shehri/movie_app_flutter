import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_sdaia/bloc/genre_bloc/genre_bloc.dart';
import 'package:movie_app_sdaia/bloc/movie_by_genre_bloc/movie_by_genre_bloc.dart';
import 'package:movie_app_sdaia/bloc/movie_by_genre_bloc/movie_by_genre_state.dart';
import 'package:movie_app_sdaia/repository/repository.dart';
import 'package:movie_app_sdaia/screen/mainScreen.dart';
import 'package:movie_app_sdaia/widgets/searchField.dart';

import 'bloc/genre_bloc/genre_state.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MultiBlocProvider(
        providers: [
          BlocProvider<GenreBloc>( create: (context) => GenreBloc(GenreInitialState(), Repository())),
          BlocProvider<MovieByGenreBloc>( create: (context) => MovieByGenreBloc(MovieByGenreInitialState(), Repository())),
        ],
        child: MainScreen(),
      ),
    )
  );
}
