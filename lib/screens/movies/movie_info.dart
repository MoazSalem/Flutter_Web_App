import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:netflix_web/bloc/nex_bloc.dart';
import 'package:netflix_web/models/movies.dart';

late ThemeData theme;
late int parsedId;
late ScrollController scrollController;
late NexBloc B;
bool loading = true;

// This page is opened when you press on a movie
class MovieInfo extends StatefulWidget {
  final String id;
  final int page;

  const MovieInfo({Key? key, required this.id, required this.page}) : super(key: key);

  @override
  State<MovieInfo> createState() => _MovieInfoState();
}

class _MovieInfoState extends State<MovieInfo> {
  @override
  void initState() {
    super.initState();
    B = NexBloc.get(context);
    B.movie = emptyMovie;
    scrollController = ScrollController();
    parsedId = int.parse(widget.id);
    B.getMovie(id: parsedId, page: widget.page);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NexBloc, NexState>(
      listener: (context, state) {},
      builder: (context, state) {
        theme = Theme.of(context);
        return Scaffold(
          backgroundColor: theme.canvasColor,
          floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
          floatingActionButton: B.allMoviesList.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: FloatingActionButton(
                    backgroundColor: theme.primaryColor,
                    onPressed: () {
                      context.pop();
                    },
                    mini: true,
                    child: const Icon(
                      Icons.arrow_back,
                    ),
                  ),
                )
              : Container(),
          body: ListView(
            children: [
              SizedBox(
                width: double.infinity,
                height: 400,
                child: B.movie.posterPath != ""
                    ? Image.network(
                        fit: BoxFit.cover,
                        "https://image.tmdb.org/t/p/original/${B.movie.backdropPath ?? B.movie.posterPath}")
                    : Container(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
                child: Text(
                  B.movie.title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: theme.textTheme.bodySmall!.color),
                    children: <TextSpan>[
                      const TextSpan(text: "Rating: "),
                      TextSpan(
                          text: B.movie.voteAverage
                              .toStringAsFixed(1)
                              .replaceFirst(RegExp(r'\.?'), ''),
                          style: TextStyle(color: theme.primaryColor)),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  "Overview:",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  B.movie.overview,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
