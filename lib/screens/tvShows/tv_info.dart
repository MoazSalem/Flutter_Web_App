import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:netflix_web/bloc/nex_bloc.dart';
import 'package:netflix_web/models/tv.dart';

late ThemeData theme;
late int parsedId;
late NexBloc B;

// This page is opened when you press on a movie
class TvInfo extends StatefulWidget {
  final String id;

  const TvInfo({Key? key, required this.id}) : super(key: key);

  @override
  State<TvInfo> createState() => _TvInfoState();
}

class _TvInfoState extends State<TvInfo> {
  final ScrollController scrollController = ScrollController();
  bool loading = true;

  @override
  void initState() {
    super.initState();
    B = NexBloc.get(context);
    B.show = emptyShow;
    parsedId = int.parse(widget.id);
    B.getShow(id: parsedId);
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
          floatingActionButton: B.allTvShowsList.isNotEmpty
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
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
                child: Text(
                  B.show.name,
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
                          text: B.show.voteAverage
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
                  B.show.overview,
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
