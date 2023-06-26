// To parse this JSON data, do
//
//     final reviewMovieModel = reviewMovieModelFromJson(jsonString);

import 'dart:convert';

ReviewMovieModel reviewMovieModelFromJson(String str) => ReviewMovieModel.fromJson(json.decode(str));

String reviewMovieModelToJson(ReviewMovieModel data) => json.encode(data.toJson());

class ReviewMovieModel {
  final int? id;
  final int? page;
  final List<Review>? results;
  final int? totalPages;
  final int? totalResults;

  ReviewMovieModel({
    this.id,
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  ReviewMovieModel copyWith({
    int? id,
    int? page,
    List<Review>? results,
    int? totalPages,
    int? totalResults,
  }) =>
      ReviewMovieModel(
        id: id ?? this.id,
        page: page ?? this.page,
        results: results ?? this.results,
        totalPages: totalPages ?? this.totalPages,
        totalResults: totalResults ?? this.totalResults,
      );

  factory ReviewMovieModel.fromJson(Map<String, dynamic> json) => ReviewMovieModel(
        id: json["id"],
        page: json["page"],
        results: json["results"] == null ? [] : List<Review>.from(json["results"]!.map((x) => Review.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "page": page,
        "results": results == null ? [] : List<dynamic>.from(results!.map((x) => x.toJson())),
        "total_pages": totalPages,
        "total_results": totalResults,
      };
}

class Review {
  final String? author;
  final AuthorDetails? authorDetails;
  final String? content;
  final String? id;
  final String? url;

  Review({
    this.author,
    this.authorDetails,
    this.content,
    this.id,
    this.url,
  });

  Review copyWith({
    String? author,
    AuthorDetails? authorDetails,
    String? content,
    String? id,
    String? url,
  }) =>
      Review(
        author: author ?? this.author,
        authorDetails: authorDetails ?? this.authorDetails,
        content: content ?? this.content,
        id: id ?? this.id,
        url: url ?? this.url,
      );

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        author: json["author"],
        authorDetails: json["author_details"] == null ? null : AuthorDetails.fromJson(json["author_details"]),
        content: json["content"],
        id: json["id"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "author": author,
        "author_details": authorDetails?.toJson(),
        "content": content,
        "id": id,
        "url": url,
      };
}

class AuthorDetails {
  final String? name;
  final String? username;
  final String? avatarPath;
  final double? rating;

  AuthorDetails({
    this.name,
    this.username,
    this.avatarPath,
    this.rating,
  });

  AuthorDetails copyWith({
    String? name,
    String? username,
    String? avatarPath,
    double? rating,
  }) =>
      AuthorDetails(
        name: name ?? this.name,
        username: username ?? this.username,
        avatarPath: avatarPath ?? this.avatarPath,
        rating: rating ?? this.rating,
      );

  factory AuthorDetails.fromJson(Map<String, dynamic> json) => AuthorDetails(
        name: json["name"],
        username: json["username"],
        avatarPath: json["avatar_path"],
        rating: json["rating"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "username": username,
        "avatar_path": avatarPath,
        "rating": rating,
      };
}
