import 'package:connectivity/connectivity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_sdaia/bloc/casts_bloc/casts_event.dart';
import 'package:movie_app_sdaia/bloc/casts_bloc/casts_state.dart';
import 'package:movie_app_sdaia/repository/repository.dart';

class CastsBloc extends Bloc<CastsEvent, CastsState>{
  Repository repo;
  CastsBloc(CastsState initialState, this.repo) : super(initialState);

  @override
  Stream<CastsState> mapEventToState(CastsEvent event) async*{

    if(event is FetchDataCastsEvent){
      yield CastsLoadingState();
      try{
        var connectivityResult = await (Connectivity().checkConnectivity());
        if (connectivityResult != ConnectivityResult.mobile && connectivityResult != ConnectivityResult.wifi) {
          yield CastsErrorState(message: "NO_INTERNET");
        }else {
          var casts = await repo.getCasts(event.movieID);
          yield CastsFetchSuccess(casts: casts);
        }
      }catch(e){
        print(e.toString());
        yield CastsErrorState(message: e.toString());
      }
    }

  }



}