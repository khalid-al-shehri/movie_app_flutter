import 'package:flutter/material.dart';
import 'package:movie_app_sdaia/colors.dart';
import 'package:movie_app_sdaia/helper_methods/SQFLite_helper.dart';

class FavoriteButton extends StatefulWidget {

  final int movieID;
  final String movieName;
  final String moviePoster;

  const FavoriteButton({Key key, this.movieID, this.movieName, this.moviePoster}) : super(key: key);

  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {

  SQFLite_helper sqfLite_helper = SQFLite_helper();

  addToFavorite(){
    sqfLite_helper.insertFavorite(
      movieId: widget.movieID,
      movieName: widget.movieName,
      moviePoster: widget.moviePoster
    );
  }

  removeFromFavorite(){
    sqfLite_helper.removeFavorite(
      movieId: widget.movieID
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: sqfLite_helper.isFavorite(movieID: widget.movieID),
      builder: (context, response){
        return IconButton(
          icon: Icon(
            response.data == true ? Icons.favorite : Icons.favorite_border,
            color: response.data == true ? Colors.red[600] : headerTextColor,
          ),
          onPressed: (){
            response.data == true ? removeFromFavorite() : addToFavorite();
            setState(() {});
          },
        );
      },
    );
  }
}
