import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:netflix_web/bloc/nex_bloc.dart';
import 'package:netflix_web/models/movies.dart';
import 'package:netflix_web/widgets/suggestion_widget.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import '../../widgets/actor_widget.dart';
import '../../widgets/categoryWidget.dart';
import '../../widgets/review_widget.dart';

late ThemeData theme;
late NexBloc B;

// This page is opened when you press on a movie
class MovieInfo extends StatefulWidget {
  final String id;

  const MovieInfo({Key? key, required this.id}) : super(key: key);

  @override
  State<MovieInfo> createState() => _MovieInfoState();
}

class _MovieInfoState extends State<MovieInfo> {
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
    B.movie = emptyMovie;
  }

  changeMovie() {
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
            B.movie = emptyMovie,
            B.getMovie(id: parsedId),
          }
        : null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NexBloc, NexState>(
      listener: (context, state) {},
      builder: (context, state) {
        theme = Theme.of(context);
        changeMovie();
        return Scaffold(
          backgroundColor: theme.canvasColor,
          body: B.movie == emptyMovie
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 500,
                      child: B.movie.posterPath != ""
                          ? Image.network(
                              fit: BoxFit.cover,
                              "https://image.tmdb.org/t/p/original${B.movie.backdropPath ?? B.movie.posterPath}",
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
                              B.movie.title,
                              style: const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Row(
                              children: [
                                Text(B.movie.status!,
                                    style: TextStyle(
                                        color: B.movie.status == "Released"
                                            ? theme.primaryColor
                                            : Colors.red,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18)),
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                                  child: Text("-"),
                                ),
                                Text(runtimeToHours(B.movie.runtime!),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w100, fontSize: 18, color: grey)),
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                                  child: Text("-"),
                                ),
                                Text(B.movie.releaseDate.split('-')[0],
                                    style: TextStyle(
                                        fontWeight: FontWeight.w100, fontSize: 18, color: grey)),
                              ],
                            ),
                          ),
                          B.movie.genres!.isNotEmpty
                              ? Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 5),
                                  child: SizedBox(
                                      height: 44,
                                      child: ListView.builder(
                                          itemCount: B.movie.genres!.length,
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (
                                            BuildContext context,
                                            int index,
                                          ) =>
                                              categoryWidget(index: index, movie: B.movie))),
                                )
                              : Container(),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              B.movie.overview,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w400, color: Colors.white),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
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
                                      B.movie.voteAverage
                                          .toStringAsFixed(1)
                                          .replaceFirst(RegExp(r'\.?'), ''),
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold)),
                                  Text(
                                      B.movie.voteCount > 1000
                                          ? "/10 (${(B.movie.voteCount / 1000).toStringAsFixed(2)}K)"
                                          : "/10 (${B.movie.voteCount})",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w100, fontSize: 18, color: grey)),
                                ],
                              )),
                          const SizedBox(height: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15),
                                child: Text(
                                  "Trailer:",
                                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: YoutubePlayer(
                                  controller: B.videoController,
                                  aspectRatio: 16 / 9,
                                ),
                              ),
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15),
                            child: Text(
                              "Movie Cast:",
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
                                        "Recommendations:",
                                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
                                                        .go('/movies/${B.suggestions[index].id}'),
                                                    child: suggestionWidget(
                                                        index: index, suggestions: B.suggestions),
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
                                        "Similar Movies:",
                                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
                                                        .go('/movies/${B.similar[index].id}'),
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
                                        "Reviews:",
                                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
                                    Row(
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
  return '${parts[0]}h ${parts[1].padLeft(2, '0')}m';
}
