import 'dart:convert';
import 'package:http/http.dart';
import 'package:netflix_web/models/tv.dart';
import 'package:netflix_web/private.dart';

// This is used to get the data from the rest api endpoint
class TVService {
  Future<List<TvShow>> getShows({required int page, required String endPoint}) async {
    endPoint += "$page";
    List<TvShow> tvShows = [];
    Response response = await get(Uri.parse(endPoint));
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      // movies are called results in the api
      body["results"].forEach((tvShowData) {
        TvShow newTvShow = TvShow.fromJson(tvShowData);
        tvShows.add(newTvShow);
      });
    } else {
      throw Exception();
    }

    return tvShows;
  }

  Future<TvShow> getShow({required int id}) async {
    String endPoint = "https://api.themoviedb.org/3/tv/$id?api_key=$apiKey&language=en-US";
    late TvShow show;
    Response response = await get(Uri.parse(endPoint));
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      // movies are called results in the api
      show = TvShow.fromJson(body);
    } else {
      throw Exception();
    }
    return show;
  }

  Future<List<TvShow>> searchShows({required String query}) async {
    String endPoint =
        "https://api.themoviedb.org/3/search/tv?api_key=$apiKey&language=en-US&query=$query";
    List<TvShow> tvShows = [];
    Response response = await get(Uri.parse(endPoint));
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      // movies are called results in the api
      body["results"].forEach((movieData) {
        TvShow newShow = TvShow.fromJson(movieData);
        tvShows.add(newShow);
      });
    } else {
      throw Exception();
    }

    return tvShows;
  }
}
