import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:netflix_web/bloc/nex_bloc.dart';

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
            backgroundColor: Colors.black,
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text(
                      "Movies :",
                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0, bottom: 20),
                    child: GridView.builder(
                        padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: list.length,
                        cacheExtent: 20,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 2,
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 20,
                          crossAxisCount: 2,
                        ),
                        itemBuilder: (BuildContext context, index) => GestureDetector(
                              onTap: () {
                                context.push('/movies/${B.movieCategories[index]}/1');
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: theme.primaryColor),
                                width: 60,
                                child: Center(
                                    child: Text(
                                  list[index],
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                )),
                              ),
                            )),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text(
                      "Categories :",
                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 20),
                  GridView.builder(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: B.categoriesNames.length,
                      cacheExtent: 20,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 2,
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 20,
                        crossAxisCount: 4,
                      ),
                      itemBuilder: (BuildContext context, index) => GestureDetector(
                            onTap: () {
                              context.go(
                                  '/movies/categories/${B.categoriesNames[index].toLowerCase()}/1');
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
                                    B.categoriesNames[index],
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
