import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_sdaia/bloc/genre_bloc/genre_bloc.dart';
import 'package:movie_app_sdaia/bloc/genre_bloc/genre_event.dart';
import 'package:movie_app_sdaia/bloc/genre_bloc/genre_state.dart';
import 'package:movie_app_sdaia/colors.dart';
import 'package:movie_app_sdaia/widgets/movie_by_genre_view.dart';

class GenresView extends StatefulWidget {
  @override
  _GenresViewState createState() => _GenresViewState();
}

class _GenresViewState extends State<GenresView> with SingleTickerProviderStateMixin{

  GenreBloc bloc;
  TabController _tabController;


  @override
  void initState() {
    bloc = BlocProvider.of<GenreBloc>(context);
    bloc.add(FetchDataGenreEvent());
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return BlocBuilder<GenreBloc, GenreState>(
      builder: (context, state){
        if(state is GenreInitialState){
          return Center(
            child: Container(
              padding: EdgeInsets.all(10),
              height: 25,
              width: 25,
              child: CircularProgressIndicator(),
            ),
          );
        }
        else if(state is GenreLoadingState){
          return Center(
            child: Container(
              padding: EdgeInsets.all(10),
              height: 25,
              width: 25,
              child: CircularProgressIndicator(),
            ),
          );
        }
        else if(state is GenreFetchSuccess){
          return Container(
              height: size.height * 0.38,
              child: DefaultTabController(
                length: state.genres.length,
                child: Scaffold(
                  backgroundColor: dark,
                  appBar: PreferredSize(
                    preferredSize: Size.fromHeight(50.0),
                    child: AppBar(
                      backgroundColor: dark,
                      bottom: TabBar(
                          controller: _tabController,
                          indicatorColor: gold,
                          indicatorSize: TabBarIndicatorSize.tab,
                          indicatorWeight: 3.0,
                          unselectedLabelColor: Colors.white.withOpacity(0.30),
                          labelColor: Colors.white,
                          isScrollable: true,
                          tabs: List.generate(state.genres.length, (index){
                            return Container(
                                padding: EdgeInsets.only(bottom: 15.0, top: 10.0),
                                child: new Text(
                                    state.genres[index].name.toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold,
                                    )
                                )
                            );
                          })
                      ),
                    ),
                  ),

                  body: TabBarView(
                    controller: _tabController,
                    physics: NeverScrollableScrollPhysics(),
                    children: List.generate(state.genres.length, (index){
                      return MovieByGenreView(
                        genreID: state.genres[index].id,
                      );
                    }),
                  ),
                ),
              )
          );
        }
        else if(state is GenreErrorState){
          return Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              state.message,
              style: TextStyle(
                  color: Colors.red
              ),
            ),
          );
        }
        else{
          return Container();
        }
      },
    );
  }
}
