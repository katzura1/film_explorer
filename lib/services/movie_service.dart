import 'dart:convert';

import 'package:film_explorer/models/credit_movie_model.dart';
import 'package:film_explorer/models/detail_movie_model.dart';
import 'package:film_explorer/models/genre_model.dart';
import 'package:film_explorer/models/list_movie_model.dart';
import 'package:film_explorer/models/review_movie_model.dart';
import 'package:film_explorer/models/trailer_movie_model.dart';
import 'package:http/http.dart' as http;

import '../shared/values.dart';

class MovieService {
  Future<ListMovieModel> getMovies() async {
    try {
      final res = await http.get(
        Uri.parse("$baseUrl/trending/movie/week?language=en-US&page=1&region=id,us"),
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      );
      if (res.statusCode == 200) {
        // print(res.body);
        return ListMovieModel.fromJson(json.decode(res.body));
      } else {
        throw Exception("Failed to connect to the server");
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<ListMovieModel> getNowPlayingMovies() async {
    try {
      final res = await http.get(
        Uri.parse("$baseUrl/movie/now_playing?language=en-US&page=1&region=id,us"),
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      );
      if (res.statusCode == 200) {
        // print(res.body);
        return ListMovieModel.fromJson(json.decode(res.body));
      } else {
        throw Exception("Failed to connect to the server");
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<ListMovieModel> getTopRatedMovies() async {
    try {
      final res = await http.get(
        Uri.parse("$baseUrl/movie/top_rated?language=en-US&page=1&region=id,us"),
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      );
      if (res.statusCode == 200) {
        // print(res.body);
        return ListMovieModel.fromJson(json.decode(res.body));
      } else {
        throw Exception("Failed to connect to the server");
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<ListMovieModel> getUpcomingMovies() async {
    try {
      final res = await http.get(
        Uri.parse("$baseUrl/movie/upcoming?language=en-US&page=1&region=id,us"),
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      );
      if (res.statusCode == 200) {
        // print(res.body);
        return ListMovieModel.fromJson(json.decode(res.body));
      } else {
        throw Exception("Failed to connect to the server");
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<ListMovieModel> searchMovies(String param, int page) async {
    try {
      // print("$baseUrl/search/movie?query=$param&language=en-US&page=$page&region=id,us");
      final res = await http.get(
        Uri.parse("$baseUrl/search/movie?query=$param&language=en-US&page=$page&region=id,us"),
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      );
      // print(res.body);
      if (res.statusCode == 200) {
        return ListMovieModel.fromJson(json.decode(res.body));
      } else {
        throw Exception("Failed to connect to the server");
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<DetailMovieModel> getDetail(int id) async {
    try {
      final res = await http.get(
        Uri.parse("$baseUrl/movie/$id"),
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      );
      // print(json.decode(res.body)['release_date']);
      if (res.statusCode == 200) {
        return DetailMovieModel.fromJson(json.decode(res.body));
      } else {
        throw Exception("Failed to connect to the server");
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<CreditMovieModel> getCredit(int id) async {
    try {
      final res = await http.get(
        Uri.parse("$baseUrl/movie/$id/credits?language=en-US"),
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      );
      // print(res.body);
      if (res.statusCode == 200) {
        return CreditMovieModel.fromJson(json.decode(res.body));
      } else {
        throw Exception("Failed to connect to the server");
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<ListMovieModel> getRecomendationMovies(int id) async {
    try {
      final res = await http.get(
        Uri.parse("$baseUrl/movie/$id/recommendations?language=en-US,id&page=1"),
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      );
      // print(res.body);
      if (res.statusCode == 200) {
        return ListMovieModel.fromJson(json.decode(res.body));
      } else {
        throw Exception("Failed to connect to the server");
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<ReviewMovieModel> getReviewMovie(int id) async {
    try {
      final res = await http.get(
        Uri.parse("$baseUrl/movie/$id/reviews?language=en-US&page=1"),
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      );
      // print(res.body);
      if (res.statusCode == 200) {
        return ReviewMovieModel.fromJson(json.decode(res.body));
      } else {
        throw Exception("Failed to connect to the server");
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<TrailerMovieModel>> getTrailerMovie(int id) async {
    try {
      final res = await http.get(
        Uri.parse("$baseUrl/movie/$id/videos?language=en-US&page=1"),
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      );
      // print(res.body);
      if (res.statusCode == 200) {
        return List<TrailerMovieModel>.from(
          json.decode(res.body)['results'].map(
                (trailer) => TrailerMovieModel.fromJson(trailer),
              ),
        );
      } else {
        throw Exception("Failed to connect to the server");
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<GenreModel>> getGenres() async {
    // print("$baseUrl/genre/movie/list?language=en%2Cid");
    try {
      final res = await http.get(
        Uri.parse("$baseUrl/genre/movie/list?language=en%2Cid"),
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      );
      // print(res.body);
      if (res.statusCode == 200) {
        return List<GenreModel>.from(
          json.decode(res.body)['genres'].map(
                (genre) => GenreModel.fromJson(genre),
              ),
        );
      } else {
        throw Exception("Failed to connect to the server");
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<ListMovieModel> getMovieByGenre(int genreId, int page) async {
    try {
      final res = await http.get(
        Uri.parse(
            "$baseUrl/discover/movie?include_adult=false&include_video=false&language=en-US%2Cid&page=$page&sort_by=popularity.desc&with_genres=$genreId"),
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      );
      if (res.statusCode == 200) {
        // print(res.body);
        return ListMovieModel.fromJson(json.decode(res.body));
      } else {
        throw Exception("Failed to connect to the server");
      }
    } catch (e) {
      rethrow;
    }
  }
}
