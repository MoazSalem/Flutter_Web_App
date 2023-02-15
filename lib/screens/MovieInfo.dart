import 'package:flutter/material.dart';

class MovieInfo extends StatefulWidget {
  String title;
  double averageVote;
  String overview;
  String poster;

  MovieInfo(
      {Key? key,
      required this.title,
      required this.averageVote,
      required this.overview,
      required this.poster})
      : super(key: key);

  @override
  State<MovieInfo> createState() => _MovieInfoState();
}

class _MovieInfoState extends State<MovieInfo> {
  @override
  Widget build(BuildContext context) {
    Color primary = Colors.deepPurpleAccent.shade100;
    return Scaffold(
      backgroundColor: Colors.black,
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          mini: true,
          child: const Icon(Icons.arrow_back),
        ),
      ),
      body: ListView(
        children: [
          SizedBox(
            width: double.infinity,
            height: 600,
            child: Image.network(fit: BoxFit.fitWidth, widget.poster),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
            child: Text(
              widget.title,
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: primary),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: RichText(
              text: TextSpan(
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white),
                children: <TextSpan>[
                  const TextSpan(text: "Rating: "),
                  TextSpan(text: widget.averageVote.toString(), style: TextStyle(color: primary)),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 60,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              "Overview:",
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: primary),
            ),
          ),
          Card(
            color: Colors.deepPurpleAccent.shade100,
            margin: const EdgeInsets.all(10),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                widget.overview,
                style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w300),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
