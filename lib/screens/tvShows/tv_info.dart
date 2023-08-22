import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:auto_animated/auto_animated.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:tmdb_web/cubit/tmdb_cubit.dart';
import 'package:tmdb_web/models/tv.dart';
import 'package:tmdb_web/widgets/suggestion_widget.dart';
import 'package:tmdb_web/widgets/actor_widget.dart';
import 'package:tmdb_web/widgets/categories_widget.dart';
import 'package:tmdb_web/widgets/review_widget.dart';
import '../home_page.dart';

// This page is opened when you press on a tv show
class TvInfo extends StatefulWidget {
  final String id;

  const TvInfo({Key? key, required this.id}) : super(key: key);

  @override
  State<TvInfo> createState() => _TvInfoState();
}

class _TvInfoState extends State<TvInfo> {
  late double width;
  final ScrollController scrollController = ScrollController();
  final Color grey = Colors.grey.shade400;
  bool videoPressed = false;
  bool loading = true;
  bool seeMore = false;
  int parsedId = 0;

  @override
  void initState() {
    super.initState();
    C.casts = [];
    C.show = TvShows();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    width = MediaQuery.of(context).size.width;
  }

  changeShow() {
    parsedId != int.parse(widget.id)
        ? {
            C.videoController = YoutubePlayerController(
              params: const YoutubePlayerParams(
                mute: false,
                showControls: true,
                showFullscreenButton: true,
              ),
            ),
            parsedId = int.parse(widget.id),
            C.show = TvShows(),
            C.getShow(id: parsedId),
          }
        : null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TmdbCubit, TmdbState>(
      builder: (context, state) {
        changeShow();
        return Scaffold(
          backgroundColor: Theme.of(context).canvasColor,
          body: C.show.name == null
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Color(0xff09b5e1),
                  ),
                )
              : ListView(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 50.h,
                      child: C.show.posterPath != ""
                          ? Image.network(
                              fit: BoxFit.cover,
                              "https://image.tmdb.org/t/p/original/${C.show.backdropPath ?? C.show.posterPath}",
                              errorBuilder: (context, error, stackTrace) {
                                return const SizedBox(
                                  width: 300,
                                  height: 600,
                                  child: FittedBox(
                                    child: Icon(
                                      Icons.question_mark_rounded,
                                      size: 300,
                                    ),
                                  ),
                                );
                              },
                            )
                          : Container(),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0, top: 20),
                            child: Text(
                              C.show.name!,
                              style: TextStyle(
                                fontSize: 6.w > 30 ? 30 : 6.w,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0),
                            child: SizedBox(
                              width: 90.w > 550 ? 550 : 90.w,
                              child: FittedBox(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text("${C.show.status}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 4.w > 18 ? 18 : 4.w,
                                            color: const Color(0xff8fcea2))),
                                    const Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 5.0),
                                      child: Text("-"),
                                    ),
                                    Text(
                                        "${C.show.numberOfSeasons} Season${C.show.numberOfSeasons! > 1 ? "s" : ""}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 4.w > 18 ? 18 : 4.w,
                                            color: const Color(0xff8fcea2))),
                                    const Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 5.0),
                                      child: Text("-"),
                                    ),
                                    Text("${C.show.numberOfEpisodes} Episodes",
                                        style:
                                            TextStyle(fontSize: 4.w > 18 ? 18 : 4.w, color: grey)),
                                    const Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 5.0),
                                      child: Text("-"),
                                    ),
                                    Text(runtimeToHours(C.show.episodeRunTime!),
                                        style:
                                            TextStyle(fontSize: 4.w > 18 ? 18 : 4.w, color: grey)),
                                    const Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 5.0),
                                      child: Text("-"),
                                    ),
                                    Text(C.show.firstAirDate!.split('-')[0],
                                        style:
                                            TextStyle(fontSize: 4.w > 18 ? 18 : 4.w, color: grey)),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          C.show.genres!.isNotEmpty
                              ? SizedBox(
                                  width: 90.w > 120 * C.show.genres!.length
                                      ? (120 * C.show.genres!.length).toDouble()
                                      : 90.w,
                                  child: FittedBox(
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.symmetric(vertical: 8.0, horizontal: 5),
                                      child: SizedBox(
                                          height: 44,
                                          child: ListView.builder(
                                              itemCount: C.show.genres!.length,
                                              shrinkWrap: true,
                                              scrollDirection: Axis.horizontal,
                                              itemBuilder: (
                                                BuildContext context,
                                                int index,
                                              ) =>
                                                  categoriesWidget(
                                                      index: index,
                                                      movie: C.show,
                                                      context: context))),
                                    ),
                                  ),
                                )
                              : Container(),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              C.show.overview!,
                              style: TextStyle(
                                  fontSize: 4.w > 18
                                      ? 100.w > 1200
                                          ? 22
                                          : 18
                                      : 4.w,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white),
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: const Color(0xff8fcea2),
                                    size: 4.w > 18 ? 18 : 4.w,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                      C.show.voteAverage!
                                          .toStringAsFixed(1)
                                          .replaceFirst(RegExp(r'\.?'), ''),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 4.w > 18 ? 18 : 4.w,
                                          fontWeight: FontWeight.bold)),
                                  Text(
                                      C.show.voteCount! > 1000
                                          ? "/10 (${(C.show.voteCount! / 1000).toStringAsFixed(2)}K)"
                                          : "/10 (${C.show.voteCount})",
                                      style: TextStyle(fontSize: 4.w > 18 ? 18 : 4.w, color: grey)),
                                ],
                              )),
                          const SizedBox(height: 10),
                          C.trailer.key != ""
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0, vertical: 15),
                                      child: Text(
                                        "Trailer :",
                                        style: TextStyle(
                                            fontSize: 5.w > 24 ? 24 : 5.w,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Center(
                                        child: ConstrainedBox(
                                          constraints: const BoxConstraints(
                                            maxHeight: 1200,
                                            maxWidth: 1200,
                                          ),
                                          child: Stack(children: [
                                            YoutubePlayer(
                                              controller: C.videoController,
                                              aspectRatio: 16 / 9,
                                            ),
                                            PointerInterceptor(
                                              child: InkWell(
                                                onTap: () {
                                                  videoPressed
                                                      ? C.videoController.pauseVideo()
                                                      : C.videoController.playVideo();
                                                  videoPressed = !videoPressed;
                                                },
                                                child: const AspectRatio(
                                                  aspectRatio: 16 / 8,
                                                ),
                                              ),
                                            ),
                                          ]),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : Container(),
                          C.casts.isNotEmpty
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0, vertical: 15),
                                      child: Text(
                                        "Shows Cast :",
                                        style: TextStyle(
                                            fontSize: 5.w > 24 ? 24 : 5.w,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: SizedBox(
                                        height: 30.w > 185 ? 185 : 30.w,
                                        child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: C.casts.length,
                                            itemBuilder: (BuildContext context, int index) =>
                                                actorWidget(index: index, B: C)),
                                      ),
                                    ),
                                  ],
                                )
                              : Container(),
                          C.suggestions.isNotEmpty
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text(
                                        "Recommendations :",
                                        style: TextStyle(
                                            fontSize: 5.w > 24 ? 24 : 5.w,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10.0, horizontal: 20),
                                        child: SizedBox(
                                          height: 70.w > 400 ? 400 : 70.w,
                                          child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemCount: C.suggestions.length,
                                              itemBuilder: (BuildContext context, int index) =>
                                                  GestureDetector(
                                                    onTap: () => context
                                                        .go('/tv/${C.suggestions[index].id}'),
                                                    child: FittedBox(
                                                      child: suggestionWidget(
                                                          index: index, suggestions: C.suggestions),
                                                    ),
                                                  )),
                                        )),
                                  ],
                                )
                              : Container(),
                          C.similar.isNotEmpty
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text(
                                        "Might Also Interest You :",
                                        style: TextStyle(
                                            fontSize: 5.w > 24 ? 24 : 5.w,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10.0, horizontal: 20),
                                        child: SizedBox(
                                          height: 70.w > 400 ? 400 : 70.w,
                                          child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemCount: C.similar.length,
                                              itemBuilder: (BuildContext context, int index) =>
                                                  GestureDetector(
                                                    onTap: () =>
                                                        context.go('/tv/${C.similar[index].id}'),
                                                    child: FittedBox(
                                                      child: suggestionWidget(
                                                          index: index, suggestions: C.similar),
                                                    ),
                                                  )),
                                        )),
                                  ],
                                )
                              : Container(),
                          C.reviews.isNotEmpty
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text(
                                        "Reviews :",
                                        style: TextStyle(
                                            fontSize: 5.w > 24 ? 24 : 5.w,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    LiveList.options(
                                      options: const LiveOptions(
                                          showItemInterval: Duration(milliseconds: 50),
                                          showItemDuration: Duration(milliseconds: 200),
                                          reAnimateOnVisibility: false),
                                      physics: const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemBuilder: (
                                        BuildContext context,
                                        int index,
                                        Animation<double> animation,
                                      ) =>
                                          FadeTransition(
                                        opacity: Tween<double>(
                                          begin: 0,
                                          end: 1,
                                        ).animate(animation),
                                        // And slide transition
                                        child: SlideTransition(
                                          position: Tween<Offset>(
                                            begin: const Offset(0, -0.1),
                                            end: Offset.zero,
                                          ).animate(animation),
                                          // Paste you Widget
                                          child: GestureDetector(
                                            onTap: () {},
                                            child: reviewWidget(B: C, index: index),
                                          ),
                                        ),
                                      ),
                                      itemCount: seeMore
                                          ? C.reviews.length
                                          : C.reviews.length > 1
                                              ? 2
                                              : 1,
                                    ),
                                    C.reviews.length > 2
                                        ? Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              InkWell(
                                                borderRadius: BorderRadius.circular(20),
                                                onTap: () {
                                                  seeMore = !seeMore;
                                                  C.onChanges();
                                                },
                                                child: SizedBox(
                                                  height: 50,
                                                  width: 200,
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Text(seeMore ? "Show Less " : " See More "),
                                                      Icon(
                                                        seeMore
                                                            ? Icons.arrow_upward
                                                            : Icons.arrow_downward,
                                                        size: 14,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          )
                                        : Container()
                                  ],
                                )
                              : Container()
                        ],
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }
}

String runtimeToHours(int minutes) {
  var d = Duration(minutes: minutes);
  List<String> parts = d.toString().split(':');
  var firstPart = parts[0] != "0" ? "${parts[0]}h " : "";
  return '$firstPart${parts[1].padLeft(2, '0')}m' == "00m"
      ? "Unknown"
      : '$firstPart${parts[1].padLeft(2, '0')}m';
}
