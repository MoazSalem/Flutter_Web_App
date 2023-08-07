import 'package:flutter/material.dart';

Widget suggestionWidget({
  required int index,
  required suggestions,
}) {
  return Padding(
    padding: const EdgeInsets.all(4.0),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Column(
        children: [
          SizedBox(
            height: 260,
            width: 160,
            child: Image.network(
              fit: BoxFit.fitHeight,
              "https://image.tmdb.org/t/p/w400${suggestions[index].posterPath ?? ""}",
              errorBuilder: (context, error, stackTrace) {
                return const SizedBox(
                  width: 60,
                  height: 100,
                  child: Icon(
                    Icons.question_mark_rounded,
                    size: 100,
                  ),
                );
              },
            ),
          ),
          Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
                color: Colors.white12),
            height: 120,
            width: 160,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Color(0xff8fcea2),
                        size: 16,
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(
                          suggestions[index]
                              .voteAverage!
                              .toStringAsFixed(1)
                              .replaceFirst(RegExp(r'\.?'), ''),
                          style: const TextStyle(
                              color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500)),
                      Text(
                          suggestions[index].voteCount! > 1000
                              ? "/10 (${(suggestions[index].voteCount! / 1000).toStringAsFixed(2)}K)"
                              : "/10 (${suggestions[index].voteCount})",
                          style: TextStyle(fontSize: 14, color: Colors.grey.shade400)),
                    ],
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "${suggestions[index].title ?? suggestions[index].name} (${(suggestions[index].releaseDate ?? suggestions[index].firstAirDate).split("-")[0]})",
                      style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w500),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ),
  );
}
