import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_sdaia/bloc/casts_bloc/casts_bloc.dart';
import 'package:movie_app_sdaia/bloc/casts_bloc/casts_event.dart';
import 'package:movie_app_sdaia/bloc/casts_bloc/casts_state.dart';
import 'package:movie_app_sdaia/bloc/trending_persons_bloc/trending_persons_bloc.dart';
import 'package:movie_app_sdaia/bloc/trending_persons_bloc/trending_persons_event.dart';
import 'package:movie_app_sdaia/bloc/trending_persons_bloc/trending_persons_state.dart';
import 'package:movie_app_sdaia/colors.dart';
import 'package:movie_app_sdaia/custom_widgets/no_internet.dart';
import 'package:movie_app_sdaia/custom_widgets/place_holder.dart';

class CastsView extends StatefulWidget {

  final int movieID;

  const CastsView({Key key, this.movieID}) : super(key: key);

  @override
  _CastsViewState createState() => _CastsViewState();
}

class _CastsViewState extends State<CastsView> {

  CastsBloc bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<CastsBloc>(context);
    bloc.add(FetchDataCastsEvent(movieID: widget.movieID));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BlocBuilder<CastsBloc, CastsState>(
      builder: (context, state){
        if(state is CastsInitialState){
          return PlaceHolder();
        }
        else if(state is CastsLoadingState){
          return PlaceHolder();
        }
        else if(state is CastsFetchSuccess){
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: state.casts.length,
            itemBuilder: (context, index){
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: size.width * 0.24,
                  child: Column(
                    children: [
                      state.casts[index].profilePath == null ?
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: headerTextColor
                        ),
                        child: Icon(
                          Icons.person,
                          size: 60,
                        ),
                      )
                          :
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(
                          "https://image.tmdb.org/t/p/w300/"+state.casts[index].profilePath,
                        ),
                      ),

                      SizedBox(height: 10,),
                      Text(
                        state.casts[index].name,
                        textAlign: TextAlign.center,
                        textScaleFactor: 0.8,
                        style: TextStyle(
                          color: Colors.white
                        ),
                      ),
                      SizedBox(height: 5,),
                      Text(
                        state.casts[index].character,
                        textAlign: TextAlign.center,
                        textScaleFactor: 0.7,
                        style: TextStyle(
                          color: headerTextColor
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
        else if(state is CastsErrorState){
          return state.message == "NO_INTERNET" ? NoInternet() : Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              state.message,
              style: TextStyle(
                  color: Colors.red
              ),
            ),
          );;
        }
        else{
          return Container();
        }
      },
    );
  }
}
