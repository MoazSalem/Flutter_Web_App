import 'package:flutter/material.dart';

Widget categoryWidget({required movie, required int index}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 2.0),
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
  );
}
