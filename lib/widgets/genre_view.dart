import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_sdaia/bloc/genre_bloc/genre_bloc.dart';
import 'package:movie_app_sdaia/bloc/genre_bloc/genre_event.dart';
import 'package:movie_app_sdaia/bloc/genre_bloc/genre_state.dart';

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

    return BlocBuilder<GenreBloc, GenreState>(
      builder: (context, state){
        if(state is InitialState){
          return CircularProgressIndicator();
        }
        else if(state is LoadingState){
          return CircularProgressIndicator();
        }
        else if(state is FetchSuccess){
          // setState(() {
          //   _tabController = TabController(vsync: this, length: state.genres.length);
          //   _tabController.addListener(() {
          //     if (_tabController.indexIsChanging) {
          //
          //     }
          //   });
          // });

          return Container(
              height: 300,
              child: DefaultTabController(
                length: state.genres.length,
                child: Scaffold(
                  backgroundColor: Colors.grey,
                  appBar: PreferredSize(
                    preferredSize: Size.fromHeight(50.0),
                    child: AppBar(
                      backgroundColor: Colors.grey,
                      bottom: TabBar(
                          controller: _tabController,
                          indicatorColor: Colors.red,
                          indicatorSize: TabBarIndicatorSize.tab,
                          indicatorWeight: 3.0,
                          unselectedLabelColor: Colors.white.withOpacity(0.30),
                          labelColor: Colors.white,
                          isScrollable: true,
                          tabs: List.generate(state.genres.length, (index){
                            return Container(
                                padding: EdgeInsets.only(bottom: 15.0, top: 10.0),
                                child: new Text(state.genres[index].name.toUpperCase(),
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
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 30,
                        itemBuilder: (context, index){
                          return Container(
                            height: 150,
                            color: Colors.green,
                            padding: EdgeInsets.symmetric(horizontal: 10, ),
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            child: Text("data"),
                          );
                        },
                      );
                    }),
                  ),
                ),
              )
          );
        }
        else if(state is ErrorState){
          return Text(
            state.message,
            style: TextStyle(
                color: Colors.red
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
