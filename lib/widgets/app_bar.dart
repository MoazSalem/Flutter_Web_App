import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Widget appBar({required BuildContext context, bool showSearch = true, bool movie = true}) {
  return Row(
    mainAxisSize: MainAxisSize.max,
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      // placeholder to center the title
      showSearch
          ? const CircleAvatar(
              radius: 18,
              backgroundColor: Colors.transparent,
            )
          : Container(),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(Colors.deepPurpleAccent.withOpacity(0.15))),
          onPressed: () => context.go('/movies'),
          child: const SizedBox(
            width: 80,
            height: 35,
            child: Center(
              child: Text("Movies",
                  style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
            ),
          ),
        ),
      ),
      Text("Netflix",
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          )),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(Colors.deepPurpleAccent.withOpacity(0.15))),
          onPressed: () => context.go('/tv'),
          child: const SizedBox(
            width: 80,
            height: 35,
            child: Center(
              child: Text("Tv Shows",
                  style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
            ),
          ),
        ),
      ),
      showSearch
          ? InkWell(
              borderRadius: BorderRadius.circular(30),
              onTap: () => context.go('/${movie ? "movies" : "tv"}/search'),
              child: CircleAvatar(
                radius: 18,
                backgroundColor: Colors.deepPurpleAccent.withOpacity(0.2),
                child: const Icon(
                  Icons.search,
                  size: 18,
                ),
              ),
            )
          : Container(),
    ],
  );
}
