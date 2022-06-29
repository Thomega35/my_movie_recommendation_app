import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_movie_recommendation_app/features/movie_flow/genre/genre.dart';
import 'package:my_movie_recommendation_app/features/movie_flow/result/movie.dart';

@immutable
class MovieFlowState {
  final PageController pageController;
  final int rating;
  final int yearsBack;
  final AsyncValue<List<Genre>> genres;
  final AsyncValue<Movie> movie;

  const MovieFlowState({
    required this.pageController,
    required this.movie,
    required this.genres,
    this.rating = 5,
    this.yearsBack = 10,
  });

  MovieFlowState copyWith({
    PageController? pageController,
    int? rating,
    int? yearsBack,
    AsyncValue<List<Genre>>? genres,
    AsyncValue<Movie>? movie,
  }) {
    return MovieFlowState(
      pageController: pageController ?? this.pageController,
      rating: rating ?? this.rating,
      yearsBack: yearsBack ?? this.yearsBack,
      genres: genres ?? this.genres,
      movie: movie ?? this.movie,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MovieFlowState &&
        pageController == other.pageController &&
        rating == other.rating &&
        yearsBack == other.yearsBack &&
        genres == other.genres &&
        movie == other.movie;
  }

  @override
  int get hashCode =>
      pageController.hashCode ^
      rating.hashCode ^
      yearsBack.hashCode ^
      genres.hashCode ^
      movie.hashCode;
}
