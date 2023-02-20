import 'package:flutter/material.dart';

Widget drawerWidget({required ThemeData theme}) {
  return Drawer(
    backgroundColor: Colors.black,
    child: ListView(children: [
      Theme(
        data: theme.copyWith(dividerColor: Colors.transparent),
        child: const ExpansionTile(
          initiallyExpanded: true,
          title: Text(
            "Movies",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          children: [
            ListTile(title: Text("Popular"), hoverColor: Colors.deepPurple),
            ListTile(
              title: Text("Now Playing"),
            ),
            ListTile(
              title: Text("Top Rated"),
            ),
            ListTile(
              title: Text("Upcoming"),
            )
          ],
        ),
      )
    ]),
  );
}
