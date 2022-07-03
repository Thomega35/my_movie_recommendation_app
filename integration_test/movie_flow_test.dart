


import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:my_movie_recommendation_app/core/widgets/primary_button.dart';
import 'package:my_movie_recommendation_app/features/movie_flow/movie_repository.dart';
import 'package:my_movie_recommendation_app/main.dart';
import 'stubs/stub_movie_repository.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('test basic flow and see the fake generated movie in the end', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          movieRepositoryProvider.overrideWithValue(
            StubMovieRepository(),
          ),
        ],
        child: const MyApp(),
      ),
    );
    await tester.tap(find.byType(PrimaryButton));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Animation'));
    await tester.tap(find.byType(PrimaryButton));

    await tester.pumpAndSettle();
    await tester.tap(find.byType(PrimaryButton));

    await tester.pumpAndSettle();
    await tester.tap(find.byType(PrimaryButton));

    await tester.pumpAndSettle();
    expect(find.text('The Incredibles'), findsOneWidget);
  });

  testWidgets('test basic flow make sure we do not get past the genre screen if we do not select a genre', (widgetTester) async {
    await widgetTester.pumpWidget(
      ProviderScope(
        overrides: [
          movieRepositoryProvider.overrideWithValue(
            StubMovieRepository(),
          ),
        ],
        child: const MyApp(),
      ),
    );
    await widgetTester.tap(find.byType(PrimaryButton));
    await widgetTester.pumpAndSettle();
    //try to go to the next screen without selecting a genre
    await widgetTester.tap(find.byType(PrimaryButton));

    expect(find.text('Animation'), findsOneWidget);

  });
}