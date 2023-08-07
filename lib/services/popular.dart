import 'dart:convert';
import 'package:http/http.dart';
import 'package:tmdb_web/models/popular.dart';
import 'package:tmdb_web/private.dart';

// This is used to get the data from the rest api endpoint
class PopularService {
  Future<List<Results>> getPopular() async {
    String endPoint = "https://api.themoviedb.org/3/trending/all/week?api_key=$apiKey";
    List<Results> popular = [];
    Response response = await get(Uri.parse(endPoint));
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      // movies are called results in the api
      body["results"].forEach((movieData) {
        Results newSomething = Results.fromJson(movieData);
        popular.add(newSomething);
      });
    } else {
      throw Exception();
    }

    return popular;
  }
}
