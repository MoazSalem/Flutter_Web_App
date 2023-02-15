import 'package:flutter/material.dart';
import 'package:netflix_web/screens/MovieInfo.dart';
import 'package:netflix_web/services/movies_service.dart';

class MoviesPage extends StatefulWidget {
  const MoviesPage({Key? key}) : super(key: key);

  @override
  State<MoviesPage> createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> {
  List moviesList = [];
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
        title: const Text(
          "Movies",
          style: TextStyle(fontWeight: FontWeight.bold),
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
                return GestureDetector(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => MovieInfo(
                            title: moviesList[index].title,
                            overview: moviesList[index].overview,
                            poster:
                                "https://image.tmdb.org/t/p/w500${moviesList[index].posterPath}",
                            averageVote: moviesList[index].voteAverage,
                          ))),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      children: [
                        SizedBox(
                          width: 500,
                          height: 500,
                          child: Image.network(
                              fit: BoxFit.fill,
                              "https://image.tmdb.org/t/p/w500${moviesList[index].posterPath}"),
                        ),
                        Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color.fromARGB(200, 0, 0, 0),
                                Color.fromARGB(20, 0, 0, 0),
                                Color.fromARGB(0, 0, 0, 0)
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                          ),
                          alignment: Alignment.center,
                          width: 500,
                          child: Container(
                            alignment: Alignment.bottomLeft,
                            height: 500,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "${moviesList[index].title}",
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
