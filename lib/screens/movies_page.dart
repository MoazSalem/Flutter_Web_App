import 'package:flutter/material.dart';
import 'package:netflix_web/services/movies_service.dart';
import 'package:netflix_web/widgets/movie_widget.dart';

int currentPage = 1;

// This is the main page
class MoviesPage extends StatefulWidget {
  const MoviesPage({Key? key}) : super(key: key);

  @override
  State<MoviesPage> createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> {
  late List moviesList;
  bool loading = true;

  getMovies({required int page}) async {
    moviesList = await MoviesService().getMovies(page: page);
    loading = false;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getMovies(page: currentPage);
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
          style:
              TextStyle(fontSize: 50, fontWeight: FontWeight.bold, color: Colors.deepPurpleAccent),
        ),
        backgroundColor: Colors.black,
      ),
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              children: [
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 0.7,
                    crossAxisCount: currentWidth ~/ 300,
                  ),
                  itemCount: moviesList.length,
                  itemBuilder: (BuildContext context, index) {
                    return movieWidget(context: context, movie: moviesList[index]);
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.white,
                          minimumSize: const Size(250, 50),
                        ),
                        onPressed: currentPage == 1
                            ? null
                            : () async {
                                currentPage--;
                                setState(() {
                                  loading = true;
                                });
                                getMovies(page: currentPage);
                              },
                        child: const Icon(Icons.arrow_back),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.deepPurpleAccent,
                          minimumSize: const Size(250, 50),
                        ),
                        onPressed: () async {
                          currentPage++;
                          setState(() {
                            loading = true;
                          });
                          setState(() {});
                          getMovies(page: currentPage);
                        },
                        child: const Icon(Icons.arrow_forward),
                      )
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
