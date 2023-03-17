import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:netflix_web/widgets/list_widget.dart';
import 'package:netflix_web/bloc/nex_bloc.dart';
import 'package:netflix_web/widgets/app_bar.dart';

import '../../data/categories.dart';

late double currentWidth;
late ThemeData theme;
late NexBloc B;

// This is the main page
class TvPage extends StatefulWidget {
  final String page;
  final String category;

  const TvPage({Key? key, required this.category, required this.page}) : super(key: key);

  @override
  State<TvPage> createState() => _TvPageState();
}

class _TvPageState extends State<TvPage> {
  final ScrollController scrollController = ScrollController();
  final TextEditingController searchC = TextEditingController();
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
            if ({"popular", "top_rated", "airing_today", "on_the_air"}.contains(widget.category))
              {
                loadedPage = int.parse(widget.page),
                B.tvShowsList = [],
                B.getShows(page: currentPage, category: widget.category),
              }
            else
              {
                loadedPage = int.parse(widget.page),
                B.tvShowsList = [],
                B.getTvsGenre(page: currentPage, genre: tvCategories[widget.category]!),
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
            title: appBar(context: context, movie: false),
            backgroundColor: theme.canvasColor,
          ),
          body: B.tvShowsList.isEmpty
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
                                    B.searchShows(query: query);
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
                            ? B.searchedShows.isEmpty
                                ? B.tvShowsList
                                : B.searchedShows
                            : B.tvShowsList,
                        isMovie: false,
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
                                              context.go("/tv/${widget.category}/${1}");
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
                                              context.go("/tv/${widget.category}/$currentPage");
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
                                        context.go("/tv/${widget.category}/$currentPage");
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
