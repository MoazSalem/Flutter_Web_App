import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

Widget actorWidget({required B, required int index}) {
  Color grey = Colors.grey.shade400;
  return Padding(
    padding: EdgeInsets.all(2.w > 5 ? 5 : 2.w),
    child: SizedBox(
      width: 25.w > 120 ? 120 : 25.w,
      child: FittedBox(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
                backgroundColor: const Color(0xff0d9bc6),
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
            SizedBox(
              height: 0.5.h > 5 ? 5 : 0.5.h,
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
                style: TextStyle(fontSize: 10, color: grey),
              ),
            ),
            B.casts[index].character!.split("/").length > 1
                ? Column(
                    children: [
                      FittedBox(
                        child: Text(
                          "${B.casts[index].character?.split("/")[1]}",
                          style: TextStyle(fontSize: 10, color: grey),
                        ),
                      ),
                      B.casts[index].character!.split("/").length > 2
                          ? FittedBox(
                              child: Text(
                                "${B.casts[index].character?.split("/")[2]}",
                                style: TextStyle(fontSize: 10, color: grey),
                              ),
                            )
                          : Container(),
                    ],
                  )
                : Container(),
          ],
        ),
      ),
    ),
  );
}
