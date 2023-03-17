import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:netflix_web/bloc/nex_bloc.dart';
import 'package:netflix_web/widgets/list_widget.dart';
import 'package:netflix_web/widgets/app_bar.dart';

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
  final ScrollController scrollController = ScrollController();
  final TextEditingController searchC = TextEditingController();
  bool loading = false;
  bool search = false;
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
            loadedPage = int.parse(widget.page!),
            B.moviesList = [],
            B.getMovies(page: currentPage, categoryIndex: widget.categoryIndex),
          }
        : null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NexBloc, NexState>(
      listener: (context, state) {},
      builder: (context, state) {
        currentPage = int.parse(widget.page!);
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
                    search
                        ? Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: currentWidth * 0.031),
                              child: TextFormField(
                                  controller: searchC,
                                  onChanged: (query) {
                                    B.searchMovies(query: query);
                                  },
                                  autofocus: true,
                                  maxLines: 1,
                                  decoration: InputDecoration(
                                    contentPadding:
                                        const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.grey.shade300),
                                        borderRadius: BorderRadius.circular(0)),
                                    hintText: "Search",
                                    filled: true,
                                    fillColor: Theme.of(context).cardColor,
                                    border:
                                        OutlineInputBorder(borderRadius: BorderRadius.circular(0)),
                                  )),
                            ),
                          )
                        : Container(),
                    listWidget(
                        currentWidth: currentWidth,
                        list: search
                            ? B.searchedMovies.isEmpty
                                ? B.moviesList
                                : B.searchedMovies
                            : B.moviesList,
                        isMovie: true,
                        scrollController: scrollController,
                        page: search ? 0 : currentPage),
                    search
                        ? Container()
                        : Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 15.0),
                                child: Center(
                                    child: Text(
                                  "Page $currentPage",
                                )),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0, right: 8.0, top: 8.0, bottom: 16.0),
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
                                              context.go(
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
                                              context.go(
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
                                        context.go(
                                            "/movies/${B.movieCategories[widget.categoryIndex]}/$currentPage");
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
