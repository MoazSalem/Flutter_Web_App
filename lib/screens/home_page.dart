import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:tmdb_web/bloc/nex_bloc.dart';
import 'package:tmdb_web/widgets/suggestion_widget.dart';
import 'package:tmdb_web/widgets/app_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late NexBloc B;
  late ThemeData theme;
  late double width;
  int _current = 0;
  final TextEditingController searchC = TextEditingController();
  final CarouselController _controller = CarouselController();

  @override
  void initState() {
    super.initState();
    B = NexBloc.get(context);
    B.getPopular();
    B.getMovies(page: 1, category: "popular");
    B.getShows(page: 1, category: "popular");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    theme = Theme.of(context);
    width = MediaQuery.of(context).size.width;
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> imageSliders = B.popular
        .map((item) => GestureDetector(
              onTap: () {
                item.name == null ? context.go('/movies/${item.id}') : context.go('/tv/${item.id}');
              },
              child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                        child: Image.network(
                            "https://image.tmdb.org/t/p/original/${item.backdropPath}",
                            fit: BoxFit.cover),
                      ),
                      Positioned(
                        bottom: 0.0,
                        left: 0.0,
                        right: 0.0,
                        child: Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color.fromARGB(200, 0, 0, 0), Color.fromARGB(0, 0, 0, 0)],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                          child: Text(
                            '${item.name ?? item.title}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 10.0,
                        right: 10.0,
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.black54,
                          child: CircularPercentIndicator(
                            animationDuration: 3000,
                            curve: Curves.bounceOut,
                            radius: 30.0,
                            lineWidth: 5.0,
                            percent: (item.voteAverage! / 10),
                            animation: true,
                            center: Text(
                              (item.voteAverage! * 10).toStringAsFixed(0),
                              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                            ),
                            progressColor: progressColor(rating: (item.voteAverage! * 10)),
                            backgroundColor: Colors.white24,
                          ),
                        ),
                      )
                    ],
                  )),
            ))
        .toList();
    return BlocConsumer<NexBloc, NexState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            centerTitle: true,
            toolbarHeight: 90,
            title: appBar(context: context, showSearch: false),
            backgroundColor: theme.canvasColor,
          ),
          body: B.popular.isEmpty
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView(
                  children: [
                    Column(children: [
                      CarouselSlider(
                        items: imageSliders,
                        carouselController: _controller,
                        options: CarouselOptions(
                            autoPlay: true,
                            enlargeCenterPage: true,
                            aspectRatio: width < 1600 ? 2.0 : 2.4,
                            onPageChanged: (index, reason) {
                              setState(() {
                                _current = index;
                              });
                            }),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: B.popular.asMap().entries.map((entry) {
                          return Container(
                            width: 6.0,
                            height: 6.0,
                            margin: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 4.0),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: (Theme.of(context).brightness == Brightness.dark
                                        ? Colors.white
                                        : Colors.black)
                                    .withOpacity(_current == entry.key ? 0.9 : 0.4)),
                          );
                        }).toList(),
                      ),
                    ]),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            borderRadius: const BorderRadius.all(Radius.circular(30)),
                            onTap: () => context.go('/movies'),
                            child: const Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Movies ",
                                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 20,
                                  )
                                ],
                              ),
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
                              child: SizedBox(
                                height: 400,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: B.moviesList.length,
                                    itemBuilder: (BuildContext context, int index) =>
                                        GestureDetector(
                                          onTap: () =>
                                              context.go('/movies/${B.moviesList[index].id}'),
                                          child: suggestionWidget(
                                              index: index, suggestions: B.moviesList),
                                        )),
                              )),
                          InkWell(
                            borderRadius: const BorderRadius.all(Radius.circular(30)),
                            onTap: () => context.go('/tv'),
                            child: const Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Tv Shows ",
                                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 20,
                                  )
                                ],
                              ),
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
                              child: SizedBox(
                                height: 400,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: B.tvShowsList.length,
                                    itemBuilder: (BuildContext context, int index) =>
                                        GestureDetector(
                                          onTap: () => context.go('/tv/${B.tvShowsList[index].id}'),
                                          child: suggestionWidget(
                                              index: index, suggestions: B.tvShowsList),
                                        )),
                              )),
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

Color progressColor({required double rating}) {
  return rating <= 25
      ? Colors.red
      : rating > 25 && rating <= 50
          ? Colors.red.shade300
          : rating > 50 && rating < 70
              ? Colors.yellow
              : Colors.greenAccent;
}
