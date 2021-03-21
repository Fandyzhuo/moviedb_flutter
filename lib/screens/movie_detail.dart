import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moviedb_flutter/model/movie.dart';

class MovieDetail extends StatefulWidget {
  final Movie movie;

  MovieDetail({@required this.movie});

  @override
  _MovieDetailState createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {
  final ScrollController _scrollController = ScrollController();
  bool showTitle = false;

  @override
  Widget build(BuildContext context) {
    final imageUrl = "http://image.tmdb.org/t/p/w500${widget.movie.poster}";
    final DateFormat releaseDateFormat = DateFormat("d MMMM y");
    final DateTime releaseDateTime = widget.movie.releaseDate != null && widget.movie.releaseDate.isNotEmpty ? DateTime.parse(widget.movie.releaseDate) : null;
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController
          ..addListener(() {
            setState(() {
              showTitle = _scrollController.hasClients && _scrollController.offset > (540 - kToolbarHeight);
            });
          }),
        slivers: [
          SliverAppBar(
            flexibleSpace: FlexibleSpaceBar(
              background: SafeArea(
                child: widget.movie.poster != null && widget.movie.poster.isNotEmpty
                    ? Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(imageUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    : Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: Colors.grey,
                          borderRadius: BorderRadius.horizontal(left: Radius.circular(8)),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [Icon(Icons.movie_outlined, color: Colors.white, size: 60)],
                        ),
                      ),
              ),
              stretchModes: [
                StretchMode.fadeTitle,
              ],
            ),
            pinned: true,
            expandedHeight: 540,
            title: showTitle ? Text(widget.movie.title, style: TextStyle(fontSize: 14), maxLines: 2) : null,
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              widget.movie.title,
                              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20, height: 1.2),
                            ),
                          ),
                          SizedBox(width: 16),
                          Text(
                            widget.movie.rating.toString(),
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
                          ),
                        ],
                      ),
                      widget.movie.releaseDate != null && widget.movie.releaseDate.isNotEmpty
                          ? Text(
                              "Release time: ${releaseDateFormat.format(releaseDateTime)}",
                              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 14.0, height: 2),
                            )
                          : SizedBox(),
                      Text(
                        "Overview",
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 18, height: 2),
                      ),
                      Text(
                        widget.movie.overview,
                        style: TextStyle(color: Colors.grey, fontSize: 14, height: 1.5),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
