import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviedb_flutter/bloc/movie_event.dart';
import 'package:moviedb_flutter/bloc/movie_state.dart';
import 'package:moviedb_flutter/model/movie_response.dart';
import 'package:moviedb_flutter/repository/repository.dart';

class MoviesListBloc extends Bloc<MovieEvent, MovieState> {
  MovieRepository _movieRepository = MovieRepository();
  int page = 1;
  bool isFetching = false;

  MoviesListBloc() : super(MovieInitialState());

  @override
  Stream<MovieState> mapEventToState(MovieEvent event) async* {
    if(event is MovieFetchEvent){
      yield MovieLoadingState(message: 'Loading Movies');
      MovieResponse response = await _movieRepository.getMovies(page: page);
      if (response.error.isEmpty) {
        if(response.movies.isEmpty){
          yield MovieMaxCountState();
        } else {
          yield MovieSuccessState(movies: response.movies, page: page++);
        }
        // page++;
      } else {
        yield MovieErrorState(error: response.error);
      }
    }
  }
}