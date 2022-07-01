
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:my_movie_recommendation_app/features/movie_flow/genre/genre.dart';
import 'package:my_movie_recommendation_app/features/movie_flow/movie_flow_controller.dart';
import 'package:my_movie_recommendation_app/features/movie_flow/movie_service.dart';

class MockMovieService extends Mock implements MovieService {}

void main(){
  late MockMovieService mockMovieService;
  late ProviderContainer container;
  late Genre genre;
  setUp(() {
    mockMovieService = MockMovieService();
    container = ProviderContainer(
      overrides: [
        movieServiceProvider.overrideWithValue(mockMovieService),
      ],
    );
    genre = const Genre(name: 'Animation');
    when(() => mockMovieService.getGenres()).thenAnswer((invocation) => Future.value(
      Success([genre]),
    ));
  });
  
  tearDown(() {
    container.dispose();
  });
  
  group('MovieFlowControllerTests -', () {
    test('Given genres When Toggle Then that genre should be toggled', () async {
      await container.read(movieFlowControllerProvider.notifier).stream.firstWhere((state) => state.genres is AsyncData);
      container.read(movieFlowControllerProvider.notifier).toggleSelected(genre);
      final toggledGenre = genre.toggleSelected();
      expect(container.read(movieFlowControllerProvider).genres.value, [toggledGenre]);
    });

    for (final rating in [0, 7, 10, 2, -2]){
      test('Given different ratings When updating rating with $rating', () async {
        container.read(movieFlowControllerProvider.notifier).updateRating(rating);
        expect(container.read(movieFlowControllerProvider).rating, rating < 0 ? 0 : rating);
      });
    }

    for (final yearsBack in [0, 7, 70, 2, -2]){
      test('Given different yearsBack When updating yearsBack with $yearsBack', () async {
        container.read(movieFlowControllerProvider.notifier).updateYearsBack(yearsBack);
        expect(container.read(movieFlowControllerProvider).yearsBack, yearsBack < 0 ? 0 : yearsBack);
      });
    }
  });
}