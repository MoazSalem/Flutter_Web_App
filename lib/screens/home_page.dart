import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:netflix_web/bloc/nex_bloc.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../widgets/drawer.dart';

late NexBloc B;
late ThemeData theme;
List<String> list = ["Go To Movies", "Go To Tv"];

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _current = 0;
  final TextEditingController searchC = TextEditingController();
  final CarouselController _controller = CarouselController();

  @override
  void initState() {
    super.initState();
    B = NexBloc.get(context);
    B.getPopular();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    theme = Theme.of(context);
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> imageSliders = B.popular
        .map((item) => GestureDetector(
              onTap: () {
                item.name == null
                    ? context.push('/movies/${item.id}')
                    : context.push('/tv/${item.id}');
              },
              child: Container(
                margin: const EdgeInsets.all(5.0),
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
                              lineWidth: 4.0,
                              percent: (item.voteAverage! / 10),
                              animation: true,
                              center: Text(
                                (item.voteAverage! * 10).toStringAsFixed(0),
                                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
                              ),
                              progressColor: progressColor(rating: (item.voteAverage! * 10)),
                            ),
                          ),
                        )
                      ],
                    )),
              ),
            ))
        .toList();
    return BlocConsumer<NexBloc, NexState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.black,
          drawer: drawerWidget(theme: theme, context: context),
          appBar: AppBar(
            centerTitle: true,
            toolbarHeight: 70,
            title: Text(
              "Netflix",
              style:
                  TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: theme.primaryColor),
            ),
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
                            aspectRatio: MediaQuery.of(context).size.width < 1600 ? 2.0 : 2.4,
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
                      padding: const EdgeInsets.only(top: 12.0),
                      child: GridView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: list.length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 2,
                            mainAxisSpacing: 20,
                            crossAxisSpacing: 20,
                            crossAxisCount: 2,
                          ),
                          itemBuilder: (BuildContext context, index) => GestureDetector(
                                onTap: () {
                                  index == 0
                                      ? context.push('/movies/popular/1')
                                      : context.push('/tv/popular/1');
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: theme.primaryColor),
                                  width: 60,
                                  child: Center(
                                      child: Text(
                                    list[index],
                                    style:
                                        const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                  )),
                                ),
                              )),
                    ),
                    GridView.builder(
                        padding: const EdgeInsets.all(20),
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: B.categoriesNames.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 2,
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 20,
                          crossAxisCount: 2,
                        ),
                        itemBuilder: (BuildContext context, index) => GestureDetector(
                              onTap: () {
                                //context.push('/movies/${B.categoriesNames[index]}/1');
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: theme.cardColor),
                                width: 60,
                                child: Center(
                                    child: Text(
                                  B.categoriesNames[index],
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                )),
                              ),
                            ))
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
              : Colors.deepPurpleAccent;
}
