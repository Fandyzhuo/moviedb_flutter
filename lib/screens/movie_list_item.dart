import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moviedb_flutter/model/movie.dart';
import 'package:moviedb_flutter/screens/movie_detail.dart';

class MovieListItem extends StatelessWidget {
  final Movie movie;

  const MovieListItem(this.movie);

  @override
  Widget build(BuildContext context) {
    final imageUrl = "http://image.tmdb.org/t/p/w500${movie.poster}";
    final DateFormat releaseDateFormat = DateFormat("d MMMM y");
    final DateTime releaseDateTime = movie.releaseDate != null && movie.releaseDate.isNotEmpty ? DateTime.parse(movie.releaseDate) : null;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (_) => MovieDetail(movie: movie)));
        },
        child: Row(
          children: [
            movie.poster == null
                ? Container(
                    width: 140,
                    height: 210,
                    decoration: BoxDecoration(shape: BoxShape.rectangle, color: Colors.grey, borderRadius: BorderRadius.horizontal(left: Radius.circular(8))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Icon(Icons.movie_outlined, color: Colors.white, size: 60)],
                    ),
                  )
                : Container(
                    width: 140,
                    height: 210,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.horizontal(left: Radius.circular(8)),
                      image: DecorationImage(fit: BoxFit.cover, image: NetworkImage(imageUrl)),
                    ),
                  ),
            SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    maxLines: 2,
                    style: TextStyle(height: 1.4, color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16.0),
                  ),
                  movie.releaseDate != null && movie.releaseDate.isNotEmpty
                      ? Text(
                          releaseDateFormat.format(releaseDateTime),
                          style: TextStyle(height: 1.4, color: Colors.grey, fontWeight: FontWeight.normal, fontSize: 11.0),
                        )
                      : SizedBox(),
                  SizedBox(height: 10),
                  Text(
                    movie.overview,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.normal, fontSize: 12.0),
                  ),
                ],
              ),
            ),
            SizedBox(width: 8),
          ],
        ),
      ),
    );
  }
}
