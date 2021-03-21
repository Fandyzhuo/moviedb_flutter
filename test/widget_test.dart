// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:moviedb_flutter/main.dart';
import 'package:moviedb_flutter/model/movie.dart';
import 'package:moviedb_flutter/model/movie_response.dart';
import 'package:moviedb_flutter/repository/repository.dart';
import 'package:moviedb_flutter/screens/home_screen.dart';
import 'package:moviedb_flutter/screens/movie_list.dart';

final movieRepository = MovieRepository();

void main() {
  test("Check if first movie contains Superman", () async {
    MovieResponse movieResponse = await movieRepository.getMovies(page: 1);
    List<Movie> supermanMovies = movieResponse.movies;
    expect(supermanMovies[0].title.toLowerCase(), contains("superman"));
  });

}
