// To parse this JSON data, do
//
//     final creditMovieModel = creditMovieModelFromJson(jsonString);

import 'dart:convert';

CreditMovieModel creditMovieModelFromJson(String str) => CreditMovieModel.fromJson(json.decode(str));

String creditMovieModelToJson(CreditMovieModel data) => json.encode(data.toJson());

class CreditMovieModel {
  final int? id;
  final List<CastModel>? cast;

  CreditMovieModel({
    this.id,
    this.cast,
  });

  CreditMovieModel copyWith({
    int? id,
    List<CastModel>? cast,
  }) =>
      CreditMovieModel(
        id: id ?? this.id,
        cast: cast ?? this.cast,
      );

  factory CreditMovieModel.fromJson(Map<String, dynamic> json) => CreditMovieModel(
        id: json["id"],
        cast: json["cast"] == null ? [] : List<CastModel>.from(json["cast"]!.map((x) => CastModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "cast": cast == null ? [] : List<dynamic>.from(cast!.map((x) => x.toJson())),
      };
}

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
