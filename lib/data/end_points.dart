import 'package:netflix_web/private.dart';

List<String> types = ["movie", "tv"];

String getEndPoint({required int typeIndex, required String category}) {
  return "https://api.themoviedb.org/3/${types[typeIndex]}/$category?api_key=$apiKey&language=en-US&page=";
}
