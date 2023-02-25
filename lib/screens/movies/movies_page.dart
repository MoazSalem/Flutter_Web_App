import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:netflix_web/bloc/nex_bloc.dart';
import 'package:netflix_web/widgets/list_widget.dart';
import 'package:netflix_web/widgets/drawer.dart';

int currentPage = 1;
bool loading = false;
late double currentWidth;
late ThemeData theme;
late NexBloc B;

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
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    B = NexBloc.get(context);
    B.getMovies(page: int.parse(widget.page!), categoryIndex: widget.categoryIndex);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    currentWidth = MediaQuery.of(context).size.width;
    theme = Theme.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NexBloc, NexState>(
      listener: (context, state) {},
      builder: (context, state) {
        currentPage = int.parse(widget.page!);
        return Scaffold(
          drawer: drawerWidget(theme: theme, context: context),
          backgroundColor: theme.canvasColor,
          appBar: AppBar(
            centerTitle: true,
            toolbarHeight: 70,
            title: Text(
              widget.title,
              style:
                  TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: theme.primaryColor),
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
                    listWidget(
                        currentWidth: currentWidth,
                        list: B.allMoviesList[currentPage] ?? [],
                        isMovie: true,
                        scrollController: scrollController,
                        page: currentPage),
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
                                    context.push(
                                        "/movies/${B.movieCategories[widget.categoryIndex]}/${1}");
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
                                    context.push(
                                        "/movies/${B.movieCategories[widget.categoryIndex]}/$currentPage");
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
                              context.push(
                                  "/movies/${B.movieCategories[widget.categoryIndex]}/$currentPage");
                            },
                            child: const Icon(Icons.arrow_forward),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }
}
