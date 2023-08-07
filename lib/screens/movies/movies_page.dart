import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tmdb_web/bloc/nex_bloc.dart';
import 'package:tmdb_web/widgets/list_widget.dart';
import 'package:tmdb_web/widgets/app_bar.dart';
import 'package:tmdb_web/data/categories.dart';

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
  late NexBloc B;
  final ScrollController scrollController = ScrollController();
  int currentPage = 1;
  int loadedPage = 0;

  @override
  void initState() {
    super.initState();
    B = NexBloc.get(context);
  }

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
                B.moviesList = [],
                B.getMovies(page: currentPage, category: widget.category),
              }
            else
              {
                loadedPage = int.parse(widget.page),
                B.moviesList = [],
                B.getMoviesGenre(page: currentPage, genre: moviesCategories[widget.category]!),
              }
          }
        : null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NexBloc, NexState>(
      listener: (context, state) {},
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
          body: B.moviesList.isEmpty
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView(
                  physics: const BouncingScrollPhysics(),
                  cacheExtent: 3500,
                  children: [
                    listWidget(
                      currentWidth: currentWidth,
                      list: B.moviesList,
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
                                  minimumSize: Size(currentWidth * 0.3, 50),
                                ),
                                onPressed: currentPage == 1
                                    ? null
                                    : () {
                                        currentPage = 1;
                                        context.go("/movies/${widget.category}/${1}");
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
                                        context.go("/movies/${widget.category}/$currentPage");
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
                                  context.go("/movies/${widget.category}/$currentPage");
                                },
                                child: const Icon(Icons.arrow_forward),
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
