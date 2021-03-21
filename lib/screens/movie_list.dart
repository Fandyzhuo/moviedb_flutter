import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviedb_flutter/bloc/movie_bloc.dart';
import 'package:moviedb_flutter/bloc/movie_event.dart';
import 'package:moviedb_flutter/bloc/movie_state.dart';
import 'package:moviedb_flutter/model/movie.dart';
import 'package:moviedb_flutter/screens/movie_list_item.dart';

class MovieList extends StatefulWidget {
  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  final List<Movie> _movies = [];
  int _page = 1;
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MoviesListBloc, MovieState>(
      builder: (context, movieState) {
        if (movieState is MovieInitialState) {
          print("Initial State begins");
          return CircularProgressIndicator();
        } else if (movieState is MovieSuccessState) {
          _movies.addAll(movieState.movies);
          _page = movieState.page;
          print("current page: $_page");
          context.read<MoviesListBloc>().isFetching = false;
        } else if (movieState is MovieErrorState && _movies.isEmpty) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  context.read<MoviesListBloc>()
                    ..isFetching = true
                    ..add(MovieFetchEvent());
                },
                icon: Icon(Icons.refresh),
              ),
              const SizedBox(height: 15),
              Text(movieState.error, textAlign: TextAlign.center),
            ],
          );
        } else if (_movies.isEmpty) {
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
            ),
          );
        }
        return ListView.separated(
          controller: _scrollController
            ..addListener(() async {
              if (_scrollController.offset == _scrollController.position.maxScrollExtent && !context.read<MoviesListBloc>().isFetching) {
                context.read<MoviesListBloc>()
                  ..isFetching = true
                  ..add(MovieFetchEvent());
              }
            }),
          itemBuilder: (context, index) {
            if (index >= _movies.length) {
              return Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(bottom: 8),
                child: Center(
                  child: SizedBox(
                    width: 33,
                    height: 33,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                    ),
                  ),
                ),
              );
            }
            return MovieListItem(_movies[index]);
          },
          separatorBuilder: (context, index) => SizedBox(height: 8),
          padding: EdgeInsets.zero,
          itemCount: movieState is MovieMaxCountState ? _movies.length : _movies.length + 1,
        );
      },
      listener: (context, movieState) {},
    );
  }
}
