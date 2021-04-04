class MovieDetailsModel {
  int ratings;
  String releaseYear;
  int budget;
  int duration;
  List<dynamic> genres;
  String homePage;
  String title;

  MovieDetailsModel({this.budget, this.duration, this.genres, this.releaseYear, this.ratings, this.homePage, this.title});

  MovieDetailsModel.fromJson(Map<String, dynamic> json) {
    releaseYear = json['release_date'];
    budget = json['budget'];
    duration = json['runtime'];
    genres = json['genres'];
    ratings = json['vote_count'];
    homePage = json['homepage'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['release_date'] = this.releaseYear;
    data['budget'] = this.budget;
    data['runtime'] = this.duration;
    data['genres'] = this.genres;
    data['vote_count'] = this.ratings;
    data['homepage'] = this.homePage;
    data['title'] = this.title;
    return data;
  }
}
