import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tmdb_web/bloc/nex_bloc.dart';
import 'package:tmdb_web/widgets/app_bar.dart';
import 'package:tmdb_web/widgets/list_widget.dart';

final TextEditingController moviesSearch = TextEditingController();
final TextEditingController tvSearch = TextEditingController();

class SearchPage extends StatefulWidget {
  final bool movie;

  const SearchPage({Key? key, required this.movie}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late NexBloc B;
  late double width;
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    B = NexBloc.get(context);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    width = MediaQuery.of(context).size.width;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NexBloc, NexState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            centerTitle: true,
            toolbarHeight: 90,
            automaticallyImplyLeading: false,
            title: appBar(context: context, search: false),
            backgroundColor: Theme.of(context).canvasColor,
          ),
          body: ListView(
              physics: const BouncingScrollPhysics(),
              cacheExtent: 3500,
              shrinkWrap: true,
              children: [
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5.w),
                    child: TextFormField(
                        controller: widget.movie ? moviesSearch : tvSearch,
                        onChanged: (query) {
                          widget.movie ? B.searchMovies(query: query) : B.searchShows(query: query);
                        },
                        autofocus: true,
                        maxLines: 1,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Color(0xff8fcea2)),
                              borderRadius: BorderRadius.circular(0)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color(0xff09b5e1),
                              ),
                              borderRadius: BorderRadius.circular(0)),
                          hintText: "Search",
                          filled: true,
                          fillColor: Theme.of(context).cardColor,
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(0)),
                        )),
                  ),
                ),
                (widget.movie ? B.searchedMovies.isEmpty : B.searchedShows.isEmpty)
                    ? const SizedBox(height: 400, child: Center(child: Text("No Results")))
                    : Padding(
                        padding: EdgeInsets.all(2.w),
                        child: listWidget(
                          currentWidth: width,
                          list: widget.movie ? B.searchedMovies : B.searchedShows,
                          scrollController: scrollController,
                        ),
                      ),
              ]),
        );
      },
    );
  }
}
