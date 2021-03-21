import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviedb_flutter/bloc/movie_bloc.dart';
import 'package:moviedb_flutter/bloc/movie_event.dart';

import 'movie_list.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MoviesListBloc()..add(MovieFetchEvent()),
      child: Scaffold(
        appBar: AppBar(title: Text("Superman Movies")),
        body: MovieList(),
      ),
    );
  }
}
