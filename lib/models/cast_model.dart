class CastModel {
  final bool? adult;
  final int? gender;
  final int? id;
  final String? name;
  final String? originalName;
  final double? popularity;
  final String? profilePath;
  final int? castId;
  final String? character;
  final int? order;

  CastModel({
    this.adult,
    this.gender,
    this.id,
    this.name,
    this.originalName,
    this.popularity,
    this.profilePath,
    this.castId,
    this.character,
    this.order,
  });

  CastModel copyWith({
    bool? adult,
    int? gender,
    int? id,
    String? name,
    String? originalName,
    double? popularity,
    String? profilePath,
    int? castId,
    String? character,
    int? order,
  }) =>
      CastModel(
        adult: adult ?? this.adult,
        gender: gender ?? this.gender,
        id: id ?? this.id,
        name: name ?? this.name,
        originalName: originalName ?? this.originalName,
        popularity: popularity ?? this.popularity,
        profilePath: profilePath ?? this.profilePath,
        castId: castId ?? this.castId,
        character: character ?? this.character,
        order: order ?? this.order,
      );

  factory CastModel.fromJson(Map<String, dynamic> json) => CastModel(
        adult: json["adult"],
        gender: json["gender"],
        id: json["id"],
        name: json["name"],
        originalName: json["original_name"],
        popularity: json["popularity"]?.toDouble(),
        profilePath: json["profile_path"],
        castId: json["cast_id"],
        character: json["character"],
        order: json["order"],
      );

  Map<String, dynamic> toJson() => {
        "adult": adult,
        "gender": gender,
        "id": id,
        "name": name,
        "original_name": originalName,
        "popularity": popularity,
        "profile_path": profilePath,
        "cast_id": castId,
        "character": character,
        "order": order,
      };
}
