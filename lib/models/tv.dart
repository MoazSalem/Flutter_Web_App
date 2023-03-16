class TvShowsSpokenLanguages {
  String? englishName;
  String? iso_639_1;
  String? name;

  TvShowsSpokenLanguages({
    this.englishName,
    this.iso_639_1,
    this.name,
  });

  TvShowsSpokenLanguages.fromJson(Map<String, dynamic> json) {
    englishName = json['english_name']?.toString();
    iso_639_1 = json['iso_639_1']?.toString();
    name = json['name']?.toString();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['english_name'] = englishName;
    data['iso_639_1'] = iso_639_1;
    data['name'] = name;
    return data;
  }
}

class TvShowsSeasons {
  String? airDate;
  int? episodeCount;
  int? id;
  String? name;
  String? overview;
  String? posterPath;
  int? seasonNumber;

  TvShowsSeasons({
    this.airDate,
    this.episodeCount,
    this.id,
    this.name,
    this.overview,
    this.posterPath,
    this.seasonNumber,
  });

  TvShowsSeasons.fromJson(Map<String, dynamic> json) {
    airDate = json['air_date']?.toString();
    episodeCount = json['episode_count']?.toInt();
    id = json['id']?.toInt();
    name = json['name']?.toString();
    overview = json['overview']?.toString();
    posterPath = json['poster_path']?.toString();
    seasonNumber = json['season_number']?.toInt();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['air_date'] = airDate;
    data['episode_count'] = episodeCount;
    data['id'] = id;
    data['name'] = name;
    data['overview'] = overview;
    data['poster_path'] = posterPath;
    data['season_number'] = seasonNumber;
    return data;
  }
}

class TvShowsProductionCountries {
  String? iso_3166_1;
  String? name;

  TvShowsProductionCountries({
    this.iso_3166_1,
    this.name,
  });

  TvShowsProductionCountries.fromJson(Map<String, dynamic> json) {
    iso_3166_1 = json['iso_3166_1']?.toString();
    name = json['name']?.toString();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['iso_3166_1'] = iso_3166_1;
    data['name'] = name;
    return data;
  }
}

class TvShowsProductionCompanies {
  int? id;
  String? logoPath;
  String? name;
  String? originCountry;

  TvShowsProductionCompanies({
    this.id,
    this.logoPath,
    this.name,
    this.originCountry,
  });

  TvShowsProductionCompanies.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    logoPath = json['logo_path']?.toString();
    name = json['name']?.toString();
    originCountry = json['origin_country']?.toString();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['logo_path'] = logoPath;
    data['name'] = name;
    data['origin_country'] = originCountry;
    return data;
  }
}

class TvShowsNetworks {
  int? id;
  String? logoPath;
  String? name;
  String? originCountry;

  TvShowsNetworks({
    this.id,
    this.logoPath,
    this.name,
    this.originCountry,
  });

  TvShowsNetworks.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    logoPath = json['logo_path']?.toString();
    name = json['name']?.toString();
    originCountry = json['origin_country']?.toString();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['logo_path'] = logoPath;
    data['name'] = name;
    data['origin_country'] = originCountry;
    return data;
  }
}

class TvShowsLastEpisodeToAir {
  int? id;
  String? name;
  String? overview;
  double? voteAverage;
  int? voteCount;
  String? airDate;
  int? episodeNumber;
  String? productionCode;
  int? runtime;
  int? seasonNumber;
  int? showId;
  String? stillPath;

  TvShowsLastEpisodeToAir({
    this.id,
    this.name,
    this.overview,
    this.voteAverage,
    this.voteCount,
    this.airDate,
    this.episodeNumber,
    this.productionCode,
    this.runtime,
    this.seasonNumber,
    this.showId,
    this.stillPath,
  });

  TvShowsLastEpisodeToAir.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    name = json['name']?.toString();
    overview = json['overview']?.toString();
    voteAverage = json['vote_average']?.toDouble();
    voteCount = json['vote_count']?.toInt();
    airDate = json['air_date']?.toString();
    episodeNumber = json['episode_number']?.toInt();
    productionCode = json['production_code']?.toString();
    runtime = json['runtime']?.toInt();
    seasonNumber = json['season_number']?.toInt();
    showId = json['show_id']?.toInt();
    stillPath = json['still_path']?.toString();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['overview'] = overview;
    data['vote_average'] = voteAverage;
    data['vote_count'] = voteCount;
    data['air_date'] = airDate;
    data['episode_number'] = episodeNumber;
    data['production_code'] = productionCode;
    data['runtime'] = runtime;
    data['season_number'] = seasonNumber;
    data['show_id'] = showId;
    data['still_path'] = stillPath;
    return data;
  }
}

