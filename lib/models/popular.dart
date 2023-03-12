class Popular {
  Popular({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  late final int page;
  late final List<Results> results;
  late final int totalPages;
  late final int totalResults;

  Popular.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    results = List.from(json['results']).map((e) => Results.fromJson(e)).toList();
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

class Results {
  Results({
    required this.adult,
    required this.backdropPath,
    required this.firstAirDate,
    required this.genreIds,
    required this.id,
    required this.name,
    required this.title,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalName,
    required this.originalTitle,
    required this.overview,
    required this.posterPath,
    required this.releaseDate,
    required this.popularity,
    required this.mediaType,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  late final bool? adult;
  late final String? backdropPath;
  late final String? firstAirDate;
  late final List<dynamic>? genreIds;
  late final int? id;
  late final String? name;
  late final String? title;
  late final List<dynamic>? originCountry;
  late final String? originalLanguage;
  late final String? originalName;
  late final String? originalTitle;
  late final String? overview;
  late final double? popularity;
  late final String? posterPath;
  late final String? releaseDate;
  late final String? mediaType;
  late final bool? video;
  late final double? voteAverage;
  late final int? voteCount;

  Results.fromJson(Map<String, dynamic> json) {
    adult = json['adult'];
    backdropPath = json['backdrop_path'];
    id = json['id'];
    name = json['name'];
    title = json['title'];
    originalTitle = json['originalTitle'];
    originalLanguage = json['original_language'];
    originalName = json['original_name'];
    overview = json['overview'];
    posterPath = json['poster_path'];
    releaseDate = json['release_date'];
    mediaType = json['media_type'];
    genreIds = List.castFrom<dynamic, int>(json['genre_ids']);
    popularity = json['popularity'];
    firstAirDate = json['first_air_date'];
    video = json['video'];
    voteAverage = json['vote_average'];
    voteCount = json['vote_count'];
    originCountry = json['origin_country'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['adult'] = adult;
    data['backdrop_path'] = backdropPath;
    data['id'] = id;
    data['name'] = name;
    data['title'] = title;
    data['originalTitle'] = originalTitle;
    data['original_language'] = originalLanguage;
    data['original_name'] = originalName;
    data['overview'] = overview;
    data['poster_path'] = posterPath;
    data['release_date'] = releaseDate;
    data['media_type'] = mediaType;
    data['genre_ids'] = genreIds;
    data['popularity'] = popularity;
    data['first_air_date'] = firstAirDate;
    data['video'] = video;
    data['vote_average'] = voteAverage;
    data['vote_count'] = voteCount;
    data['origin_country'] = originCountry;
    return data;
  }
}
