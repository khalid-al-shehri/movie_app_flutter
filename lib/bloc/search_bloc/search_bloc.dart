import 'package:connectivity/connectivity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_sdaia/bloc/search_bloc/search_event.dart';
import 'package:movie_app_sdaia/bloc/search_bloc/search_state.dart';
import 'package:movie_app_sdaia/repository/repository.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState>{
  Repository repo;
  SearchBloc(SearchState initialState, this.repo) : super(initialState);

  @override
  Stream<SearchState> mapEventToState(SearchEvent event) async*{

    if(event is FetchDataSearchEvent){
      yield SearchLoadingState();
      try{
        var connectivityResult = await (Connectivity().checkConnectivity());
        if (connectivityResult != ConnectivityResult.mobile && connectivityResult != ConnectivityResult.wifi) {
          yield SearchErrorState(message: "NO_INTERNET");
        }else {
          var search = await repo.search(event.searchValue);
          yield SearchFetchSuccess(search: search);
        }
      }catch(e){
        print(e.toString());
        yield SearchErrorState(message: e.toString());
      }
    }

  }



}