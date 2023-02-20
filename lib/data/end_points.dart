import 'package:netflix_web/private.dart';

List<String> types = ["movie", "tv"];
List<String> movieCategories = ["popular", "now_playing", "top_rated", "upcoming"];
List<String> tvCategories = ["popular", "airing_today", "top_rated", "on_the_air"];

String getEndPoint({required int typeIndex, required int categoryIndex}) {
  List<String> categories = typeIndex == 0 ? movieCategories : tvCategories;
  return "https://api.themoviedb.org/3/${types[typeIndex]}/${categories[categoryIndex]}?api_key=$apiKey&language=en-US&page=";
}
