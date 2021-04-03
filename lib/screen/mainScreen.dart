import 'package:flutter/material.dart';
import 'package:movie_app_sdaia/colors.dart';
import 'package:movie_app_sdaia/widgets/genre_view.dart';
import 'package:movie_app_sdaia/widgets/searchField.dart';

class MainScreen extends StatefulWidget {

  String id = "MainScreen";

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with SingleTickerProviderStateMixin{

  bool isSearchBarOpen = false;

  openSearchBar(){
    setState(() {
      isSearchBarOpen = !isSearchBarOpen;
    });
  }

  List postersList = [
    {
      "image" : "https://play-lh.googleusercontent.com/proxy/vPiJMrKpQokbzucJPjllKY73ud9TzQBRCCOnxeDVlN8GKWfFDY2oxcMK_aPTKWo8OQZEVMDiG3rtoH9Y1DR6SnHYvBngCnOtkxKcIhIxrLU3upvHErOmcaKWGQ=w720-h405-rw",
      "title" : "Tom & Jerry 1",
    },
    {
      "image" : "https://play-lh.googleusercontent.com/proxy/vPiJMrKpQokbzucJPjllKY73ud9TzQBRCCOnxeDVlN8GKWfFDY2oxcMK_aPTKWo8OQZEVMDiG3rtoH9Y1DR6SnHYvBngCnOtkxKcIhIxrLU3upvHErOmcaKWGQ=w720-h405-rw",
      "title" : "Tom & Jerry 2",
    },
    {
      "image" : "https://play-lh.googleusercontent.com/proxy/vPiJMrKpQokbzucJPjllKY73ud9TzQBRCCOnxeDVlN8GKWfFDY2oxcMK_aPTKWo8OQZEVMDiG3rtoH9Y1DR6SnHYvBngCnOtkxKcIhIxrLU3upvHErOmcaKWGQ=w720-h405-rw",
      "title" : "Tom & Jerry 3",
    },
    {
      "image" : "https://play-lh.googleusercontent.com/proxy/vPiJMrKpQokbzucJPjllKY73ud9TzQBRCCOnxeDVlN8GKWfFDY2oxcMK_aPTKWo8OQZEVMDiG3rtoH9Y1DR6SnHYvBngCnOtkxKcIhIxrLU3upvHErOmcaKWGQ=w720-h405-rw",
      "title" : "Tom & Jerry 4",
    }
  ];

  PageController _pageController = PageController();
  int imageInShow = 0;


  List listOfActors = [
    {
      "name": "Khalid",
      "title": "Mobile application developer",
      "image": "https://api.time.com/wp-content/uploads/2017/12/terry-crews-person-of-year-2017-time-magazine-2.jpg"
    },
    {
      "name": "Khalid",
      "title": "Mobile application developer",
      "image": "https://api.time.com/wp-content/uploads/2017/12/terry-crews-person-of-year-2017-time-magazine-2.jpg"
    },
    {
      "name": "Khalid",
      "title": "Mobile application developer",
      "image": "https://api.time.com/wp-content/uploads/2017/12/terry-crews-person-of-year-2017-time-magazine-2.jpg"
    },
    {
      "name": "Khalid",
      "title": "Mobile application developer",
      "image": "https://api.time.com/wp-content/uploads/2017/12/terry-crews-person-of-year-2017-time-magazine-2.jpg"
    },
    {
      "name": "Khalid",
      "title": "Mobile application developer",
      "image": "https://api.time.com/wp-content/uploads/2017/12/terry-crews-person-of-year-2017-time-magazine-2.jpg"
    },
    {
      "name": "Khalid",
      "title": "Mobile application developer",
      "image": "https://api.time.com/wp-content/uploads/2017/12/terry-crews-person-of-year-2017-time-magazine-2.jpg"
    },
    {
      "name": "Khalid",
      "title": "Mobile application developer",
      "image": "https://api.time.com/wp-content/uploads/2017/12/terry-crews-person-of-year-2017-time-magazine-2.jpg"
    },
    {
      "name": "Khalid",
      "title": "Mobile application developer",
      "image": "https://api.time.com/wp-content/uploads/2017/12/terry-crews-person-of-year-2017-time-magazine-2.jpg"
    },
    {
      "name": "Khalid",
      "title": "Mobile application developer",
      "image": "https://api.time.com/wp-content/uploads/2017/12/terry-crews-person-of-year-2017-time-magazine-2.jpg"
    },
    {
      "name": "Khalid",
      "title": "Mobile application developer",
      "image": "https://api.time.com/wp-content/uploads/2017/12/terry-crews-person-of-year-2017-time-magazine-2.jpg"
    },
    {
      "name": "Khalid",
      "title": "Mobile application developer",
      "image": "https://api.time.com/wp-content/uploads/2017/12/terry-crews-person-of-year-2017-time-magazine-2.jpg"
    },
  ];

  @override
  void initState() {
    super.initState();

  }


  @override
  void dispose() {

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: dark,
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
                  openSearchBar();
                },
              ),
            ),
          ],
        ),
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            SearchField(
              isOpen: isSearchBarOpen,
            ),

            // Top 10 Movies
            Container(
                height: size.height * 0.30,
                child: Stack(
                  children: [
                    // Image Slider
                    PageView.builder(
                        onPageChanged: (value){
                          setState(() {
                            imageInShow = value;
                          });
                        },
                        controller: _pageController,
                        itemCount: postersList == null ? 0 : postersList.length,
                        itemBuilder: (context, index) {
                          return AnimatedBuilder(
                              animation: _pageController,
                              builder: (context, widget) {
                                return SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: widget,
                                );
                              },
                              child: Stack(
                                children: [

                                  Container(
                                      child: Image.network(
                                        postersList[index]['image'],
                                        fit: BoxFit.cover,
                                      )
                                  ),

                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Stack(
                                        children: [

                                          Container(
                                            decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                    begin: Alignment.bottomCenter,
                                                    end: Alignment.topCenter,
                                                    colors: [
                                                      dark,
                                                      Colors.transparent,
                                                    ],
                                                    stops: [
                                                      0.5,
                                                      0.9
                                                    ]
                                                )
                                            ),
                                            height: 80,
                                          ),

                                          Padding(
                                            padding: EdgeInsets.only(left: 15),
                                            child: Text(
                                              postersList[index]['title'],
                                              textScaleFactor: 1.6,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              )
                          );
                        }
                    ),

                    // Image tracker, points
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(postersList.length, (index){
                                return Container(
                                  margin: EdgeInsets.symmetric(horizontal: 5),
                                  height: 8,
                                  width: 8,
                                  decoration: BoxDecoration(
                                    color: index == imageInShow ? gold  : Colors.grey[500],
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 3.0,
                                        color: index == imageInShow ? gold : Colors.black.withOpacity(0.50),
                                        offset: Offset(0,0),
                                      ),
                                    ],
                                  ),
                                );
                              })
                          ),
                        ),
                      ],
                    )
                  ],
                ),
            ),

            // Genre
            GenresView(),

            // Top Actors
            Container(
              height: size.height * 0.30,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: listOfActors.length,
                itemBuilder: (context, index){
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: size.width * 0.20,
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(listOfActors[index]['image'],),
                          ),

                          SizedBox(height: 10,),
                          Text(listOfActors[index]['name']),
                          SizedBox(height: 5,),
                          Text(listOfActors[index]['title']),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            // Top Movies
            Container(
              height: size.height * 0.30,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: listOfActors.length,
                itemBuilder: (context, index){
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: size.width * 0.20,
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(listOfActors[index]['image'],),
                          ),

                          SizedBox(height: 10,),
                          Text(listOfActors[index]['name']),
                          SizedBox(height: 5,),
                          Text(listOfActors[index]['title']),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
