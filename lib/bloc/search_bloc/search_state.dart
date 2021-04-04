import 'package:equatable/equatable.dart';
import 'package:movie_app_sdaia/model/movie_model.dart';

class SearchState extends Equatable{
  @override
  List<Object> get props => [];

}

class SearchInitialState extends SearchState {}

class SearchLoadingState extends SearchState {}

class SearchFetchSuccess extends SearchState{

  List<MovieModel> search;
  SearchFetchSuccess({this.search});

}

class SearchErrorState extends SearchState{
  String message;
  SearchErrorState({this.message});
}