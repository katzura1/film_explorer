// To parse this JSON data, do
//
//     final creditMovieModel = creditMovieModelFromJson(jsonString);

import 'dart:convert';

import 'cast_model.dart';

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