class TvShowsGenres {
  int? id;
  String? name;

  TvShowsGenres({
    this.id,
    this.name,
  });

  TvShowsGenres.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    name = json['name']?.toString();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

class TvShowsCreatedBy {
  int? id;
  String? creditId;
  String? name;
  int? gender;
  String? profilePath;

  TvShowsCreatedBy({
    this.id,
    this.creditId,
    this.name,
    this.gender,
    this.profilePath,
  });

  TvShowsCreatedBy.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    creditId = json['credit_id']?.toString();
    name = json['name']?.toString();
    gender = json['gender']?.toInt();
    profilePath = json['profile_path']?.toString();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['credit_id'] = creditId;
    data['name'] = name;
    data['gender'] = gender;
    data['profile_path'] = profilePath;
    return data;
  }
}

class TvShows {
  bool? adult;
  String? backdropPath;
  List<TvShowsCreatedBy?>? createdBy;
  int? episodeRunTime;
  String? firstAirDate;
  List<TvShowsGenres?>? genres;
  String? homepage;
  int? id;
  bool? inProduction;
  List<String?>? languages;
  String? lastAirDate;
  TvShowsLastEpisodeToAir? lastEpisodeToAir;
  String? name;
  String? nextEpisodeToAir;
  List<TvShowsNetworks?>? networks;
  int? numberOfEpisodes;
  int? numberOfSeasons;
  List<String?>? originCountry;
  String? originalLanguage;
  String? originalName;
  String? overview;
  double? popularity;
  String? posterPath;
  List<TvShowsProductionCompanies?>? productionCompanies;
  List<TvShowsProductionCountries?>? productionCountries;
  List<TvShowsSeasons?>? seasons;
  List<TvShowsSpokenLanguages?>? spokenLanguages;
  String? status;
  String? tagline;
  String? type;
  double? voteAverage;
  int? voteCount;

  TvShows({
    this.adult,
    this.backdropPath,
    this.createdBy,
    this.episodeRunTime,
    this.firstAirDate,
    this.genres,
    this.homepage,
    this.id,
    this.inProduction,
    this.languages,
    this.lastAirDate,
    this.lastEpisodeToAir,
    this.name,
    this.nextEpisodeToAir,
    this.networks,
    this.numberOfEpisodes,
    this.numberOfSeasons,
    this.originCountry,
    this.originalLanguage,
    this.originalName,
    this.overview,
    this.popularity,
    this.posterPath,
    this.productionCompanies,
    this.productionCountries,
    this.seasons,
    this.spokenLanguages,
    this.status,
    this.tagline,
    this.type,
    this.voteAverage,
    this.voteCount,
  });

