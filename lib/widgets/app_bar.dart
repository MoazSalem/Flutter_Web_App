import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

Widget appBar(
    {required BuildContext context,
    bool search = true,
    bool showSearch = true,
    bool movie = true}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    mainAxisSize: MainAxisSize.max,
    children: [
      SizedBox(
        width: 85.w > 400 ? 400 : 85.w,
        child: FittedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(30),
                    onTap: () => context.go('/'),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
                      child: Row(
                        children: [
                          GradientText(
                            "TMDB",
                            style: const TextStyle(
                              fontSize: 34,
                              letterSpacing: 3,
                              fontWeight: FontWeight.w900,
                            ),
                            colors: const [Color(0xff8fcea2), Color(0xff2dbbcf)],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 6.0),
                            child: Container(
                              height: 20,
                              width: 60,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  gradient: const LinearGradient(
                                    colors: [Color(0xff2dbbcf), Color(0xff03b4e4)],
                                    stops: [0, 1],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                  )),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => context.go('/movies'),
                    child: const SizedBox(
                      width: 60,
                      height: 35,
                      child: Center(
                        child: Text("Movies",
                            style: TextStyle(
                                color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => context.go('/tv'),
                    child: const SizedBox(
                      width: 70,
                      height: 35,
                      child: Center(
                        child: Text("Tv Shows",
                            style: TextStyle(
                                color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: showSearch
                    ? search
                        ? InkWell(
                            borderRadius: BorderRadius.circular(30),
                            onTap: () => context.go('/${movie ? "movies" : "tv"}/search'),
                            child: const CircleAvatar(
                              backgroundColor: Colors.transparent,
                              radius: 30,
                              child: Icon(
                                Icons.search,
                                size: 30,
                                color: Color(0xff01b4e4),
                              ),
                            ),
                          )
                        : InkWell(
                            borderRadius: BorderRadius.circular(30),
                            onTap: () => context.pop(),
                            child: const CircleAvatar(
                              backgroundColor: Colors.transparent,
                              radius: 30,
                              child: Icon(
                                Icons.close,
                                size: 30,
                                color: Colors.white,
                              ),
                            ),
                          )
                    : Container(),
              )
            ],
          ),
        ),
      ),
    ],
  );
}
