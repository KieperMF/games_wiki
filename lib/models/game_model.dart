class GameModel {
  int? id;
  String? name;
  String? released;
  String? backgroundImage;
  List<String>? plataformNames;
  int? rating;
  String? requirementsMinimum;
  String? requirementsRecommended;
  List<String>? genres;

  GameModel(
      {this.id ,this.name, 
      this.genres,
      this.backgroundImage, 
      this.released, 
      this.plataformNames, 
      this.rating, 
      this.requirementsMinimum, 
      this.requirementsRecommended});

  factory GameModel.allGameFromJson(Map<String, dynamic> json) {
    List<dynamic>? platformsJson = json['platforms'];
    List<dynamic>? genresJson = json['genres'];
    

    List<String>? genresForm = genresJson!
        .map((e) {
          return e['name'];
        })
        .cast<String>()
        .toList();

    List<String>? platformNames = platformsJson!
        .map((platform) {
          return platform['platform']['name'];
        })
        .cast<String>()
        .toList();

    String? recommended = "No Data";
  String? minimum = "No Data";

  if (platformsJson.isNotEmpty) {
    Map<String, dynamic>? firstPlatform = platformsJson[0];
    if (firstPlatform?['requirements_en'] != null) {
      recommended = firstPlatform!['requirements_en']['recommended'];
      minimum = firstPlatform['requirements_en']['minimum'];
    }
  }

    return GameModel(
      id: json['id'],
        name: json['name'],
        released: json['released'],
        backgroundImage: json['background_image'],
        rating: json['metacritic'],
        genres: genresForm,
        requirementsMinimum: minimum ?? "No Data",
        requirementsRecommended: recommended ?? "No Data",
        plataformNames: platformNames);
  }
}
