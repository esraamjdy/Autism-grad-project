import 'package:flutter/material.dart';

final List<Widget> onboardingScreens = [
  const OnboardingScreen(
    image: 'assets/images/survey.png',
    title: 'Answer the survey easily',
    description:
        'You can diagnose by answering the survey and the result will appear immediately.',
  ),
  const OnboardingScreen(
    image: 'assets/images/Upload1.png',
    title: 'Upload child image easily',
    description:
        'You can diagnose by uploading child image and the result will appear immediately',
  ),
  const OnboardingScreen(
    image: 'assets/images/communication.png',
    title: 'Take a lot of advice',
    description:
        'You will learn more about Autism and how to deal with autistic child',
  ),
  const OnboardingScreen(
    image: 'assets/icon/pngwing.com (10).png',
    title: 'Your child will learn a lot',
    description:
        'We will learn your child a lot of daily activites like getting more attention. ',
  ),
];

class OnboardingScreen extends StatelessWidget {
  final String image;
  final String title;
  final String description;

  const OnboardingScreen(
      {Key? key,
      required this.image,
      required this.title,
      required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(image, width: 300),
          SizedBox(height: 20),
          Text(title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Text(
            description,
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
