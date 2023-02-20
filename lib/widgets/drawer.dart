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
                onTap: () => context.go('/movies/popular'),
                title: const Text("Popular"),
                hoverColor: Colors.deepPurple),
            ListTile(
                onTap: () => context.go('/movies/top-rated'),
                title: const Text("Top Rated"),
                hoverColor: Colors.deepPurple),
            ListTile(
                onTap: () => context.go('/movies/now-playing'),
                title: const Text("Now Playing"),
                hoverColor: Colors.deepPurple),
            ListTile(
                onTap: () => context.go('/movies/upcoming'),
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
                onTap: () => context.go('/tv/popular'),
                title: const Text("Popular"),
                hoverColor: Colors.deepPurple),
            ListTile(
                onTap: () => context.go('/tv/top-rated'),
                title: const Text("Top Rated"),
                hoverColor: Colors.deepPurple),
            ListTile(
                onTap: () => context.go('/tv/airing-today'),
                title: const Text("Airing Today"),
                hoverColor: Colors.deepPurple),
            ListTile(
                onTap: () => context.go('/tv/on-the-air'),
                title: const Text("On The Air"),
                hoverColor: Colors.deepPurple)
          ],
        ),
      )
    ]),
  );
}
