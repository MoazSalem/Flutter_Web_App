import 'dart:convert';
import 'package:http/http.dart';
import 'package:netflix_web/models/movies.dart';
import 'package:netflix_web/private.dart';

// This is used to get the data from the rest api endpoint
class MoviesService {
  Future<List<Movie>> getMovies({required int page, required String endPoint}) async {
    endPoint += "$page";
    List<Movie> movies = [];
    Response response = await get(Uri.parse(endPoint));
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

  Future<Movie> getMovie({required int id}) async {
    String endPoint = "https://api.themoviedb.org/3/movie/$id?api_key=$apiKey&language=en-US";
    late Movie movie;
    Response response = await get(Uri.parse(endPoint));
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      // movies are called results in the api
      movie = Movie.fromJson(body);
    } else {
      throw Exception();
    }
    return movie;
  }

  Future<List<Movie>> searchMovies({required String query}) async {
    String endPoint =
        "https://api.themoviedb.org/3/search/movie?api_key=$apiKey&language=en-US&query=$query";
    List<Movie> movies = [];
    Response response = await get(Uri.parse(endPoint));
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
