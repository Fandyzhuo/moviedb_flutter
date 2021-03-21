import 'movie.dart';

class MovieResponse {
  final List<Movie> movies;
  final int totalPages;
  final int totalResults;
  final String error;

  MovieResponse(this.movies, this.totalPages, this.totalResults, this.error);

  MovieResponse.fromJson(Map<String, dynamic> json)
      : movies = (json["results"] as List).map((i) => new Movie.fromJson(i)).toList(),
        totalPages = json["total_pages"],
        totalResults = json["total_results"],
        error = "";

  MovieResponse.withError(String errorValue)
      : movies = List(),
        totalPages = 0,
        totalResults = 0,
        error = errorValue;
}
