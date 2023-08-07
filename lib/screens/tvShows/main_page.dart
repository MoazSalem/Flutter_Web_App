import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tmdb_web/bloc/nex_bloc.dart';
import 'package:tmdb_web/widgets/app_bar.dart';

class MainTv extends StatefulWidget {
  const MainTv({Key? key}) : super(key: key);

  @override
  State<MainTv> createState() => _MainTvState();
}

class _MainTvState extends State<MainTv> {
  late NexBloc B;
  late ThemeData theme;
  late double width;
  late double fontSize;
  List<String> list = ["Popular", "Top Rated", "Airing Today", "On The Air"];
  List<String> tvCategories = ["popular", "top_rated", "airing_today", "on_the_air"];

  @override
  void initState() {
    super.initState();
    B = NexBloc.get(context);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    theme = Theme.of(context);
    width = MediaQuery.of(context).size.width;
    fontSize = width < 700
        ? width * 0.04
        : width < 800
            ? width * 0.025
            : width < 1400
                ? width * 0.02
                : width * 0.015;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NexBloc, NexState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              toolbarHeight: 90,
              automaticallyImplyLeading: false,
              title: appBar(context: context, movie: false),
              backgroundColor: theme.canvasColor,
            ),
            backgroundColor: Colors.black,
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Tv Categories ",
                          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                        ),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 20,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0, bottom: 20),
                    child: GridView.builder(
                        padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: list.length,
                        cacheExtent: 20,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 2,
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 20,
                          crossAxisCount: width <= 700 ? 2 : 4,
                        ),
                        itemBuilder: (BuildContext context, index) => InkWell(
                          borderRadius: BorderRadius.circular(10),
                              onTap: () {
                                context.go('/tv/${tvCategories[index]}/1');
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: theme.primaryColor),
                                width: 60,
                                child: Center(
                                    child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: FittedBox(
                                    child: Text(
                                      list[index],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold, fontSize: fontSize),
                                    ),
                                  ),
                                )),
                              ),
                            )),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Tv Genres  ",
                          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                        ),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 20,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  GridView.builder(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: B.tvGenres.length,
                      cacheExtent: 20,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 2,
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 20,
                        crossAxisCount: width <= 700 ? 3 : 4,
                      ),
                      itemBuilder: (BuildContext context, index) => Container(
                        decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10), color: Colors.blue.withOpacity(0.1)),
                        width: 60,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10),
                          onTap: () {
                                context.go('/tv/${B.tvGenres[index].toLowerCase()}/1');
                              },
                          child: Center(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FittedBox(
                                  child: Text(
                                    B.tvGenres[index],
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold, fontSize: fontSize),
                                  ),
                                ),
                              )),
                        ),
                      )),
                  const SizedBox(height: 20),
                ],
              ),
            ));
      },
    );
  }
}
