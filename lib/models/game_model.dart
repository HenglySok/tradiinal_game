class TraditionalGame {
  final int id;
  final String title;
  final String views;
  final String imagePath;
  final String type;
  final String nameKh;
  final String nameEn;
  final GameDescription description;

  TraditionalGame({
    required this.id,
    required this.title,
    required this.views,
    required this.imagePath,
    required this.type,
    required this.nameKh,
    required this.nameEn,
    required this.description,
  });

  factory TraditionalGame.fromMergedJson(
    Map<String, dynamic> listJson,
    Map<String, dynamic>? detailJson,
  ) {
    return TraditionalGame(
      id: listJson['id'],
      title: listJson['title'] ?? "",
      views: listJson['views']?.toString() ?? "0", // Map views from games.json
      imagePath: listJson['imagePath'] ?? "",
      type: listJson['type'] ?? "other", // Map type for HomeScreen filtering
      nameKh: detailJson?['name_kh'] ?? listJson['title'] ?? "",
      nameEn: detailJson?['name_en'] ?? "",
      description: GameDescription.fromJson(detailJson?['description'] ?? {}),
    );
  }
}

class GameDescription {
  final String history;
  final Map<String, dynamic> timePlace;
  final Map<String, dynamic> materials;
  final Map<String, dynamic> howToPlay;

  GameDescription({
    required this.history,
    required this.timePlace,
    required this.materials,
    required this.howToPlay,
  });

  factory GameDescription.fromJson(Map<String, dynamic> json) {
    return GameDescription(
      history: json['history'] ?? "",
      timePlace: json['time_place'] ?? {},
      materials: json['materials'] ?? {},
      howToPlay: json['how_to_play'] ?? {},
    );
  }
}
