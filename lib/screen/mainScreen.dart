import 'package:flutter/material.dart';
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

  TabController _tabController;

  List listOfGenre = [
    "Animation", "Crime", "Comedy", "Documentry", "Future"
  ];


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
    _tabController = TabController(vsync: this, length: listOfGenre.length);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        // moviesByGenreBloc..drainStream();
      }
    });
  }


  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
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
                                                      Colors.blueAccent,
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
                                    color: index == imageInShow ? Colors.white.withOpacity(0.65) : Colors.grey[500],
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 3.0,
                                        color: index == imageInShow ? Colors.white : Colors.black.withOpacity(0.50),
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
            Container(
                height: size.height * 0.35,
                child: DefaultTabController(
                  length: listOfGenre.length,
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
                          tabs: List.generate(listOfGenre.length, (index){
                            return Container(
                                padding: EdgeInsets.only(bottom: 15.0, top: 10.0),
                                child: new Text(listOfGenre[index].toUpperCase(),
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
                      children: List.generate(listOfGenre.length, (index){
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
            ),

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
