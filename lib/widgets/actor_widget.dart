import 'package:flutter/material.dart';

Widget actorWidget({required B, required int index}) {
  Color grey = Colors.grey.shade400;
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      width: 120,
      child: Column(
        children: [
          CircleAvatar(
              radius: 50,
              child: ClipOval(
                child: Image.network(
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                  "https://image.tmdb.org/t/p/w200${B.casts[index].profilePath}",
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 40,
                    );
                  },
                ),
              )),
          const SizedBox(
            height: 5,
          ),
          FittedBox(
            child: Text(
              "${B.casts[index].name}",
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
            ),
          ),
          Flexible(
            child: Text(
              "${B.casts[index].character?.split("/")[0]}",
              style: TextStyle(fontWeight: FontWeight.w100, fontSize: 10, color: grey),
            ),
          ),
          B.casts[index].character!.split("/").length > 1
              ? Column(
                  children: [
                    FittedBox(
                      child: Text(
                        "${B.casts[index].character?.split("/")[1]}",
                        style: TextStyle(fontWeight: FontWeight.w100, fontSize: 10, color: grey),
                      ),
                    ),
                    B.casts[index].character!.split("/").length > 2
                        ? FittedBox(
                            child: Text(
                              "${B.casts[index].character?.split("/")[2]}",
                              style:
                                  TextStyle(fontWeight: FontWeight.w100, fontSize: 10, color: grey),
                            ),
                          )
                        : Container(),
                  ],
                )
              : Container(),
        ],
      ),
    ),
  );
}
