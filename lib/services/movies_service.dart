import 'dart:convert';
import 'package:http/http.dart'as http;
import 'package:http/http.dart';
import 'package:netflix_web/models/movies.dart';

class MoviesService {
  String postEndPoint = "https://api.themoviedb.org/3/movie/popular?api_key=837aa67b269303622a476bbe24283a57";

  Future<List<Results>> getMovies() async {
    List<Results> Movies = [];
    Response response = await http.get(Uri.parse(postEndPoint));
    if(response.statusCode == 200){
      var body = jsonDecode(response.body);
      body["results"].forEach((movieData) {
        Results newMovie = Results.fromJson(movieData);
        Movies.add(newMovie);
      });
    }else{
      throw Exception();
    }

    return Movies;
  }
}