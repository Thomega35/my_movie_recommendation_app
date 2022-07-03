import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_movie_recommendation_app/core/widgets/failure_screen.dart';

void main(){
  testWidgets('Given message When rendering failure screen Then finds that message', (widgetTester) async{
    const message = 'Error';
    await widgetTester.pumpWidget(
      const MaterialApp(
        home: FailureScreen(message: message),
      ),
    );

    expect(find.text(message), findsOneWidget);
  });
}