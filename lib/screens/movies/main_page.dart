import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:netflix_web/bloc/nex_bloc.dart';
import 'package:netflix_web/widgets/app_bar.dart';

class MainMovies extends StatefulWidget {
  const MainMovies({Key? key}) : super(key: key);

  @override
  State<MainMovies> createState() => _MainMoviesState();
}

class _MainMoviesState extends State<MainMovies> {
  late NexBloc B;
  late ThemeData theme;
  late double width;
  List<String> list = ["Popular", "Top Rated", "Now Playing", "Upcoming"];
  List<String> movieCategories = ["popular", "top_rated", "now_playing", "upcoming"];

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
              title: appBar(context: context),
              backgroundColor: theme.canvasColor,
            ),
            backgroundColor: Colors.black,
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text(
                      "Movie Categories :",
                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
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
                        itemBuilder: (BuildContext context, index) => GestureDetector(
                              onTap: () {
                                context.push('/movies/${movieCategories[index]}/1');
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
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold, fontSize: 20),
                                    ),
                                  ),
                                )),
                              ),
                            )),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text(
                      "Movie Genres :",
                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 20),
                  GridView.builder(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: B.moviesGenres.length,
                      cacheExtent: 20,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 2,
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 20,
                        crossAxisCount: width <= 700 ? 3 : 4,
                      ),
                      itemBuilder: (BuildContext context, index) => GestureDetector(
                            onTap: () {
                              context.go('/movies/${B.moviesGenres[index].toLowerCase()}/1');
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10), color: theme.cardColor),
                              width: 60,
                              child: Center(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FittedBox(
                                  child: Text(
                                    B.moviesGenres[index],
                                    style:
                                        const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
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
