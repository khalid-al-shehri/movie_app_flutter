import 'package:flutter/material.dart';

class SearchField extends StatefulWidget {

  final bool isOpen;

  const SearchField({
    Key key,
    this.isOpen = false,
  }) : super(key: key);

  @override
  _SearchFieldState createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> with SingleTickerProviderStateMixin{
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black38
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: AnimatedSize(
          vsync: this,
          duration: Duration(milliseconds: 500),
          curve: Curves.fastOutSlowIn,
          child: Container(
            child: Container(
                child: widget.isOpen
                    ?
                TextField(
                  onTap: (){
                    print("khaled");
                  },
                )
                    :
                Container()
            ),
          ),
        ),
      )
    );
  }
}
