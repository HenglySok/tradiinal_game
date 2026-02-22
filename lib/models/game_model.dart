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
    String rawPath = listJson['imagePath'] ?? "";
    // Fix for Android: Ensure path starts with 'assets/'
    String fixedPath = rawPath.startsWith('assets/')
        ? rawPath
        : 'assets/$rawPath';

    return TraditionalGame(
      id: listJson['id'] ?? 0,
      title: listJson['title'] ?? "",
      views: listJson['views']?.toString() ?? "0",
      imagePath: fixedPath,
      type: listJson['type'] ?? "other",
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
      timePlace: Map<String, dynamic>.from(json['time_place'] ?? {}),
      materials: Map<String, dynamic>.from(json['materials'] ?? {}),
      howToPlay: Map<String, dynamic>.from(json['how_to_play'] ?? {}),
    );
  }
}
