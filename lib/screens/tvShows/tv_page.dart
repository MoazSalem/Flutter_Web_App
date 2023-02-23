import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:netflix_web/services/tv_service.dart';
import 'package:netflix_web/data/end_points.dart';
import 'package:netflix_web/widgets/list_widget.dart';
import 'package:netflix_web/widgets/drawer.dart';

int currentPage = 1;
List<String> tvCategories = ["popular", "airing_today", "top_rated", "on_the_air"];

// This is the main page
class TvPage extends StatefulWidget {
  final String? page;
  final int categoryIndex;
  final String title;

  const TvPage({Key? key, required this.categoryIndex, required this.title, this.page})
      : super(key: key);

  @override
  State<TvPage> createState() => _TvPageState();
}

class _TvPageState extends State<TvPage> {
  late List tvShowsList;
  bool loading = true;

  getMovies({required int page}) async {
    currentPage = int.parse(widget.page!);
    tvShowsList = await TVService().getShows(
        page: page,
        endPoint: getEndPoint(category: tvCategories[widget.categoryIndex], typeIndex: 1));
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
                listWidget(
                    currentWidth: currentWidth,
                    list: tvShowsList,
                    isMovie: false,
                    scrollController: scrollController),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: Center(
                      child: Text(
                    "Page $currentPage",
                  )),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
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
                            : () async {
                                currentPage = 1;
                                setState(() {
                                  loading = true;
                                });
                                context.go("/tv/${tvCategories[widget.categoryIndex]}/${1}");
                              },
                        child: const Icon(Icons.home_filled),
                      ),
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          minimumSize: Size(currentWidth * 0.3, 50),
                        ),
                        onPressed: currentPage == 1
                            ? null
                            : () async {
                                currentPage--;
                                setState(() {
                                  loading = true;
                                });
                                context
                                    .go("/tv/${tvCategories[widget.categoryIndex]}/$currentPage");
                              },
                        child: const Icon(Icons.arrow_back),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: theme.primaryColor,
                          minimumSize: Size(currentWidth * 0.3, 50),
                        ),
                        onPressed: () async {
                          currentPage++;
                          setState(() {
                            loading = true;
                          });
                          setState(() {});
                          context.go("/tv/${tvCategories[widget.categoryIndex]}/$currentPage");
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
