import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

Widget reviewWidget({required B, required int index}) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Card(
      color: Colors.grey.withOpacity(0.2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 20.0, bottom: 5.0),
            child: SizedBox(
              width: 80.w > 350 ? 350 : 80.w,
              child: FittedBox(
                child: Row(
                  children: [
                    CircleAvatar(
                        backgroundColor: const Color(0xff0d9bc6),
                        radius: 30,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: SizedBox(
                            width: 100,
                            height: 100,
                            child: Image.network(
                              B.reviews[index].authorDetails?.avatarPath != null
                                  ? B.reviews[index].authorDetails?.avatarPath!
                                              .split("/")[1]
                                              .split(":")[0] ==
                                          "https"
                                      ? B.reviews[index].authorDetails!.avatarPath!
                                      : "https://image.tmdb.org/t/p/w200${B.reviews[index].authorDetails?.avatarPath}"
                                  : "",
                              fit: BoxFit.fill,
                              errorBuilder: (context, error, stackTrace) {
                                return const SizedBox(
                                  width: 30,
                                  height: 60,
                                  child: Icon(
                                    Icons.person,
                                    size: 36,
                                  ),
                                );
                              },
                            ),
                          ),
                        )),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          child: Text(
                            "A Review From ${B.reviews[index].author!}",
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ),
                        Row(
                          children: [
                            Text("Written on ${B.reviews[index].createdAt!.split("T")[0]}"),
                            B.reviews[index].authorDetails!.rating == null
                                ? Container()
                                : Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Card(
                                      color: Colors.black,
                                      child: Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                          child: Row(
                                            children: [
                                              const Icon(
                                                Icons.star,
                                                size: 18,
                                                color: Color(0xff8fcea2),
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                "${B.reviews[index].authorDetails!.rating}",
                                                style: const TextStyle(fontWeight: FontWeight.bold),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: ExpandableText(
              B.reviews[index].content!,
              expandText: 'Read More',
              style: TextStyle(
                fontSize: 4.w > 18 ? 18 : 4.w,
              ),
              collapseText: '... Show Less',
              maxLines: 3,
              linkColor: const Color(0xff8fcea2),
            ),
          ),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    ),
  );
}
