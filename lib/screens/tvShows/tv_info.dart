import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:auto_animated/auto_animated.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:tmdb_web/bloc/nex_bloc.dart';
import 'package:tmdb_web/models/tv.dart';
import 'package:tmdb_web/widgets/suggestion_widget.dart';
import 'package:tmdb_web/widgets/actor_widget.dart';
import 'package:tmdb_web/widgets/categories_widget.dart';
import 'package:tmdb_web/widgets/review_widget.dart';

// This page is opened when you press on a tv show
class TvInfo extends StatefulWidget {
  final String id;

  const TvInfo({Key? key, required this.id}) : super(key: key);

  @override
  State<TvInfo> createState() => _TvInfoState();
}

class _TvInfoState extends State<TvInfo> {
  late ThemeData theme;
  late NexBloc B;
  final ScrollController scrollController = ScrollController();
  final Color grey = Colors.grey.shade400;
  bool loading = true;
  bool seeMore = false;
  int parsedId = 0;

  @override
  void initState() {
    super.initState();
    B = NexBloc.get(context);
    B.casts = [];
    B.show = TvShows();
  }

  changeShow() {
    parsedId != int.parse(widget.id)
        ? {
            B.videoController = YoutubePlayerController(
              params: const YoutubePlayerParams(
                mute: false,
                showControls: true,
                showFullscreenButton: true,
              ),
            ),
            parsedId = int.parse(widget.id),
            B.show = TvShows(),
            B.getShow(id: parsedId),
          }
        : null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NexBloc, NexState>(
      listener: (context, state) {},
      builder: (context, state) {
        theme = Theme.of(context);
        changeShow();
        return Scaffold(
          backgroundColor: theme.canvasColor,
          body: B.show.name == null
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 500,
                      child: B.show.posterPath != ""
                          ? Image.network(
                              fit: BoxFit.cover,
                              "https://image.tmdb.org/t/p/original/${B.show.backdropPath ?? B.show.posterPath}",
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
                              B.show.name!,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Row(
                              children: [
                                Text("${B.show.status}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: theme.primaryColor)),
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                                  child: Text("-"),
                                ),
                                Text(
                                    "${B.show.numberOfSeasons} Season${B.show.numberOfSeasons! > 1 ? "s" : ""}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: theme.primaryColor)),
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                                  child: Text("-"),
                                ),
                                Text("${B.show.numberOfEpisodes} Episodes",
                                    style: TextStyle(fontSize: 18, color: grey)),
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                                  child: Text("-"),
                                ),
                                Text(runtimeToHours(B.show.episodeRunTime!),
                                    style: TextStyle(fontSize: 18, color: grey)),
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                                  child: Text("-"),
                                ),
                                Text(B.show.firstAirDate!.split('-')[0],
                                    style: TextStyle(fontSize: 18, color: grey)),
                              ],
                            ),
                          ),
                          B.show.genres!.isNotEmpty
                              ? Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 5),
                                  child: SizedBox(
                                      height: 44,
                                      child: ListView.builder(
                                          itemCount: B.show.genres!.length,
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (
                                            BuildContext context,
                                            int index,
                                          ) =>
                                              categoriesWidget(
                                                  index: index, movie: B.show, context: context))),
                                )
                              : Container(),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              B.show.overview!,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w400, color: Colors.white),
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: theme.primaryColor,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                      B.show.voteAverage!
                                          .toStringAsFixed(1)
                                          .replaceFirst(RegExp(r'\.?'), ''),
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold)),
                                  Text(
                                      B.show.voteCount! > 1000
                                          ? "/10 (${(B.show.voteCount! / 1000).toStringAsFixed(2)}K)"
                                          : "/10 (${B.show.voteCount})",
                                      style: TextStyle(fontSize: 18, color: grey)),
                                ],
                              )),
                          const SizedBox(height: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15),
                                child: Text(
                                  "Trailer :",
                                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
                                    child: YoutubePlayer(
                                      controller: B.videoController,
                                      aspectRatio: 16 / 9,
                                    ),
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15),
                                child: Text(
                                  "Shows Cast :",
                                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              B.casts.isNotEmpty
                                  ? Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: SizedBox(
                                        height: 185,
                                        child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: B.casts.length,
                                            itemBuilder: (BuildContext context, int index) =>
                                                actorWidget(index: index, B: B)),
                                      ),
                                    )
                                  : const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                              B.suggestions.isNotEmpty
                                  ? Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.all(10.0),
                                          child: Text(
                                            "Recommendations :",
                                            style: TextStyle(
                                                fontSize: 24, fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10.0, horizontal: 20),
                                            child: SizedBox(
                                              height: 400,
                                              child: ListView.builder(
                                                  scrollDirection: Axis.horizontal,
                                                  itemCount: B.suggestions.length,
                                                  itemBuilder: (BuildContext context, int index) =>
                                                      GestureDetector(
                                                        onTap: () => context
                                                            .go('/tv/${B.suggestions[index].id}'),
                                                        child: suggestionWidget(
                                                            index: index,
                                                            suggestions: B.suggestions),
                                                      )),
                                            )),
                                      ],
                                    )
                                  : Container(),
                              B.similar.isNotEmpty
                                  ? Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.all(10.0),
                                          child: Text(
                                            "Might Also Interest You :",
                                            style: TextStyle(
                                                fontSize: 24, fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10.0, horizontal: 20),
                                            child: SizedBox(
                                              height: 400,
                                              child: ListView.builder(
                                                  scrollDirection: Axis.horizontal,
                                                  itemCount: B.similar.length,
                                                  itemBuilder: (BuildContext context, int index) =>
                                                      GestureDetector(
                                                        onTap: () => context
                                                            .go('/tv/${B.similar[index].id}'),
                                                        child: suggestionWidget(
                                                            index: index, suggestions: B.similar),
                                                      )),
                                            )),
                                      ],
                                    )
                                  : Container(),
                              B.reviews.isNotEmpty
                                  ? Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.all(10.0),
                                          child: Text(
                                            "Reviews :",
                                            style: TextStyle(
                                                fontSize: 24, fontWeight: FontWeight.bold),
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
                                                child: reviewWidget(B: B, index: index),
                                              ),
                                            ),
                                          ),
                                          itemCount: seeMore
                                              ? B.reviews.length
                                              : B.reviews.length > 1
                                                  ? 2
                                                  : 1,
                                        ),
                                        B.reviews.length > 1
                                            ? Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  InkWell(
                                                    borderRadius: BorderRadius.circular(20),
                                                    onTap: () {
                                                      seeMore = !seeMore;
                                                      B.onChanges();
                                                    },
                                                    child: SizedBox(
                                                      height: 50,
                                                      width: 200,
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          Text(seeMore
                                                              ? "Show Less "
                                                              : " See More "),
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
