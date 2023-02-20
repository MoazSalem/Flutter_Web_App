import 'dart:convert';
import 'package:http/http.dart';
import 'package:netflix_web/models/tv.dart';

// This is used to get the data from the rest api endpoint
class TVService {
  Future<List<TvShows>> getShows({required int page, required String endPoint}) async {
    endPoint += "$page";
    List<TvShows> tvShows = [];
    Response response = await get(Uri.parse(endPoint));
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      // movies are called results in the api
      body["results"].forEach((tvShowData) {
        TvShows newTvShow = TvShows.fromJson(tvShowData);
        tvShows.add(newTvShow);
      });
    } else {
      throw Exception();
    }

    return tvShows;
  }
}
