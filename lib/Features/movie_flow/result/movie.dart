import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_movie_recommendation_app/features/movie_flow/genre/genre.dart';
import 'package:my_movie_recommendation_app/features/movie_flow/result/movie_entity.dart';

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

  factory Movie.fromEntity(MovieEntity entity, List<Genre> genres) {
    return Movie(
      title: entity.title,
      overview: entity.overview,
      voteAverage: entity.voteAverage,
      genres: genres
          .where((element) => entity.genreIds.contains(element.id))
          .toList(growable: false),
      releaseDate: entity.releaseDate,
      backdropPath:
          'https://image.tmdb.org/t/p/original/${entity.backdropPath}',
      posterPath: 'https://image.tmdb.org/t/p/original/${entity.posterPath}',
    );
  }

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
