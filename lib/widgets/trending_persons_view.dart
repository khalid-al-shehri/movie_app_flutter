import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_sdaia/bloc/trending_persons_bloc/trending_persons_bloc.dart';
import 'package:movie_app_sdaia/bloc/trending_persons_bloc/trending_persons_event.dart';
import 'package:movie_app_sdaia/bloc/trending_persons_bloc/trending_persons_state.dart';
import 'package:movie_app_sdaia/colors.dart';
import 'package:movie_app_sdaia/custom_widgets/no_internet.dart';
import 'package:movie_app_sdaia/custom_widgets/place_holder.dart';

class TrendingPersonsView extends StatefulWidget {
  @override
  _TrendingPersonsViewState createState() => _TrendingPersonsViewState();
}

class _TrendingPersonsViewState extends State<TrendingPersonsView> {

  TrendingPersonsBloc bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<TrendingPersonsBloc>(context);
    bloc.add(FetchDataTrendingPersonsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BlocBuilder<TrendingPersonsBloc, TrendingPersonsState>(
      builder: (context, state){
        if(state is TrendingPersonsInitialState){
          return PlaceHolder();
        }
        else if(state is TrendingPersonsLoadingState){
          return PlaceHolder();
        }
        else if(state is TrendingPersonsFetchSuccess){
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: state.trendingPersons.length,
            itemBuilder: (context, index){
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: size.width * 0.24,
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(
                          "https://image.tmdb.org/t/p/w300/"+state.trendingPersons[index].profilePath,
                        ),
                      ),

                      SizedBox(height: 10,),
                      Text(
                        state.trendingPersons[index].name,
                        textAlign: TextAlign.center,
                        textScaleFactor: 0.8,
                        style: TextStyle(
                          color: Colors.white
                        ),
                      ),
                      SizedBox(height: 5,),
                      Text(
                        "Trending for acting",
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
        else if(state is TrendingPersonsErrorState){
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
