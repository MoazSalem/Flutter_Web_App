import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:tmdb_web/bloc/nex_bloc.dart';
import 'package:tmdb_web/widgets/suggestion_widget.dart';
import 'package:tmdb_web/widgets/app_bar.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late NexBloc B;
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

  // This is left to update the ui when the size changes
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
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
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: "https://image.tmdb.org/t/p/w1280/${item.backdropPath}",
                          placeholder: (context, url) => SizedBox(
                              height: 26.5.h,
                              width: 80.w,
                              child: const SizedBox(
                                  height: 60,
                                  width: 60,
                                  child: Center(
                                      child: CircularProgressIndicator(
                                    color: Color(0xff55c3bd),
                                  )))),
                          errorWidget: (context, url, error) => const Icon(Icons.error),
                        ),
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
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 5.w > 20 ? 20 : 5.w,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 10.0,
                        right: 10.0,
                        child: SizedBox(
                          width: 10.w > 70 ? 70 : 10.w,
                          child: FittedBox(
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
            backgroundColor: Theme.of(context).canvasColor,
          ),
          body: B.popular.isEmpty
              ? const Center(
                  child: CircularProgressIndicator(color: Color(0xff09b5e1)),
                )
              : ListView(
                  children: [
                    Column(children: [
                      SizedBox(
                        height: 100.w > 800 ? 50.h : 30.h,
                        child: CarouselSlider(
                          items: imageSliders,
                          carouselController: _controller,
                          options: CarouselOptions(
                              autoPlay: true,
                              clipBehavior: Clip.none,
                              enlargeCenterPage: true,
                              padEnds: true,
                              aspectRatio: width < 1400 ? 2.0 : 2.0,
                              viewportFraction: 0.9,
                              enlargeStrategy: CenterPageEnlargeStrategy.zoom,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  _current = index;
                                });
                              }),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 100.w > 400 ? 5.h : 2.h),
                        child: SizedBox(
                          width: 50.w > 500 ? 500 : 50.w,
                          child: FittedBox(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: B.popular.asMap().entries.map((entry) {
                                return InkWell(
                                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                                  onTap: () => _controller.animateToPage(entry.key),
                                  child: Container(
                                    width: 6.0,
                                    height: 6.0,
                                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: (Theme.of(context).brightness == Brightness.dark
                                                ? Colors.white
                                                : Colors.black)
                                            .withOpacity(_current == entry.key ? 0.9 : 0.4)),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
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
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Movies ",
                                    style: TextStyle(
                                        fontSize: 5.w > 26 ? 26 : 5.w, fontWeight: FontWeight.bold),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 4.w > 20 ? 20 : 4.w,
                                  )
                                ],
                              ),
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
                              child: SizedBox(
                                height: 70.w > 400 ? 400 : 70.w,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: B.moviesList.length,
                                    itemBuilder: (BuildContext context, int index) => InkWell(
                                          borderRadius: const BorderRadius.all(Radius.circular(30)),
                                          onTap: () =>
                                              context.go('/movies/${B.moviesList[index].id}'),
                                          child: FittedBox(
                                            child: suggestionWidget(
                                                index: index, suggestions: B.moviesList),
                                          ),
                                        )),
                              )),
                          InkWell(
                            borderRadius: const BorderRadius.all(Radius.circular(30)),
                            onTap: () => context.go('/tv'),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Tv Shows ",
                                    style: TextStyle(
                                        fontSize: 5.w > 26 ? 26 : 5.w, fontWeight: FontWeight.bold),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 4.w > 20 ? 20 : 4.w,
                                  )
                                ],
                              ),
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
                              child: SizedBox(
                                height: 70.w > 400 ? 400 : 70.w,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: B.tvShowsList.length,
                                    itemBuilder: (BuildContext context, int index) => InkWell(
                                          borderRadius: const BorderRadius.all(Radius.circular(30)),
                                          onTap: () => context.go('/tv/${B.tvShowsList[index].id}'),
                                          child: FittedBox(
                                            child: suggestionWidget(
                                                index: index, suggestions: B.tvShowsList),
                                          ),
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
