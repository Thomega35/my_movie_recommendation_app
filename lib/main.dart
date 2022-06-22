import 'package:flutter/material.dart';
import 'package:my_movie_recomandation_app/Features/movie_flow/movie_flow.dart';
import 'package:my_movie_recomandation_app/Theme/custom_theme.dart';
import 'package:my_movie_recomandation_app/Theme/palette.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie Recommendation App',
      darkTheme: CustomTheme.darkTheme(context),
      themeMode: ThemeMode.dark,
      home: const MovieFlow(),
    );
  }
}