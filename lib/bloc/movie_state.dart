import 'package:flutter/foundation.dart';
import 'package:moviedb_flutter/model/movie.dart';

abstract class MovieState {
  const MovieState();
}

class MovieInitialState extends MovieState {
  const MovieInitialState();
}

class MovieLoadingState extends MovieState {
  final String message;

  const MovieLoadingState({
    @required this.message,
  });
}

class MovieSuccessState extends MovieState {
  final List<Movie> movies;
  final int page;

  const MovieSuccessState({
    @required this.movies,
    @required this.page,
  });
}

class MovieMaxCountState extends MovieState {
  const MovieMaxCountState();
}

class MovieErrorState extends MovieState {
  final String error;

  const MovieErrorState({
    @required this.error,
  });
}
