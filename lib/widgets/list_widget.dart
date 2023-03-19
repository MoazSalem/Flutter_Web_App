import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

Widget listWidget(
    {required List list,
    required ScrollController scrollController,
    required double currentWidth}) {
  return Scrollbar(
    controller: scrollController,
    thumbVisibility: true,
    child: GridView.builder(
      controller: scrollController,
      shrinkWrap: true,
      cacheExtent: 3500,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: currentWidth * 0.03, vertical: 10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 0.6685,
        mainAxisSpacing: 1,
        crossAxisCount: crossAxisCount(currentWidth: currentWidth),
      ),
      itemCount: list.length,
      itemBuilder: (BuildContext context, index) {
        return movieWidget(context: context, movie: list[index]);
      },
    ),
  );
}

int crossAxisCount({required currentWidth}) {
  int count = currentWidth ~/ 250;
  count == 1
      ? count = 2
      : count > 5
          ? count = 5
          : null;
  return count;
}

// This is the widget that is shown per movie/show in the main page.
Widget movieWidget({required movie, required BuildContext context}) {
  return InkWell(
    onTap: () =>
        movie.title != null ? context.go('/movies/${movie.id}') : context.go('/tv/${movie.id}'),
    child: Stack(
      alignment: Alignment.topRight,
      children: [
        SizedBox(
          child: Image.network(
            fit: BoxFit.fill,
            "https://image.tmdb.org/t/p/w500${movie.posterPath ?? ""}",
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
          padding: const EdgeInsets.all(12.0),
          child: CircleAvatar(
            radius: 30,
            backgroundColor: Colors.black54,
            child: CircularPercentIndicator(
              animationDuration: 3000,
              curve: Curves.bounceOut,
              radius: 30.0,
              lineWidth: 4.0,
              percent: (movie.voteAverage / 10),
              animation: true,
              center: Text(
                (movie.voteAverage * 10).toStringAsFixed(0),
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
              ),
              progressColor: progressColor(rating: (movie.voteAverage * 10)),
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
