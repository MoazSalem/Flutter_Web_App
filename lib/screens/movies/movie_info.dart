import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_web/bloc/nex_bloc.dart';
import 'package:netflix_web/models/movies.dart';

late ThemeData theme;
late int parsedId;
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

  @override
  void initState() {
    super.initState();
    B = NexBloc.get(context);
    B.casts = [];
    B.movie = emptyMovie;
    parsedId = int.parse(widget.id);
    B.getMovie(id: parsedId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NexBloc, NexState>(
      listener: (context, state) {},
      builder: (context, state) {
        theme = Theme.of(context);
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
                      height: 400,
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
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15),
                      child: Text(
                        "Movie Cast:",
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ),
                    B.casts.isNotEmpty
                        ? SizedBox(
                            height: 180,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: B.casts.length,
                                itemBuilder: (BuildContext context, int index) => Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          CircleAvatar(
                                              radius: 48,
                                              child: ClipOval(
                                                child: Image.network(
                                                  height: 100,
                                                  width: 100,
                                                  fit: BoxFit.cover,
                                                  "https://image.tmdb.org/t/p/w500${B.casts[index].profilePath}",
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
                                          Text(
                                            "${B.casts[index].name}",
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w500, fontSize: 14),
                                          ),
                                          Text(
                                            "${B.casts[index].character?.split("/")[0]}",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w100,
                                                fontSize: 10,
                                                color: grey),
                                          ),
                                          B.casts[index].character!.split("/").length > 1
                                              ? Column(
                                                  children: [
                                                    Text(
                                                      "${B.casts[index].character?.split("/")[1]}",
                                                      style: TextStyle(
                                                          fontWeight: FontWeight.w100,
                                                          fontSize: 10,
                                                          color: grey),
                                                    ),
                                                    B.casts[index].character!.split("/").length > 2
                                                        ? Text(
                                                            "${B.casts[index].character?.split("/")[2]}",
                                                            style: TextStyle(
                                                                fontWeight: FontWeight.w100,
                                                                fontSize: 10,
                                                                color: grey),
                                                          )
                                                        : Container(),
                                                  ],
                                                )
                                              : Container(),
                                        ],
                                      ),
                                    )),
                          )
                        : const Center(
                            child: CircularProgressIndicator(),
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