  TvShows.fromJson(Map<String, dynamic> json) {
    adult = json['adult'];
    backdropPath = json['backdrop_path']?.toString();
    if (json['created_by'] != null) {
      final v = json['created_by'];
      final arr0 = <TvShowsCreatedBy>[];
      v.forEach((v) {
        arr0.add(TvShowsCreatedBy.fromJson(v));
      });
      createdBy = arr0;
    }
    if (json['episode_run_time'] != null) {
      final v = json['episode_run_time'];
      final arr0 = <int>[];
      v.forEach((v) {
        arr0.add(v.toInt());
      });
      episodeRunTime = arr0.isNotEmpty ? arr0[0] : 0;
    }
    firstAirDate = json['first_air_date']?.toString();
    if (json['genres'] != null) {
      final v = json['genres'];
      final arr0 = <TvShowsGenres>[];
      v.forEach((v) {
        arr0.add(TvShowsGenres.fromJson(v));
      });
      genres = arr0;
    }
    homepage = json['homepage']?.toString();
    id = json['id']?.toInt();
    inProduction = json['in_production'];
    if (json['languages'] != null) {
      final v = json['languages'];
      final arr0 = <String>[];
      v.forEach((v) {
        arr0.add(v.toString());
      });
      languages = arr0;
    }
    lastAirDate = json['last_air_date']?.toString();
    lastEpisodeToAir = (json['last_episode_to_air'] != null)
        ? TvShowsLastEpisodeToAir.fromJson(json['last_episode_to_air'])
        : null;
    name = json['name']?.toString();
    nextEpisodeToAir = json['next_episode_to_air']?.toString();
    if (json['networks'] != null) {
      final v = json['networks'];
      final arr0 = <TvShowsNetworks>[];
      v.forEach((v) {
        arr0.add(TvShowsNetworks.fromJson(v));
      });
      networks = arr0;
    }
    numberOfEpisodes = json['number_of_episodes']?.toInt();
    numberOfSeasons = json['number_of_seasons']?.toInt();
    if (json['origin_country'] != null) {
      final v = json['origin_country'];
      final arr0 = <String>[];
      v.forEach((v) {
        arr0.add(v.toString());
      });
      originCountry = arr0;
    }
    originalLanguage = json['original_language']?.toString();
    originalName = json['original_name']?.toString();
    overview = json['overview']?.toString();
    popularity = json['popularity']?.toDouble();
    posterPath = json['poster_path']?.toString();
    if (json['production_companies'] != null) {
      final v = json['production_companies'];
      final arr0 = <TvShowsProductionCompanies>[];
      v.forEach((v) {
        arr0.add(TvShowsProductionCompanies.fromJson(v));
      });
      productionCompanies = arr0;
    }
    if (json['production_countries'] != null) {
      final v = json['production_countries'];
      final arr0 = <TvShowsProductionCountries>[];
      v.forEach((v) {
        arr0.add(TvShowsProductionCountries.fromJson(v));
      });
      productionCountries = arr0;
    }
    if (json['seasons'] != null) {
      final v = json['seasons'];
      final arr0 = <TvShowsSeasons>[];
      v.forEach((v) {
        arr0.add(TvShowsSeasons.fromJson(v));
      });
      seasons = arr0;
    }
    if (json['spoken_languages'] != null) {
      final v = json['spoken_languages'];
      final arr0 = <TvShowsSpokenLanguages>[];
      v.forEach((v) {
        arr0.add(TvShowsSpokenLanguages.fromJson(v));
      });
      spokenLanguages = arr0;
    }
    status = json['status']?.toString();
    tagline = json['tagline']?.toString();
    type = json['type']?.toString();
    voteAverage = json['vote_average']?.toDouble();
    voteCount = json['vote_count']?.toInt();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['adult'] = adult;
    data['backdrop_path'] = backdropPath;
    if (createdBy != null) {
      final v = createdBy;
      final arr0 = [];
      for (var v in v!) {
        arr0.add(v!.toJson());
      }
      data['created_by'] = arr0;
    }
    if (episodeRunTime != null) {
      final v = episodeRunTime;
      final arr0 = [];
      arr0.add(v!);
      data['episode_run_time'] = arr0;
    }
    data['first_air_date'] = firstAirDate;
    if (genres != null) {
      final v = genres;
      final arr0 = [];
      for (var v in v!) {
        arr0.add(v!.toJson());
      }
      data['genres'] = arr0;
    }
    data['homepage'] = homepage;
    data['id'] = id;
    data['in_production'] = inProduction;
    if (languages != null) {
      final v = languages;
      final arr0 = [];
      for (var v in v!) {
        arr0.add(v);
      }
      data['languages'] = arr0;
    }
    data['last_air_date'] = lastAirDate;
    if (lastEpisodeToAir != null) {
      data['last_episode_to_air'] = lastEpisodeToAir!.toJson();
    }
    data['name'] = name;
    data['next_episode_to_air'] = nextEpisodeToAir;
    if (networks != null) {
      final v = networks;
      final arr0 = [];
      for (var v in v!) {
        arr0.add(v!.toJson());
      }
      data['networks'] = arr0;
    }
    data['number_of_episodes'] = numberOfEpisodes;
    data['number_of_seasons'] = numberOfSeasons;
    if (originCountry != null) {
      final v = originCountry;
      final arr0 = [];
      for (var v in v!) {
        arr0.add(v);
      }
      data['origin_country'] = arr0;
    }
    data['original_language'] = originalLanguage;
    data['original_name'] = originalName;
    data['overview'] = overview;
    data['popularity'] = popularity;
    data['poster_path'] = posterPath;
    if (productionCompanies != null) {
      final v = productionCompanies;
      final arr0 = [];
      for (var v in v!) {
        arr0.add(v!.toJson());
      }
      data['production_companies'] = arr0;
    }
    if (productionCountries != null) {
      final v = productionCountries;
      final arr0 = [];
      for (var v in v!) {
        arr0.add(v!.toJson());
      }
      data['production_countries'] = arr0;
    }
    if (seasons != null) {
      final v = seasons;
      final arr0 = [];
      for (var v in v!) {
        arr0.add(v!.toJson());
      }
      data['seasons'] = arr0;
    }
    if (spokenLanguages != null) {
      final v = spokenLanguages;
      final arr0 = [];
      for (var v in v!) {
        arr0.add(v!.toJson());
      }
      data['spoken_languages'] = arr0;
    }
    data['status'] = status;
    data['tagline'] = tagline;
    data['type'] = type;
    data['vote_average'] = voteAverage;
    data['vote_count'] = voteCount;
    return data;
  }
}
