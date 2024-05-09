class GameModel {
  int? id;
  String? name;
  String? released;
  String? backgroundImage;
  List<String>? plataformNames;
  int? rating;

  GameModel(
      {this.id ,this.name, this.backgroundImage, this.released, this.plataformNames, this.rating});

  factory GameModel.allGameFromJson(Map<String, dynamic> json) {
    List<dynamic>? platformsJson = json['platforms'];

    List<String>? platformNames = platformsJson!
        .map((platform) {
          return platform['platform']['name'];
        })
        .cast<String>()
        .toList();

    return GameModel(
      id: json['id'],
        name: json['name'],
        released: json['released'],
        backgroundImage: json['background_image'],
        rating: json['metacritic'],
        plataformNames: platformNames);
  }
}
