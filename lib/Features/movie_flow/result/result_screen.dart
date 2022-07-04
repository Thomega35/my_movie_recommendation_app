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

class _ResultScreenAnimationState extends State<ResultScreenAnimation> with SingleTickerProviderStateMixin {
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

  const ResultScreen({
    Key? key,
    required this.animationController
  }) : super(key: key);
  final AnimationController animationController;
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
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: movieHeight / 2,
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
          path : movie.backdropPath ?? '',
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 100,
            height: movieHeight,
            child: NetworkFadingImage(
              path : movie.backdropPath ?? '',
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
                        color:
                            theme.textTheme.bodyText2?.color?.withOpacity(0.62),
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
