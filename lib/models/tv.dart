class TvShows {
  TvShows({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  late final int page;
  late final List<TvShow> results;
  late final int totalPages;
  late final int totalResults;

  TvShows.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    results = List.from(json['results']).map((e) => TvShow.fromJson(e)).toList();
    totalPages = json['total_pages'];
    totalResults = json['total_results'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['page'] = page;
    data['results'] = results.map((e) => e.toJson()).toList();
    data['total_pages'] = totalPages;
    data['total_results'] = totalResults;
    return data;
  }
}

class TvShow {
  TvShow({
    required this.backdropPath,
    required this.firstAirDate,
    required this.genreIds,
    required this.id,
    required this.name,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.voteAverage,
    required this.voteCount,
  });

  late final String? backdropPath;
  late final String firstAirDate;
  late final List<dynamic>? genreIds;
  late final int id;
  late final String name;
  late final List<String> originCountry;
  late final String originalLanguage;
  late final String originalName;
  late final String overview;
  late final double popularity;
  late final String posterPath;
  late final double voteAverage;
  late final int voteCount;

  TvShow.fromJson(Map<String, dynamic> json) {
    backdropPath = json['backdrop_path'];
    firstAirDate = json['first_air_date'];
    genreIds = json['genre_ids'];
    id = json['id'];
    name = json['name'];
    originCountry = List.castFrom<dynamic, String>(json['origin_country']);
    originalLanguage = json['original_language'];
    originalName = json['original_name'];
    overview = json['overview'];
    popularity = json['popularity'];
    posterPath = json['poster_path'];
    voteAverage = json['vote_average'];
    voteCount = json['vote_count'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['backdrop_path'] = backdropPath;
    data['first_air_date'] = firstAirDate;
    data['genre_ids'] = genreIds;
    data['id'] = id;
    data['name'] = name;
    data['origin_country'] = originCountry;
    data['original_language'] = originalLanguage;
    data['original_name'] = originalName;
    data['overview'] = overview;
    data['popularity'] = popularity;
    data['poster_path'] = posterPath;
    data['vote_average'] = voteAverage;
    data['vote_count'] = voteCount;
    return data;
  }
}

TvShow emptyShow = TvShow(
    backdropPath: "",
    firstAirDate: "",
    genreIds: [],
    id: 0,
    name: "",
    originCountry: [],
    originalLanguage: "",
    originalName: "",
    overview: "",
    popularity: 0,
    posterPath: "",
    voteAverage: 0,
    voteCount: 0);
