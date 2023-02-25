import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:netflix_web/bloc/nex_bloc.dart';

late ThemeData theme;
late int parsedId;
late ScrollController scrollController;
late NexBloc B;
late double currentWidth;
bool loading = true;

// This page is opened when you press on a movie
class TvInfo extends StatefulWidget {
  final String id;

  const TvInfo({Key? key, required this.id}) : super(key: key);

  @override
  State<TvInfo> createState() => _TvInfoState();
}

class _TvInfoState extends State<TvInfo> {
  @override
  void initState() {
    super.initState();
    B = NexBloc.get(context);
    scrollController = ScrollController();
    parsedId = int.parse(widget.id);
    B.getShow(id: parsedId);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    currentWidth = MediaQuery.of(context).size.width;
    currentWidth > 800 ? currentWidth /= 2 : currentWidth *= 1.2;
    theme = Theme.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NexBloc, NexState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: theme.canvasColor,
          floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
          floatingActionButton: B.tvShowsList.isNotEmpty
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
                child: Image.network(
                    fit: BoxFit.cover,
                    "https://image.tmdb.org/t/p/original/${B.show.backdropPath ?? B.show.posterPath}"),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
                child: Text(
                  B.show.name,
                  style: TextStyle(
                    fontSize: currentWidth * 0.05,
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
                        fontSize: currentWidth * 0.035,
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
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "Overview:",
                  style: TextStyle(fontSize: currentWidth * 0.035, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  B.show.overview,
                  style: TextStyle(fontSize: currentWidth * 0.03, fontWeight: FontWeight.w300),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
