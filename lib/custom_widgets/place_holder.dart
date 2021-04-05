import 'package:flutter/material.dart';
import 'package:movie_app_sdaia/colors.dart';

class PlaceHolder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(10),
        height: 70,
        width: 70,
        child: CircularProgressIndicator(
          valueColor: new AlwaysStoppedAnimation<Color>(goldColor),
        ),
      ),
    );
  }
}
