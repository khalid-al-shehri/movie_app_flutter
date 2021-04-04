import 'package:flutter/material.dart';

class NoInternet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.wifi_off,
          size: 20,
          color: Colors.red[600],
        ),

        SizedBox(width: 15,),

        Text(
          "No internet connection, please check your connectivity",
          style: TextStyle(
            color: Colors.red[600],
          ),
        )
      ],
    );
  }
}
