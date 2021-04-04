import 'package:connectivity/connectivity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_sdaia/bloc/trending_persons_bloc/trending_persons_event.dart';
import 'package:movie_app_sdaia/bloc/trending_persons_bloc/trending_persons_state.dart';
import 'package:movie_app_sdaia/repository/repository.dart';

class TrendingPersonsBloc extends Bloc<TrendingPersonsEvent, TrendingPersonsState>{
  Repository repo;
  TrendingPersonsBloc(TrendingPersonsState initialState, this.repo) : super(initialState);

  @override
  Stream<TrendingPersonsState> mapEventToState(TrendingPersonsEvent event) async*{

    if(event is FetchDataTrendingPersonsEvent){
      yield TrendingPersonsLoadingState();
      try{
        var connectivityResult = await (Connectivity().checkConnectivity());
        if (connectivityResult != ConnectivityResult.mobile && connectivityResult != ConnectivityResult.wifi) {
          yield TrendingPersonsErrorState(message: "NO_INTERNET");
        }else {
          var trendingPersonss = await repo.getTrendingPersons();
          yield TrendingPersonsFetchSuccess(trendingPersons: trendingPersonss);
        }
      }catch(e){
        print(e.toString());
        yield TrendingPersonsErrorState(message: e.toString());
      }
    }

  }



}