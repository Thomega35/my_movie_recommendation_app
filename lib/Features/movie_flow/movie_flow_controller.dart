import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_movie_recomandation_app/Features/movie_flow/genre/genre.dart';
import 'package:my_movie_recomandation_app/Features/movie_flow/movie_flow_state.dart';

final movieFlowControllerProvider =
    StateNotifierProvider.autoDispose<MovieFlowController, MovieFlowState>(
  (ref) =>
      MovieFlowController(MovieFlowState(pageController: PageController())),
);

class MovieFlowController extends StateNotifier<MovieFlowState> {
  MovieFlowController(MovieFlowState state) : super(state);

  void toggleSelected(Genre genre) {
    state = state.copyWith(
        genres: [
          for (final oldGenre in state.genres)
            if (oldGenre == genre)
              oldGenre.toggleSelected()
            else
              oldGenre,
        ]
    );
  }

  void updateRating(int updatedRating) {
    state = state.copyWith(rating: updatedRating);
  }

  void updateYearsBack(int updatedYearBack) {
    state = state.copyWith(yearsback: updatedYearBack);
  }

  void nextPage() {
    if (state.pageController.page! >= 1) {
      if (!state.genres.any((genre) => genre.isSelected == true)) {
        return;
      }
    }

    state.pageController.nextPage(
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOutCubic,
    );
  }

  void previousPage() {
    state.pageController.previousPage(
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  void dispose() {
    state.pageController.dispose();
    super.dispose();
  }
}