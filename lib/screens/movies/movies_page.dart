import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:netflix_web/services/movies_service.dart';
import 'package:netflix_web/data/end_points.dart';
import 'package:netflix_web/widgets/list_widget.dart';
import 'package:netflix_web/widgets/drawer.dart';

int currentPage = 1;
List<String> movieCategories = ["popular", "now_playing", "top_rated", "upcoming"];

// This is the main page
class MoviesPage extends StatefulWidget {
  final String? page;
  final int categoryIndex;
  final String title;

  const MoviesPage({Key? key, required this.categoryIndex, required this.title, required this.page})
      : super(key: key);

  @override
  State<MoviesPage> createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> {
  late List moviesList;
  bool loading = true;

  getMovies({required int page}) async {
    currentPage = int.parse(widget.page!);
    moviesList = await MoviesService().getMovies(
        page: page,
        endPoint: getEndPoint(category: movieCategories[widget.categoryIndex], typeIndex: 0));
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    getMovies(page: currentPage);
    double currentWidth = MediaQuery.of(context).size.width;
    ScrollController scrollController = ScrollController();
    ThemeData theme = Theme.of(context);
    return Scaffold(
      drawer: drawerWidget(theme: theme, context: context),
      backgroundColor: theme.canvasColor,
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 70,
        title: Text(
          widget.title,
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: theme.primaryColor),
        ),
        backgroundColor: theme.canvasColor,
      ),
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
            physics: const BouncingScrollPhysics(),
            cacheExtent: 3500,
            children: [
              listWidget(currentWidth: currentWidth, list: moviesList, isMovie: true, scrollController: scrollController),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Center(
                    child: Text(
                      "Page $currentPage",
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0, bottom: 16.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        minimumSize: Size(currentWidth * 0.3, 50),
                      ),
                      onPressed: currentPage == 1
                          ? null
                          : () {
                              currentPage = 1;
                              setState(() {
                                loading = true;
                              });
                              context
                                  .go("/movies/${movieCategories[widget.categoryIndex]}/${1}");
                            },
                      child: const Icon(Icons.home_filled),
                    ),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        minimumSize: Size(currentWidth * 0.3, 50),
                      ),
                      onPressed: currentPage == 1
                          ? null
                          : () {
                              currentPage--;
                              setState(() {
                                loading = true;
                              });
                              context.go(
                                  "/movies/${movieCategories[widget.categoryIndex]}/$currentPage");
                            },
                      child: const Icon(Icons.arrow_back),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: theme.primaryColor,
                        minimumSize: Size(currentWidth * 0.3, 50),
                      ),
                      onPressed: () {
                        currentPage++;
                        setState(() {
                          loading = true;
                        });
                        context.go(
                            "/movies/${movieCategories[widget.categoryIndex]}/$currentPage");
                      },
                      child: const Icon(Icons.arrow_forward),
                    )
                  ],
                ),
              ),
            ],
          ),
    );
  }
}
