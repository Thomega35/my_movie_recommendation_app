import 'package:flutter/material.dart';

import 'package:my_movie_recomandation_app/Core/widgets/primary_button.dart';
import 'package:my_movie_recomandation_app/Core/constants.dart';
import 'package:my_movie_recomandation_app/Features/movie_flow/genre/genre.dart';
import 'movie.dart';

class ResultScreen extends StatelessWidget {
  static route({bool fullScreenDialog = true}) => MaterialPageRoute(
        builder: (context) => const ResultScreen(),
        fullscreenDialog: fullScreenDialog,
      );
  const ResultScreen({Key? key}) : super(key: key);

  final double movieHeight = 150;

  final movie = const Movie(
    title: 'The Irishman',
    genres: [Genre(name: 'Drama'), Genre(name: 'Thriller')],
    overview:
        'The aging patriarch of an organized crime dynasty transfers control of his clandestine empire to his reluctant son.',
    voteAverage: 8.5,
    releaseDate: '2019-12-25',
    backdropPath: '',
    posterPath: '',
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    const CoverImage(),
                    Positioned(
                      width: MediaQuery.of(context).size.width,
                      bottom: -(movieHeight / 2),
                      child: MovieImageDetail(
                        movie: movie,
                        movieHeight: movieHeight,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: movieHeight/2,
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    movie.overview,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ),
              ],
            ),
          ),
          PrimaryButton(
              onPressed: () => Navigator.of(context).pop(),
              text: 'Find another movie',
          ),
          const SizedBox(
            height: kMediumSpacing,
          ),
        ],
      ),
    );
  }
}

class CoverImage extends StatelessWidget {
  const CoverImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 298),
      child: ShaderMask(
        shaderCallback: (rect) {
          return LinearGradient(
            begin: Alignment.center,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).scaffoldBackgroundColor,
              Colors.transparent,
            ],
          ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
        },
        blendMode: BlendMode.dstIn,
        child: const Placeholder(

        ),
      ),
    );
  }
}

class MovieImageDetail extends StatelessWidget {
  const MovieImageDetail({
    Key? key,
    required this.movie,
    required this.movieHeight,
  }) : super(key: key);

  final Movie movie;
  final double movieHeight;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child:Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width:100,
              height: movieHeight,
              child: const Placeholder(
              ),
            ),
            const SizedBox(width: kMediumSpacing),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: theme.textTheme.headline6,
                  ),
                  Text(
                    movie.genresCommaSeparated,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  Row(
                    children: [
                      Text(
                        '${movie.voteAverage}',
                        style: theme.textTheme.bodyText2?.copyWith(
                          color: theme.textTheme.bodyText2?.color?.withOpacity(0.62),
                        ),
                      ),
                      const Icon(
                          Icons.star_rounded,
                          size: 20,
                          color: Colors.amber,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
    );
  }
}