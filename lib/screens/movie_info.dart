import 'package:flutter/material.dart';
import 'package:netflix_web/models/movies.dart';

// This page is opened when you press on a movie
class MovieInfo extends StatelessWidget {
  final Movie movie;

  const MovieInfo({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color primary = Colors.deepPurpleAccent;
    var currentWidth = MediaQuery.of(context).size.width;
    currentWidth > 800 ? currentWidth /= 2 : currentWidth *= 1.2;
    return Scaffold(
      backgroundColor: Colors.black,
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 12.0),
        child: FloatingActionButton(
          backgroundColor: primary,
          onPressed: () {
            Navigator.of(context).pop();
          },
          mini: true,
          child: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: ListView(
        children: [
          SizedBox(
            width: double.infinity,
            height: 400,
            child: Image.network(
                fit: BoxFit.cover, "https://image.tmdb.org/t/p/original/${movie.backdropPath}"),
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
                    color: Colors.white),
                children: <TextSpan>[
                  const TextSpan(text: "Rating: "),
                  TextSpan(text: movie.voteAverage.toString(), style: TextStyle(color: primary)),
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
