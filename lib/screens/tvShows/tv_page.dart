import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:netflix_web/widgets/list_widget.dart';
import 'package:netflix_web/widgets/drawer.dart';
import 'package:netflix_web/bloc/nex_bloc.dart';

int currentPage = 1;
int loadedPage = 0;
late double currentWidth;
late ThemeData theme;
late NexBloc B;

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
  final ScrollController scrollController = ScrollController();
  final TextEditingController searchC = TextEditingController();
  bool search = false;

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
            B.tvShowsList = [],
            B.getShows(page: currentPage, categoryIndex: widget.categoryIndex),
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
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                    onPressed: () {
                      setState(() {
                        search = !search;
                      });
                    },
                    icon: Icon(
                      Icons.search,
                      color: search ? theme.primaryColor : Colors.white,
                    )),
              )
            ],
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
                                              context.go(
                                                  "/tv/${B.tvCategories[widget.categoryIndex]}/${1}");
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
                                              context.go(
                                                  "/tv/${B.tvCategories[widget.categoryIndex]}/$currentPage");
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
                                        context.go(
                                            "/tv/${B.tvCategories[widget.categoryIndex]}/$currentPage");
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
