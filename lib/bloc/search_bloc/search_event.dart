import 'package:equatable/equatable.dart';

class SearchEvent extends Equatable{
  @override
  List<Object> get props => [];

}

class FetchDataSearchEvent extends SearchEvent{
  final String searchValue;

  FetchDataSearchEvent({this.searchValue});
}