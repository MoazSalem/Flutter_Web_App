import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
                onTap: () => context.go('/movies/popular/${1}'),
                title: const Text("Popular"),
                hoverColor: Colors.deepPurple),
            ListTile(
                onTap: () => context.go('/movies/top_rated/${1}'),
                title: const Text("Top Rated"),
                hoverColor: Colors.deepPurple),
            ListTile(
                onTap: () => context.go('/movies/now_playing/${1}'),
                title: const Text("Now Playing"),
                hoverColor: Colors.deepPurple),
            ListTile(
                onTap: () => context.go('/movies/upcoming/${1}'),
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
                onTap: () => context.go('/tv/popular/${1}'),
                title: const Text("Popular"),
                hoverColor: Colors.deepPurple),
            ListTile(
                onTap: () => context.go('/tv/top_rated/${1}'),
                title: const Text("Top Rated"),
                hoverColor: Colors.deepPurple),
            ListTile(
                onTap: () => context.go('/tv/airing_today/${1}'),
                title: const Text("Airing Today"),
                hoverColor: Colors.deepPurple),
            ListTile(
                onTap: () => context.go('/tv/on_the_air/${1}'),
                title: const Text("On The Air"),
                hoverColor: Colors.deepPurple)
          ],
        ),
      )
    ]),
  );
}
