import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:netflix_web/models/movies.dart';
import 'package:netflix_web/services/movies_service.dart';
import 'movies_page.dart';

late Movie movie;
bool loading = true;

// This page is opened when you press on a movie
class MovieInfo extends StatefulWidget {
  final String id;

  const MovieInfo({Key? key, required this.id}) : super(key: key);

  @override
  State<MovieInfo> createState() => _MovieInfoState();
}

class _MovieInfoState extends State<MovieInfo> {
  getMovie({required int id}) async {
    movie = moviesList.isNotEmpty
        ? moviesList.firstWhere((movie) => movie.id == id)
        : await MoviesService().getMovie(id: id);
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    int parsedId = int.parse(widget.id);
    getMovie(id: parsedId);
    ThemeData theme = Theme.of(context);
    double currentWidth = MediaQuery.of(context).size.width;
    currentWidth > 800 ? currentWidth /= 2 : currentWidth *= 1.2;
    return Scaffold(
      backgroundColor: theme.canvasColor,
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: moviesList.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: FloatingActionButton(
                backgroundColor: theme.primaryColor,
                onPressed: () {
                  context.pop();
                },
                mini: true,
                child: const Icon(
                  Icons.arrow_back,
                ),
              ),
            )
          : Container(),
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 400,
                  child: Image.network(
                      fit: BoxFit.cover,
                      "https://image.tmdb.org/t/p/original/${movie.backdropPath ?? movie.posterPath}"),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
                  child: Text(
                    movie.title,
                    style: TextStyle(
                      fontSize: currentWidth * 0.05,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: currentWidth * 0.035,
                          color: theme.textTheme.bodySmall!.color),
                      children: <TextSpan>[
                        const TextSpan(text: "Rating: "),
                        TextSpan(
                            text: movie.voteAverage
                                .toStringAsFixed(1)
                                .replaceFirst(RegExp(r'\.?'), ''),
                            style: TextStyle(color: theme.primaryColor)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "Overview:",
                    style: TextStyle(fontSize: currentWidth * 0.035, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    movie.overview,
                    style: TextStyle(fontSize: currentWidth * 0.03, fontWeight: FontWeight.w300),
                  ),
                ),
              ],
            ),
    );
  }
}
