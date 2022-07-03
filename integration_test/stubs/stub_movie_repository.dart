import 'package:my_movie_recommendation_app/features/movie_flow/genre/genre_entity.dart';
import 'package:my_movie_recommendation_app/features/movie_flow/movie_repository.dart';
import 'package:my_movie_recommendation_app/features/movie_flow/result/movie_entity.dart';

class StubMovieRepository implements MovieRepository {

  @override
  Future<List<GenreEntity>> getMoviesGenres() async {
    return Future.value([
      const GenreEntity(
        id: 1,
        name: 'Animation',
      ),
    ]);
  }

  @override
  Future<List<MovieEntity>> getRecommendedMovies(double rating, String date, String genreIds) {
    return Future.value([
      const MovieEntity(
        title: 'The Incredibles',
        overview: 'Elastigirl springs into action to save the day, while Mr. Incredible faces his greatest challenge yet – taking care of the problems of his three children.',
        releaseDate: '2004-06-22',
        genreIds: [1],
        voteAverage: 5.2,
      ),
    ]);
  }
}