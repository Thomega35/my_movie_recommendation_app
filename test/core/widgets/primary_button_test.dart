

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_movie_recommendation_app/core/widgets/primary_button.dart';

void main(){
  testWidgets('Given primary button When loading is true Then find progress indicator', (widgetTester) async{
    await widgetTester.pumpWidget(
      MaterialApp(
        home: PrimaryButton(
          isLoading: true,
          text: 'Button',
          onPressed: () {},
        ),
      ),
    );
    final loadingIndicator = find.byType(CircularProgressIndicator);
    expect(loadingIndicator, findsOneWidget);
  });

  testWidgets('Given primary button When loading is false Then find no progress indicator', (widgetTester) async{
    await widgetTester.pumpWidget(
      MaterialApp(
        home: PrimaryButton(
          isLoading: false,
          text: 'test',
          onPressed: () {},
        ),
      ),
    );
    final loadingIndicator = find.byType(CircularProgressIndicator);
    expect(loadingIndicator, findsNothing);
  });

  testWidgets('Given primary button When loading is false Then find text', (widgetTester) async{
    await widgetTester.pumpWidget(
      MaterialApp(
        home: PrimaryButton(
          isLoading: false,
          text: 'test',
          onPressed: () {},
        ),
      ),
    );
    final text = find.text('test');
    expect(text, findsOneWidget);
  });
}