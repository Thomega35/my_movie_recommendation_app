import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_movie_recommendation_app/core/constants.dart';
import 'package:my_movie_recommendation_app/core/widgets/network_fading_image.dart';
import 'package:my_movie_recommendation_app/core/widgets/primary_button.dart';
import 'package:my_movie_recommendation_app/features/movie_flow/movie_flow_controller.dart';
import 'package:my_movie_recommendation_app/features/movie_flow/result/movie.dart';
import 'package:my_movie_recommendation_app/core/widgets/failure_screen.dart';
import 'package:my_movie_recommendation_app/core/failure.dart';

class ResultScreenAnimation extends StatefulWidget {
  const ResultScreenAnimation({Key? key}) : super(key: key);

  @override
  _ResultScreenAnimationState createState() => _ResultScreenAnimationState();
}

class _ResultScreenAnimationState extends State<ResultScreenAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ResultScreen(
      animationController: _controller,
    );
  }
}

class ResultScreen extends ConsumerWidget {
  static route({bool fullScreenDialog = true}) => MaterialPageRoute(
        builder: (context) => const ResultScreenAnimation(),
        fullscreenDialog: fullScreenDialog,
      );

  ResultScreen({
    Key? key,
    required this.animationController,
  })  : titleOpacity = Tween<double>(begin: 0, end: 1).animate(
          CurvedAnimation(
            parent: animationController,
            curve: const Interval(0, 0.3),
          ),
        ),
        genreOpacity = Tween<double>(begin: 0, end: 1).animate(
          CurvedAnimation(
            parent: animationController,
            curve: const Interval(0.3, 0.4),
          ),
        ),
        ratingOpacity = Tween<double>(begin: 0, end: 1).animate(
          CurvedAnimation(
            parent: animationController,
            curve: const Interval(0.4, 0.6),
          ),
        ),
        descriptionOpacity = Tween<double>(begin: 0, end: 1).animate(
          CurvedAnimation(
            parent: animationController,
            curve: const Interval(0.6, 0.8),
          ),
        ),
        buttonOpacity = Tween<double>(begin: 0, end: 1).animate(
          CurvedAnimation(
            parent: animationController,
            curve: const Interval(0.8, 1),
          ),
        ),
        super(key: key);
  final AnimationController animationController;

  final Animation<double> titleOpacity;
  final Animation<double> genreOpacity;
  final Animation<double> ratingOpacity;
  final Animation<double> descriptionOpacity;
  final Animation<double> buttonOpacity;

  final double movieHeight = 150;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(movieFlowControllerProvider).movie.when(
          data: (movie) {
            return Scaffold(
              appBar: AppBar(),
              body: Column(
                children: [
                  Expanded(
                    child: ListView(
                      children: [
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            CoverImage(movie: movie),
                            Positioned(
                              width: MediaQuery.of(context).size.width,
                              bottom: -(movieHeight / 2),
                              child: MovieImageDetail(
                                movie: movie,
                                movieHeight: movieHeight,
                                titleOpacity: titleOpacity,
                                ratingOpacity: ratingOpacity,
                                genreOpacity: genreOpacity,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: movieHeight / 2,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: FadeTransition(
                            opacity: descriptionOpacity,
                            child: Text(
                              movie.overview,
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  FadeTransition(
                    opacity: buttonOpacity,
                    child: PrimaryButton(
                      onPressed: () => Navigator.of(context).pop(),
                      text: 'Find another movie',
                    ),
                  ),
                  const SizedBox(
                    height: kMediumSpacing,
                  ),
                ],
              ),
            );
          },
          error: (error, s) {
            if (error is Failure) {
              return FailureScreen(message: error.message);
            } else {
              return const FailureScreen(message: 'Something went wrong :(');
            }
          },
          loading: () => const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
  }
}

class CoverImage extends StatelessWidget {
  const CoverImage({Key? key, required this.movie}) : super(key: key);

  final Movie movie;

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
        child: NetworkFadingImage(
          path: movie.backdropPath ?? '',
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
    required this.titleOpacity,
    required this.genreOpacity,
    required this.ratingOpacity,
  }) : super(key: key);

  final Movie movie;
  final double movieHeight;

  final Animation<double> titleOpacity;
  final Animation<double> genreOpacity;
  final Animation<double> ratingOpacity;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 100,
            height: movieHeight,
            child: NetworkFadingImage(
              path: movie.backdropPath ?? '',
            ),
          ),
          const SizedBox(width: kMediumSpacing),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FadeTransition(
                  opacity: titleOpacity,
                  child: Text(
                    movie.title,
                    style: theme.textTheme.headline6,
                  ),
                ),
                FadeTransition(
                  opacity: genreOpacity,
                  child: Text(
                    movie.genresCommaSeparated,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ),
                FadeTransition(
                  opacity: ratingOpacity,
                  child: Row(
                    children: [
                      Text(
                        '${movie.voteAverage}',
                        style: theme.textTheme.bodyText2?.copyWith(
                          color: theme.textTheme.bodyText2?.color
                              ?.withOpacity(0.62),
                        ),
                      ),
                      const Icon(
                        Icons.star_rounded,
                        size: 20,
                        color: Colors.amber,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
