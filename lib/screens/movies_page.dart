import 'package:flutter/material.dart';
import 'package:netflix_web/services/movies_service.dart';
import 'package:netflix_web/widgets/movie_widget.dart';

// This is the main page
class MoviesPage extends StatefulWidget {
  const MoviesPage({Key? key}) : super(key: key);

  @override
  State<MoviesPage> createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> {
  late List moviesList;
  bool loading = true;

  getAllMovies() async {
    moviesList = await MoviesService().getMovies();
    loading = false;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getAllMovies();
  }

  @override
  Widget build(BuildContext context) {
    final currentWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 120,
        title: const Text(
          "Movies",
          style: TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurpleAccent),
        ),
        backgroundColor: Colors.black,
      ),
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 0.7,
                crossAxisCount: currentWidth ~/ 300,
              ),
              itemCount: moviesList.length,
              itemBuilder: (BuildContext context, index) {
                return movieWidget(context: context, movie: moviesList[index]);
              },
            ),
    );
  }
}
