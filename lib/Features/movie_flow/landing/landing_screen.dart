import 'package:flutter/material.dart';
import 'package:my_movie_recomandation_app/Core/constants.dart';
import 'package:my_movie_recomandation_app/Core/widgets/primary_button.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({
    Key? key,
    required this.previousPage,
    required this.nextPage
  }) : super(key: key);

  final VoidCallback previousPage;
  final VoidCallback nextPage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie Recommendation App'),
        elevation: 0,
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              'Let\'s find a movie!',
              style: Theme.of(context).textTheme.headline5,
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            Image.asset('images/undraw_horror_movie.png'),
            const Spacer(),
            PrimaryButton(
              text: 'Get Started',
              onPressed: nextPage,
            ),
            const SizedBox(height: kMediumSacing),
            
          ],
        ),
      ),
    );
  }
}