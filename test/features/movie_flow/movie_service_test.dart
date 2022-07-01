import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_movie_recommendation_app/core/failure.dart';
import 'package:my_movie_recommendation_app/features/movie_flow/genre/genre.dart';
import 'package:my_movie_recommendation_app/features/movie_flow/genre/genre_entity.dart';
import 'package:my_movie_recommendation_app/features/movie_flow/movie_repository.dart';
import 'package:my_movie_recommendation_app/features/movie_flow/movie_service.dart';
import 'package:my_movie_recommendation_app/features/movie_flow/result/movie.dart';
import 'package:my_movie_recommendation_app/features/movie_flow/result/movie_entity.dart';


class MockMovieRepository extends Mock implements MovieRepository {

}


void main(){
  late MovieRepository mockedMovieRepository;

  setUp((){
    mockedMovieRepository = MockMovieRepository();
  });

  test('Given successful call when getting GenreEntities Then map to correct genres', () async {
    when(() => mockedMovieRepository.getMoviesGenres()).thenAnswer((invocation) async => Future.value([
      const GenreEntity(id: 0, name: 'Animation'),
      const GenreEntity(id: 1, name: 'Comedy'),
      const GenreEntity(id: 2, name: 'Drama'),
    ]));
    final movieService = TMDBMovieService(mockedMovieRepository);
    final result = await movieService.getGenres();
    expect(result.getSuccess(), [
      const Genre(id: 0, name: 'Animation'),
      const Genre(id: 1, name: 'Comedy'),
      const Genre(id: 2, name: 'Drama'),
    ]);
  });
  
  test('Given failed call When getting GenreEntities Then return failure', () async{
    when (() => mockedMovieRepository.getMoviesGenres()).thenThrow(
        Failure(message: 'No internet', exception: const SocketException('')),
    );
    final movieService = TMDBMovieService(mockedMovieRepository);
    final result = await movieService.getGenres();
    expect(result.getError()?.exception, isA<SocketException>());
  });

  test('Given successful call When getting MovieEntity Then map to correct Movie', () async {
    const genre = Genre(id: 0, name: 'Animation', isSelected: true);
    const movieEntity = MovieEntity(
      title: 'The Lion King',
      overview: 'Simba idolises his father, King Mufasa, and takes to heart his own royal destiny. But not everyone in the kingdom celebrates the new cub\'s arrival. Scar, Mufasa\'s brother—and former heir to the throne—has plans of his own. With help from439, an unlikely pair of star-crossed lovers, Simba will have to figure out how to grow up and take back the kingdom.',
      voteAverage: 7.8,
      genreIds: [0],
      releaseDate: '2019-07-12',
    );
    when(() => mockedMovieRepository.getRecommendedMovies(any(), any(), any())).thenAnswer((invocation) => Future.value([
      movieEntity,
    ]));

    final movieService = TMDBMovieService(mockedMovieRepository);
    final result = await movieService.getRecommendedMovie(7, 10, [genre], DateTime(2022));
    final movie = result.getSuccess();
    expect(
      movie,
      Movie(
        title : movieEntity.title,
        overview: movieEntity.overview,
        voteAverage: movieEntity.voteAverage,
        releaseDate: movieEntity.releaseDate,
        genres: const [genre],
      ));
  });
  
  test('Given failed call When getting MovieEntities Then return failure', () async{
    const genre = Genre(id: 0, name: 'Animation', isSelected: true);
    when(() => mockedMovieRepository.getRecommendedMovies(any(), any(), any())).thenThrow(
        Failure(message: 'No internet', exception: const SocketException('')),
    );
    final movieService = TMDBMovieService(mockedMovieRepository);
    final result = await movieService.getRecommendedMovie(7, 10, [genre], DateTime(2022));
    expect(result.getError()?.exception, isA<SocketException>());
  });
  
}