import 'package:flutter/material.dart';
import 'package:my_movie_recomandation_app/Features/movie_flow/genre/genre.dart';
import 'package:my_movie_recomandation_app/Features/movie_flow/result/movie.dart';

const genresMock = [
  Genre(name: 'Action'),
  Genre(name: 'Comedy'),
  Genre(name: 'Horror'),
  Genre(name: 'Anime'),
  Genre(name: 'Drama'),
  Genre(name: 'Family'),
  Genre(name: 'Romance'),
  Genre(name: 'Drama'),
  Genre(name: 'Thriller'),
];

const movieMock = Movie(
  title: 'The Irishman',
  genres: [Genre(name: 'Drama'), Genre(name: 'Thriller')],
  overview:
  'The aging patriarch of an organized crime dynasty transfers control of his clandestine empire to his reluctant son.',
  voteAverage: 8.5,
  releaseDate: '2019-12-25',
  backdropPath: '',
  posterPath: '',
);

@immutable
class MovieFlowState {
  final PageController pageController;
  final int rating;
  final int yearsback;
  final List<Genre> genres;
  final Movie movie;

  const MovieFlowState({
    required this.pageController,
    this.movie = movieMock,
    this.genres = genresMock,
    this.rating = 5,
    this.yearsback = 10,
  });

  MovieFlowState copyWith({
    PageController? pageController,
    int? rating,
    int? yearsback,
    List<Genre>? genres,
    Movie? movie,
  }) {
    return MovieFlowState(
      pageController: pageController ?? this.pageController,
      rating: rating ?? this.rating,
      yearsback: yearsback ?? this.yearsback,
      genres: genres ?? this.genres,
      movie: movie ?? this.movie,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MovieFlowState
        && pageController == other.pageController
        && rating == other.rating
        && yearsback == other.yearsback
        && genres == other.genres
        && movie == other.movie;
  }

  @override
  int get hashCode =>
      pageController.hashCode ^
      rating.hashCode ^
      yearsback.hashCode ^
      genres.hashCode ^
      movie.hashCode;

}