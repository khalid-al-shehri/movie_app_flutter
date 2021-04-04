import 'package:equatable/equatable.dart';
import 'package:movie_app_sdaia/model/trending_persons_model.dart';

class TrendingPersonsState extends Equatable{
  @override
  List<Object> get props => [];

}

class TrendingPersonsInitialState extends TrendingPersonsState {}

class TrendingPersonsLoadingState extends TrendingPersonsState {}

class TrendingPersonsFetchSuccess extends TrendingPersonsState{

  List<TrendingPersonsModel> trendingPersons;
  TrendingPersonsFetchSuccess({this.trendingPersons});

}

class TrendingPersonsErrorState extends TrendingPersonsState{
  String message;
  TrendingPersonsErrorState({this.message});
}