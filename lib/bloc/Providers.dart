import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_sdaia/bloc/casts_bloc/casts_bloc.dart';
import 'package:movie_app_sdaia/bloc/movie_details_bloc/movie_details_bloc.dart';
import 'package:movie_app_sdaia/bloc/movie_details_bloc/movie_details_state.dart';
import 'package:movie_app_sdaia/bloc/search_bloc/search_bloc.dart';
import 'package:movie_app_sdaia/bloc/search_bloc/search_state.dart';
import 'package:movie_app_sdaia/bloc/similar_movies_bloc/similar_movies_bloc.dart';
import 'package:movie_app_sdaia/bloc/similar_movies_bloc/similar_movies_state.dart';
import 'package:movie_app_sdaia/bloc/video_bloc/video_bloc.dart';
import 'package:movie_app_sdaia/bloc/video_bloc/video_state.dart';
import 'package:movie_app_sdaia/repository/repository.dart';

import 'casts_bloc/casts_state.dart';

class Providers{

  MultiBlocProvider getMovieDetailsProvider({Widget child}){
    return MultiBlocProvider(
      providers: [
        BlocProvider<MovieDetailsBloc>(create: (context) => MovieDetailsBloc(MovieDetailsInitialState(), Repository())),
        BlocProvider<CastsBloc>(create: (context) => CastsBloc(CastsInitialState(), Repository())),
        BlocProvider<SimilarMoviesBloc>(create: (context) => SimilarMoviesBloc(SimilarMoviesInitialState(), Repository())),
        BlocProvider<VideoBloc>(create: (context) => VideoBloc(VideoInitialState(), Repository())),
      ],
      child: child,
    );
  }

  MultiBlocProvider getSearchProvider({Widget child}){
    return MultiBlocProvider(
      providers: [
        BlocProvider<SearchBloc>(create: (context) => SearchBloc(SearchInitialState(), Repository())),
      ],
      child: child,
    );
  }

}