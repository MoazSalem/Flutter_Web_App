import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Widget categoriesWidget({required movie, required int index, required BuildContext context}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 2.0),
    child: InkWell(
      borderRadius: BorderRadius.circular(30),
      onTap: () => context.go(
          "/${movie.title != null ? "movies" : "tv"}/${"${movie.genres![index].name}".toLowerCase()}/1"),
      child: SizedBox(
        child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            color: Colors.deepPurpleAccent,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SizedBox(
                height: 16,
                child: Center(
                  child: Text(
                    movie.genres![index].name,
                    style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                  ),
                ),
              ),
            )),
      ),
    ),
  );
}
