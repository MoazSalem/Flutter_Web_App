import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:netflix_web/models/tv.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

// This is the widget that is shown per movie in the main page.
Widget showWidget({required TvShows show, required int page, required BuildContext context}) {
  return GestureDetector(
    onTap: () => context.push('/tv/${show.id}'),
    child: Stack(
      alignment: Alignment.topRight,
      children: [
        SizedBox(
          child: Image.network(
            fit: BoxFit.fill,
            "https://image.tmdb.org/t/p/w500${show.posterPath ?? ""}",
            errorBuilder: (context, error, stackTrace) {
              return const SizedBox(
                width: 300,
                height: 600,
                child: Icon(
                  Icons.question_mark_rounded,
                  size: 300,
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            radius: 24,
            backgroundColor: Colors.black54,
            child: CircularPercentIndicator(
              animationDuration: 3000,
              curve: Curves.bounceOut,
              radius: 24.0,
              lineWidth: 3.0,
              percent: (show.voteAverage! / 10),
              animation: true,
              center: Text(
                (show.voteAverage! * 10).toStringAsFixed(0),
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
              ),
              progressColor: progressColor(rating: (show.voteAverage! * 10)),
            ),
          ),
        )
      ],
    ),
  );
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
