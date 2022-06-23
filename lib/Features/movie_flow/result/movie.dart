import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_movie_recomandation_app/Features/movie_flow/genre/genre.dart';

@immutable
class Movie {
  final String title;
  final String overview;
  final num voteAverage;
  final List<Genre> genres;
  final String releaseDate;
  final String? backdropPath;
  final String? posterPath;

const Movie({
    required this.title,
    required this.overview,
    required this.voteAverage,
    required this.genres,
    required this.releaseDate,
    this.backdropPath,
    this.posterPath,
  });

  Movie.initial()
      : title = '',
        overview = '',
        voteAverage = 0,
        genres = [],
        releaseDate = '',
        backdropPath = '',
        posterPath = '';

  String get genresCommaSeparated {
    return genres.map((genre) => genre.name).toList().join(', ');
  }

  @override
  String toString() {
    return 'Movie{title: $title, overview: $overview, voteAverage: $voteAverage, genres: $genresCommaSeparated, releaseDate: $releaseDate, backdropPath: $backdropPath, posterPath: $posterPath}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Movie &&
        title == other.title &&
        overview == other.overview &&
        voteAverage == other.voteAverage &&
        releaseDate == other.releaseDate &&
        listEquals(other.genres, genres);
  }

  @override
  int get hashCode =>
      title.hashCode ^
      overview.hashCode ^
      voteAverage.hashCode ^
      releaseDate.hashCode ^
      genres.hashCode;
}