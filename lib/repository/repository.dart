import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:moviedb_flutter/model/movie_response.dart';

class MovieRepository {
  final String apiKey = "6753d9119b9627493ae129f3c3c99151";
  static String mainUrl = "https://api.themoviedb.org/3";
  final String getSearchUrl = "$mainUrl/search/movie";

  Future<MovieResponse> getMovies({@required int page}) async {
    try {
      Response response = await get("$getSearchUrl?api_key=$apiKey&query=superman&page=$page");
      return MovieResponse.fromJson(json.decode(response.body));
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return MovieResponse.withError("$error");
    }
  }
}
