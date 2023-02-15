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
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Movies",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 0.71,
                crossAxisCount: 5,
              ),
              itemCount: moviesList.length,
              itemBuilder: (BuildContext context, index) {
                return movieWidget(context: context, movie: moviesList[index]);
              },
            ),
    );
  }
}
