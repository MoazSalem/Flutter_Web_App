import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:netflix_web/widgets/list_widget.dart';
import 'package:netflix_web/widgets/drawer.dart';
import 'package:netflix_web/bloc/nex_bloc.dart';

int currentPage = 1;
late double currentWidth;
late ThemeData theme;
late ScrollController scrollController;
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
  bool loading = true;

  @override
  void initState() {
    super.initState();
    B = NexBloc.get(context);
    scrollController = ScrollController();
    currentPage = int.parse(widget.page!);
    B.getShows(page: currentPage, categoryIndex: widget.categoryIndex);
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
          body: ListView(
            physics: const BouncingScrollPhysics(),
            cacheExtent: 3500,
            children: [
              listWidget(
                  currentWidth: currentWidth,
                  list: B.tvShowsList,
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
                              B.tvShowsList = [];
                              context.push("/tv/${B.tvCategories[widget.categoryIndex]}/${1}");
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
                              B.tvShowsList = [];
                              context
                                  .push("/tv/${B.tvCategories[widget.categoryIndex]}/$currentPage");
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
                        B.tvShowsList = [];
                        context.push("/tv/${B.tvCategories[widget.categoryIndex]}/$currentPage");
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
