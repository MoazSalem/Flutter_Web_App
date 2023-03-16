import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';

Widget reviewWidget({required B, required int index}) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                CircleAvatar(
                    radius: 26,
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
                                size: 30,
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
                    Row(
                      children: [
                        Text(
                          "A Review From ${B.reviews[index].author!}",
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                        ),
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
                                            color: Colors.deepPurpleAccent,
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
                    ),
                    Text("Written on ${B.reviews[index].createdAt!.split("T")[0]}")
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: ExpandableText(
              B.reviews[index].content!,
              expandText: 'Read More',
              collapseText: '... Show Less',
              maxLines: 3,
              linkColor: Colors.deepPurpleAccent,
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
