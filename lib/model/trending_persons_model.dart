class TrendingPersonsModel {
  String profilePath;
  String knownForDepartment;
  bool adult;
  String name;
  int gender;
  int id;
  double popularity;
  String mediaType;

  TrendingPersonsModel(
      {this.profilePath,
        this.knownForDepartment,
        this.adult,
        this.name,
        this.gender,
        this.id,
        this.popularity,
        this.mediaType});

  TrendingPersonsModel.fromJson(Map<String, dynamic> json) {
    profilePath = json['profile_path'];
    knownForDepartment = json['known_for_department'];
    adult = json['adult'];
    name = json['name'];
    gender = json['gender'];
    id = json['id'];
    popularity = json['popularity'];
    mediaType = json['media_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['profile_path'] = this.profilePath;
    data['known_for_department'] = this.knownForDepartment;
    data['adult'] = this.adult;
    data['name'] = this.name;
    data['gender'] = this.gender;
    data['id'] = this.id;
    data['popularity'] = this.popularity;
    data['media_type'] = this.mediaType;
    return data;
  }
}
