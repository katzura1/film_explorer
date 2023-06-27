import 'package:flutter_dotenv/flutter_dotenv.dart';

String baseUrl = "https://api.themoviedb.org/3";
String token = dotenv.env['TOKEN_TMDB'].toString();
String baseImageUrl = "https://image.tmdb.org/t/p/w154";
String baseImageCoverUrl = "https://image.tmdb.org/t/p/w500";
