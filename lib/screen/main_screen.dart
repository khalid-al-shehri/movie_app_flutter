import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_app_sdaia/bloc/Providers.dart';
import 'package:movie_app_sdaia/colors.dart';
import 'package:movie_app_sdaia/screen/search_screen.dart';
import 'package:movie_app_sdaia/widgets/genre_view.dart';
import 'package:movie_app_sdaia/widgets/top_10_movies_view.dart';
import 'package:movie_app_sdaia/widgets/top_rated_movies_view.dart';
import 'package:movie_app_sdaia/widgets/trending_persons_view.dart';

class MainScreen extends StatefulWidget {

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with SingleTickerProviderStateMixin{

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkColor,
        title: Row(
          children: [
            Expanded(
              flex: 1,
              child: IconButton(
                icon: Icon(
                    Icons.menu
                ),
                onPressed: (){
                  print("hi");
                },
              ),
            ),

            Expanded(
              flex: 6,
              child: Center(
                child: Text("Movie App"),
              ),
            ),

            Expanded(
              flex: 1,
              child: IconButton(
                icon: Icon(
                    Icons.search
                ),
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context){
                        return Providers().getSearchProvider(
                            child: SearchScreen()
                        );
                      }
                    )
                  );
                },
              ),
            ),
          ],
        ),
      ),
      body: Center(
        child: Container(
          height: size.height,
          color: darkColor,
          child: SingleChildScrollView(
            child: Column(
              children: [

                // Top 10 Movies
                Top10Movies(),

                // Genre
                GenresView(),

                // Top Actors
                Container(
                  height: size.height * 0.19,
                  decoration: BoxDecoration(
                      color: darkColor
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header (Trending persons on this week)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                        child: Container(
                          child: Text(
                            "Trending persons on this week".toUpperCase(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: headerTextColor
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: TrendingPersonsView(),
                      )
                    ],
                  ),
                ),

                // Top Rated Movies
                Container(
                  height: size.height * 0.37,
                  decoration: BoxDecoration(
                      color: darkColor
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header (Trending persons on this week)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                        child: Container(
                          child: Text(
                            "Top Rated Movies".toUpperCase(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: headerTextColor
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: TopRatedMoviesView(),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
