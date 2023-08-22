import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tmdb_web/cubit/tmdb_cubit.dart';
import 'package:tmdb_web/widgets/list_widget.dart';
import 'package:tmdb_web/widgets/app_bar.dart';
import 'package:tmdb_web/data/categories.dart';
import '../home_page.dart';

// This is the main page
class MoviesPage extends StatefulWidget {
  final String page;
  final String category;

  const MoviesPage({Key? key, required this.category, required this.page}) : super(key: key);

  @override
  State<MoviesPage> createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> {
  late double currentWidth;
  late ThemeData theme;
  final ScrollController scrollController = ScrollController();
  int currentPage = 1;
  int loadedPage = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    currentWidth = MediaQuery.of(context).size.width;
    theme = Theme.of(context);
  }

  changePage() {
    loadedPage != currentPage
        ? {
            if ({"popular", "top_rated", "now_playing", "upcoming"}.contains(widget.category))
              {
                loadedPage = int.parse(widget.page),
                C.moviesList = [],
                C.getMovies(page: currentPage, category: widget.category),
              }
            else
              {
                loadedPage = int.parse(widget.page),
                C.moviesList = [],
                C.getMoviesGenre(page: currentPage, genre: moviesCategories[widget.category]!),
              }
          }
        : null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TmdbCubit, TmdbState>(
      builder: (context, state) {
        currentPage = int.parse(widget.page);
        changePage();
        return Scaffold(
          backgroundColor: theme.canvasColor,
          appBar: AppBar(
            centerTitle: true,
            toolbarHeight: 90,
            automaticallyImplyLeading: false,
            title: appBar(context: context),
            backgroundColor: theme.canvasColor,
          ),
          body: C.moviesList.isEmpty
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Color(0xff8fcea2),
                  ),
                )
              : ListView(
                  physics: const BouncingScrollPhysics(),
                  cacheExtent: 3500,
                  children: [
                    listWidget(
                      list: C.moviesList,
                      scrollController: scrollController,
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15.0),
                          child: Center(
                              child: Text(
                            "Page $currentPage",
                          )),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0, bottom: 16.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  minimumSize: Size(currentWidth * 0.3, 60),
                                ),
                                onPressed: currentPage == 1
                                    ? null
                                    : () {
                                        currentPage = 1;
                                        context.go("/movies/${widget.category}/${1}");
                                      },
                                child: Center(
                                  child: Icon(
                                    Icons.home_filled,
                                    color: currentPage == 1 ? Colors.grey : const Color(0xff8fcea2),
                                  ),
                                ),
                              ),
                              OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  minimumSize: Size(currentWidth * 0.3, 60),
                                ),
                                onPressed: currentPage == 1
                                    ? null
                                    : () {
                                        currentPage--;
                                        context.go("/movies/${widget.category}/$currentPage");
                                      },
                                child: Center(
                                  child: Icon(
                                    Icons.arrow_back,
                                    color: currentPage == 1 ? Colors.grey : const Color(0xff8fcea2),
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: theme.primaryColor,
                                  minimumSize: Size(currentWidth * 0.3, 60),
                                ),
                                onPressed: () {
                                  currentPage++;
                                  context.go("/movies/${widget.category}/$currentPage");
                                },
                                child: const Center(child: Icon(Icons.arrow_forward)),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
        );
      },
    );
  }
}
