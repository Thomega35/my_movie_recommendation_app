import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_movie_recomandation_app/Features/movie_flow/movie_flow.dart';
import 'package:my_movie_recomandation_app/Theme/custom_theme.dart';
import 'package:dio/dio.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

final dioProvider = Provider<Dio>(
  (ref) => Dio(BaseOptions(baseUrl: 'https://api.themoviedb.org/3/')),
);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie Recommendation App',
      darkTheme: CustomTheme.darkTheme(context),
      themeMode: ThemeMode.dark,
      home: MovieFlow(),
    );
  }
}