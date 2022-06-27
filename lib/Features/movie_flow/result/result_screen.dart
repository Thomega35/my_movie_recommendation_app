import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:my_movie_recomandation_app/Core/widgets/primary_button.dart';
import 'package:my_movie_recomandation_app/Core/constants.dart';
import 'package:my_movie_recomandation_app/Features/movie_flow//movie_flow_controller.dart';
import 'movie.dart';

class ResultScreen extends ConsumerWidget {
  static route({bool fullScreenDialog = true}) => MaterialPageRoute(
        builder: (context) => const ResultScreen(),
        fullscreenDialog: fullScreenDialog,
      );
  const ResultScreen({Key? key}) : super(key: key);

  final double movieHeight = 150;


  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                        movie: ref.watch(movieFlowControllerProvider).movie,
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
                    ref.watch(movieFlowControllerProvider).movie.overview,
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

class MovieImageDetail extends ConsumerWidget {
  const MovieImageDetail({
    Key? key,
    required this.movie,
    required this.movieHeight,
  }) : super(key: key);

  final Movie movie;
  final double movieHeight;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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