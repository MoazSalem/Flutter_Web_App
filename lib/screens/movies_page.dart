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
    double currentWidth = MediaQuery.of(context).size.width;
    ScrollController scrollController = ScrollController();
    return Scaffold(
      drawer: const Drawer(
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 70,
        title: const Text(
          "Popular",
          style:
              TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.deepPurpleAccent),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Center(
                child: Text(
              "Page $currentPage",
              style: const TextStyle(color: Colors.white),
            )),
          ),
        ],
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Scrollbar(
              controller: scrollController,
              thumbVisibility: true,
              child: GridView.builder(
                controller: scrollController,
                shrinkWrap: false,
                cacheExtent: 2500,
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: currentWidth * 0.03, vertical: 10),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 0.6685,
                  mainAxisSpacing: 1,
                  crossAxisCount: crossAxisCount(currentWidth: currentWidth),
                ),
                itemCount: moviesList.length,
                itemBuilder: (BuildContext context, index) {
                  return movieWidget(context: context, movie: moviesList[index]);
                },
              ),
            ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white,
                minimumSize: Size(currentWidth * 0.3, 50),
              ),
              onPressed: currentPage == 1
                  ? null
                  : () async {
                      currentPage = 1;
                      setState(() {
                        loading = true;
                      });
                      getMovies(page: 1);
                    },
              child: const Icon(Icons.home_filled),
            ),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white,
                minimumSize: Size(currentWidth * 0.3, 50),
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
                minimumSize: Size(currentWidth * 0.3, 50),
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
      ),
    );
  }
}

int crossAxisCount({required currentWidth}) {
  int count = currentWidth ~/ 250;
  count == 1
      ? count = 2
      : count > 5
          ? count = 5
          : null;
  return count;
}
