// To parse this JSON data, do
//
//     final trailerMovieModel = trailerMovieModelFromJson(jsonString);

import 'dart:convert';

TrailerMovieModel trailerMovieModelFromJson(String str) => TrailerMovieModel.fromJson(json.decode(str));

String trailerMovieModelToJson(TrailerMovieModel data) => json.encode(data.toJson());

class TrailerMovieModel {
  final String? name;
  final String? key;

  TrailerMovieModel({
    this.name,
    this.key,
  });

  TrailerMovieModel copyWith({
    String? name,
    String? key,
  }) =>
      TrailerMovieModel(
        name: name ?? this.name,
        key: key ?? this.key,
      );

  factory TrailerMovieModel.fromJson(Map<String, dynamic> json) => TrailerMovieModel(
        name: json["name"],
        key: json["key"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "key": key,
      };
}
