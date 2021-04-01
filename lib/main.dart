import 'package:flutter/material.dart';
import 'package:movie_app_sdaia/widgets/searchField.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  bool isSearchBarOpen = false;

  openSearchBar(){
    setState(() {
      isSearchBarOpen = !isSearchBarOpen;
    });
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
        child: Column(
          children: <Widget>[
            SearchField(
              isOpen: isSearchBarOpen,
            ),
            Container(
              height: size.height * 0.30,
              child: Stack(
                children: [

                  Image.network(
                    "https://play-lh.googleusercontent.com/proxy/vPiJMrKpQokbzucJPjllKY73ud9TzQBRCCOnxeDVlN8GKWfFDY2oxcMK_aPTKWo8OQZEVMDiG3rtoH9Y1DR6SnHYvBngCnOtkxKcIhIxrLU3upvHErOmcaKWGQ=w720-h405-rw",
                    fit: BoxFit.cover,
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
                              "Tom & Jerry",
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
            )
          ],
        ),
      ),
    );
  }
}
