import 'dart:convert';
import 'package:http/http.dart';
import 'package:netflix_web/models/movies.dart';
import 'package:netflix_web/private.dart';

// This is used to get the data from the rest api endpoint
class MoviesService {
  Future<List<Movie>> getMovies({required int page}) async {
    String postEndPoint =
        "https://api.themoviedb.org/3/movie/popular?api_key=$apiKey&language=en-US&page=$page";
    List<Movie> movies = [];
    Response response = await get(Uri.parse(postEndPoint));
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      // movies are called results in the api
      body["results"].forEach((movieData) {
        Movie newMovie = Movie.fromJson(movieData);
        movies.add(newMovie);
      });
    } else {
      throw Exception();
    }

    return movies;
  }
}
