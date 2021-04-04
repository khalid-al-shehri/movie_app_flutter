import 'package:equatable/equatable.dart';

class CastsEvent extends Equatable{
  @override
  List<Object> get props => [];

}

class FetchDataCastsEvent extends CastsEvent{
  final int movieID;

  FetchDataCastsEvent({this.movieID});
}