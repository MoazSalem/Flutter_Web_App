import 'package:flutter/material.dart';

import 'movie_widget.dart';

Widget listWidget(
    {required ScrollController scrollController,
    required double currentWidth,
    required List list}) {
  return Scrollbar(
    controller: scrollController,
    thumbVisibility: true,
    child: GridView.builder(
      controller: scrollController,
      shrinkWrap: false,
      cacheExtent: 2500,
      physics: const BouncingScrollPhysics(),
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
