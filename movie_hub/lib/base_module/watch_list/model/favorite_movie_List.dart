// To parse this JSON data, do
//
//     final favoriteMovieList = favoriteMovieListFromJson(jsonString);

import 'dart:convert';

FavoriteMovieList favoriteMovieListFromJson(String str) => FavoriteMovieList.fromJson(json.decode(str));

String favoriteMovieListToJson(FavoriteMovieList data) => json.encode(data.toJson());

class FavoriteMovieList {
  int page;
  List<FavoriteMovie> results;
  int totalPages;
  int totalResults;

  FavoriteMovieList({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory FavoriteMovieList.fromJson(Map<String, dynamic> json) => FavoriteMovieList(
    page: json["page"],
    results: List<FavoriteMovie>.from(json["results"].map((x) => FavoriteMovie.fromJson(x))),
    totalPages: json["total_pages"],
    totalResults: json["total_results"],
  );

  Map<String, dynamic> toJson() => {
    "page": page,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
    "total_pages": totalPages,
    "total_results": totalResults,
  };
}

class FavoriteMovie {
  bool adult;
  String backdropPath;
  List<int>? genreIds;
  int id;
  String originalLanguage;
  String originalTitle;
  String overview;
  double? popularity;
  String posterPath;
  DateTime? releaseDate;
  String title;
  bool? video;
  double? voteAverage;
  int? voteCount;

  FavoriteMovie({
    required this.adult,
    required this.backdropPath,
    this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    this.popularity,
    required this.posterPath,
    this.releaseDate,
    required this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
  });

  factory FavoriteMovie.fromJson(Map<String, dynamic> json) => FavoriteMovie(
    adult: json["adult"],
    backdropPath: json["backdrop_path"],
    genreIds: json["genre_ids"] == null ? [] : List<int>.from(json["genre_ids"]!.map((x) => x)),
    id: json["id"],
    originalLanguage: json["original_language"],
    originalTitle: json["original_title"],
    overview: json["overview"],
    popularity: json["popularity"]?.toDouble(),
    posterPath: json["poster_path"],
    releaseDate: json["release_date"] == null ? null : DateTime.parse(json["release_date"]),
    title: json["title"],
    video: json["video"],
    voteAverage: json["vote_average"]?.toDouble(),
    voteCount: json["vote_count"],
  );

  Map<String, dynamic> toJson() => {
    "adult": adult,
    "backdrop_path": backdropPath,
    "genre_ids": genreIds == null ? [] : List<dynamic>.from(genreIds!.map((x) => x)),
    "id": id,
    "original_language": originalLanguage,
    "original_title": originalTitle,
    "overview": overview,
    "popularity": popularity,
    "poster_path": posterPath,
    "release_date": "${releaseDate!.year.toString().padLeft(4, '0')}-${releaseDate!.month.toString().padLeft(2, '0')}-${releaseDate!.day.toString().padLeft(2, '0')}",
    "title": title,
    "video": video,
    "vote_average": voteAverage,
    "vote_count": voteCount,
  };
}
