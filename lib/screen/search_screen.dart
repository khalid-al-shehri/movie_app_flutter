import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_sdaia/bloc/search_bloc/search_bloc.dart';
import 'package:movie_app_sdaia/bloc/search_bloc/search_event.dart';
import 'package:movie_app_sdaia/colors.dart';
import 'package:movie_app_sdaia/helper_methods/SQFLite_helper.dart';
import 'package:movie_app_sdaia/widgets/list_search_view.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  SearchBloc bloc;

  bool showSearchHistory = true;

  SQFLite_helper sqfLite_helper = SQFLite_helper();

  TextEditingController searchController = TextEditingController();

  saveSearchInLocal() async{
    await sqfLite_helper.insertSearch(searchValue: searchController.text);
  }

  removeSearchFromLocal(int searchID) async {
    await sqfLite_helper.removeSearch(searchId: searchID);
    setState(() {});
  }

  search(){
    setState(() {showSearchHistory = false;});
    if(searchController.text.length > 0){
      FocusScope.of(context).unfocus();
      bloc.add(FetchDataSearchEvent(searchValue: searchController.text));
    }
  }

  @override
  void initState() {
    bloc = BlocProvider.of<SearchBloc>(context);
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkColor,
        title: Text(
          "Search"
        ),
      ),
      backgroundColor: darkColor,
      body: Column(
        children: [

          TextField(
            controller: searchController,
            style: TextStyle(
              color: Colors.white
            ),
            onSubmitted: (value){
              search();
              saveSearchInLocal();
            },
            onChanged: (value){
              if(value.length == 0){
                setState(() {
                  showSearchHistory = true;
                });
              }
            },
            decoration: InputDecoration(
              hintText: "Search about movies",
              hintStyle: TextStyle(
                color: Colors.white.withOpacity(0.25)
              ),
              filled: true,
              fillColor: headerTextColor,
              prefixIcon: IconButton(
                icon: Icon(
                  Icons.search
                ),
                color: Colors.white.withOpacity(0.60),
                onPressed: (){
                  search();
                  saveSearchInLocal();
                },
              ),
            ),
          ),

          showSearchHistory == false
              ?
          Expanded(
            child: ListSearchView(),
          )
              :
          Expanded(
            child: FutureBuilder(
              future: sqfLite_helper.getAllSearch(),
              builder: (context, response){
                if(response.hasData){
                  if(response.data.length > 0){

                    return ListView.builder(
                      itemCount: response.data.length,
                      itemBuilder: (context, index){
                        return Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  flex: 6,
                                  child: RawMaterialButton(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.history,
                                            color: headerTextColor,
                                            size: 35,
                                          ),

                                          SizedBox(width: 15,),

                                          Text(
                                            response.data[(response.data.length - 1) - index]['SearchValue'],
                                            style: TextStyle(
                                                color: Colors.white
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    onPressed: (){
                                      setState(() {
                                        searchController.text = response.data[(response.data.length - 1) - index]['SearchValue'];
                                      });
                                      search();
                                    },
                                  ),
                                ),

                                Expanded(
                                  flex: 1,
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.cancel_outlined,
                                      color: headerTextColor,
                                    ),
                                    onPressed: (){
                                      removeSearchFromLocal(response.data[(response.data.length - 1) - index]['ID']);
                                    },
                                  ),
                                )

                              ],
                            )
                          ],
                        );
                      },
                    );
                  }
                  else{
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.history,
                            size: 85,
                            color: headerTextColor,
                          ),

                          SizedBox(height: 10,),

                          Text(
                            "No history of searches",
                            textScaleFactor: 1.3,
                            style: TextStyle(
                                color: Colors.white
                            ),
                          ),
                        ],
                      )
                    );
                  }
                }
                else{
                  return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.history,
                            size: 85,
                            color: headerTextColor,
                          ),

                          SizedBox(height: 10,),

                          Text(
                            "No history of searches",
                            textScaleFactor: 1.3,
                            style: TextStyle(
                                color: Colors.white
                            ),
                          ),
                        ],
                      )
                  );
                }
              },
            ),
          )
        ],
      )
    );
  }
}
