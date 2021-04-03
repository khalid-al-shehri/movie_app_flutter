import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_sdaia/bloc/genre_bloc/genre_bloc.dart';
import 'package:movie_app_sdaia/repository/repository.dart';
import 'package:movie_app_sdaia/screen/mainScreen.dart';
import 'package:movie_app_sdaia/widgets/searchField.dart';

import 'bloc/genre_bloc/genre_state.dart';

void main() {
  runApp(
    MaterialApp(
      home: BlocProvider(
        create: (context) => GenreBloc(InitialState(), Repository()),
        child: MainScreen(),
      ),
    )
  );
}