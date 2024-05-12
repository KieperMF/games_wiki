class CreatorsModel{
  String? name;
  String? image;
  List<String>? gamesMaded;
  List<String>? positions;
  int? gamesCount;

  CreatorsModel({
    this.gamesCount,
    this.gamesMaded,
    this.image,
    this.name,
    this.positions
  });

  factory CreatorsModel.fromJson(Map<String, dynamic> json){
    List<dynamic> positionsJson = json['positions'];
    List<dynamic> gamesJson = json['games'];

    List<String>? positi = positionsJson
        .map((e) {
          return e['name'];
        })
        .cast<String>()
        .toList();

    List<String>? gamesRes = gamesJson.map((e) {
      return e['name'];
    },).cast<String>()
        .toList();

    return CreatorsModel(
      name: json['name'],
      image: json['image'],
      gamesCount: json['games_count'],
      positions: positi,
      gamesMaded: gamesRes
    );
  }
}