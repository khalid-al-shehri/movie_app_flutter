# Movie App Flutter

## Application Idea :

This application showing a list of movies and more details about each movie, and user can search about his/her interest. Also the user can share movie trailer with friends and add movies to his/her list of favourite movies.

## Screenshots of application :

![alt text](https://github.com/khalid-al-shehri/movie_app_flutter/blob/master/screenshot/mockup_1.jpg?raw=true)
![alt text](https://github.com/khalid-al-shehri/movie_app_flutter/blob/master/screenshot/mockup_2.jpg?raw=true)

## Featchers :

* Browse list of movies.
* Browse list of casts in each movie.
* Browse similar movies.
* Share movies' trailer.
* Add movies to his/her favourite list.
* Search for movies, persons or genre.
* Searches history.
* User can delete search history.
* Watch trailer for movies.

## Design pattern & state management :
The design pattern used is BLoc, Bloc makes it easy to separate presentation from business logic, making your code fast, easy to test, and reusable.
[More details about BLoc](https://bloclibrary.dev/#/whybloc)

## Libraries :
* ***flutter_bloc:*** used for design pattern and state management [read more](https://pub.dev/packages/flutter_bloc).
* ***equatable:*** used to compare objects [read more](https://pub.dev/packages/equatable).
* ***http:*** used to consume HTTP resources [read more](https://pub.dev/packages/http).
* ***share:*** used to share texts to other channels like whatsapp ,instagram and ... [read more](https://pub.dev/packages/share).
* ***sqflite:*** used to deal with SQLite (Locally storage), insert, delete, read and update data in local database [read more](https://pub.dev/packages/sqflite).
* ***connectivity:*** used to check of internet connection [read more](https://pub.dev/packages/connectivity).
* ***youtube_player_flutter:*** used to watch videos from youtube without exit of your application (Video player) [read more](https://pub.dev/packages/youtube_player_flutter).

## Tasks :
- [x] 1. Main Screen:
    - [x] a. A slider for top 10 movies
    - [x] b. Tabs of different genres (Action, Drama, etc..) each tab contain the movies inside that genre
    - [x] c. A trending persons list
    - [x] d. Top Rated List
    - [x] e. Search button
- [x] 2. Movie Details Screen:
    - [x] a. Image cover
    - [x] b. Overview
    - [x] c. Details (ratings, release year, duration)
    - [x] d. List of actors
    - [x] e. Similar movies
    - [x] f. A button to play the video of the movie if available
    - [x] g. A button to add the movie to a favorite list, the list should be stored locally.
    - [x] h. A button to share the movie link via external apps.
- [x] 3. Search screen:
    - [x] a. A text area for the searched text
    - [x] b. A list of the search history when the user did not start the search request.
    - [x] c. The list of the movies (result of the search)
    - [x] d. A placeholder while searching
    - [x] e. A placeholder if there is no result.
    - [x] f. Search button

<br/>
<br/>

![Alt Text](https://media4.giphy.com/media/3ohs86vZAWiJXWvQI0/source.gif)
