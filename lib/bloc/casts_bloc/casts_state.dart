import 'package:equatable/equatable.dart';
import 'package:movie_app_sdaia/model/casts_model.dart';

class CastsState extends Equatable{
  @override
  List<Object> get props => [];

}

class CastsInitialState extends CastsState {}

class CastsLoadingState extends CastsState {}

class CastsFetchSuccess extends CastsState{

  List<CastsModel> casts;
  CastsFetchSuccess({this.casts});

}

class CastsErrorState extends CastsState{
  String message;
  CastsErrorState({this.message});
}