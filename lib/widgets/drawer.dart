import 'package:flutter/material.dart';
import 'package:netflix_web/screens/movies/now_playing_page.dart';
import 'package:netflix_web/screens/movies/popular_page.dart';
import 'package:netflix_web/screens/movies/top_rated_page.dart';
import 'package:netflix_web/screens/movies/upcoming_page.dart';
import 'package:netflix_web/screens/tvShows//airing_today_page.dart';
import 'package:netflix_web/screens/tvShows/popular_page.dart';
import 'package:netflix_web/screens/tvShows/top_rated_page.dart';
import 'package:netflix_web/screens/tvShows/on_the_air_page.dart';

Widget drawerWidget({required ThemeData theme, required BuildContext context}) {
  return Drawer(
    backgroundColor: Colors.black,
    child: ListView(children: [
      Theme(
        data: theme.copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          initiallyExpanded: true,
          title: const Text(
            "Movies",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          children: [
            ListTile(
                onTap: () => Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => const PopularPage())),
                title: const Text("Popular"),
                hoverColor: Colors.deepPurple),
            ListTile(
                onTap: () => Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => const NowPlayingPage())),
                title: const Text("Now Playing"),
                hoverColor: Colors.deepPurple),
            ListTile(
                onTap: () => Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => const TopRatedPage())),
                title: const Text("Top Rated"),
                hoverColor: Colors.deepPurple),
            ListTile(
                onTap: () => Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => const UpcomingPage())),
                title: const Text("Upcoming"),
                hoverColor: Colors.deepPurple)
          ],
        ),
      ),
      Theme(
        data: theme.copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          initiallyExpanded: true,
          title: const Text(
            "Tv",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          children: [
            ListTile(
                onTap: () => Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => const PopularTPage())),
                title: const Text("Popular"),
                hoverColor: Colors.deepPurple),
            ListTile(
                onTap: () => Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => const TopRatedTPage())),
                title: const Text("Top Rated"),
                hoverColor: Colors.deepPurple),
            ListTile(
                onTap: () => Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => const AiringTodayPage())),
                title: const Text("Airing Today"),
                hoverColor: Colors.deepPurple),
            ListTile(
                onTap: () => Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => const OnTheAirPage())),
                title: const Text("On The Air"),
                hoverColor: Colors.deepPurple)
          ],
        ),
      )
    ]),
  );
}
