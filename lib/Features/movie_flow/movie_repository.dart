import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_movie_recommendation_app/core/environment_variables.dart';
import 'package:my_movie_recommendation_app/features/movie_flow/genre/genre_entity.dart';
import 'package:my_movie_recommendation_app/features/movie_flow/result/movie_entity.dart';
import 'package:my_movie_recommendation_app/main.dart';

final movieRepositoryProvider = Provider<MovieRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return TMDBMovieRepository(dio: dio);
});

abstract class MovieRepository {
  Future<List<GenreEntity>> getMoviesGenres();

  Future<List<MovieEntity>> getRecommendedMovies(
      double rating, String date, String genreIds);
}

class TMDBMovieRepository implements MovieRepository {
  final Dio dio;

  TMDBMovieRepository({required this.dio});

  @override
  Future<List<GenreEntity>> getMoviesGenres() async {
    final response = await dio.get(
      '/genre/movie/list',
      queryParameters: {
        'api_key': api,
        'language': 'en-US',
      },
    );
    final results = List<Map<String, dynamic>>.from(response.data['genres']);
    final genres = results.map((genre) => GenreEntity.fromMap(genre)).toList();
    return genres;
  }

  @override
  Future<List<MovieEntity>> getRecommendedMovies(
      double rating, String date, String genreIds) async {
    final response = await dio.get(
      '/discover/movie',
      queryParameters: {
        'api_key': api,
        'language': 'en-US',
        'sort_by': 'popularity.desc',
        'include_adult': false,
        'page': 1,
        'with_genres': genreIds,
        'primary_release_date.gte': date,
        'vote_average.gte': rating,
      },
    );
    final results = List<Map<String, dynamic>>.from(response.data['results']);
    final movies = results.map((movie) => MovieEntity.fromMap(movie)).toList();
    return movies;
  }
}
