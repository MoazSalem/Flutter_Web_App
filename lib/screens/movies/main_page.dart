import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tmdb_web/bloc/nex_bloc.dart';
import 'package:tmdb_web/widgets/app_bar.dart';

class MainMovies extends StatefulWidget {
  const MainMovies({Key? key}) : super(key: key);

  @override
  State<MainMovies> createState() => _MainMoviesState();
}

class _MainMoviesState extends State<MainMovies> {
  late NexBloc B;
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
              backgroundColor: Theme.of(context).canvasColor,
            ),
            backgroundColor: Colors.black,
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Movie Categories ",
                          style:
                              TextStyle(fontSize: 5.w > 26 ? 26 : 5.w, fontWeight: FontWeight.bold),
                        ),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 4.w > 20 ? 20 : 4.w,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0, bottom: 20),
                    child: GridView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
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
                              onTap: () {
                                context.go('/movies/${movieCategories[index]}/1');
                              },
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Theme.of(context).primaryColor),
                                width: 60,
                                child: Center(
                                    child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: FittedBox(
                                    child: Text(
                                      list[index],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 4.w > 30
                                              ? 100.w < 1200
                                                  ? 20
                                                  : 30
                                              : 100.w < 1200
                                                  ? 20
                                                  : 4.w),
                                    ),
                                  ),
                                )),
                              ),
                            )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Movie Genres ",
                          style:
                              TextStyle(fontSize: 5.w > 26 ? 26 : 5.w, fontWeight: FontWeight.bold),
                        ),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 4.w > 20 ? 20 : 4.w,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  GridView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
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
                      itemBuilder: (BuildContext context, index) => InkWell(
                            onTap: () {
                              context.go('/movies/${B.moviesGenres[index].toLowerCase()}/1');
                            },
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.blue.withOpacity(0.1)),
                              width: 60,
                              child: Center(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FittedBox(
                                  child: Text(
                                    B.moviesGenres[index],
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold, fontSize: 3.w > 25 ? 25 : 3.w),
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
