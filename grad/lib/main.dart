import 'package:flutter/material.dart';
import 'package:grad/Screens/OnBoarding.dart';
import 'package:grad/Screens/home.dart';

void main() {
  runApp(MaterialApp(
    home: OnboardingScreenWidget(),
    debugShowCheckedModeBanner: false,
  ));
}

class OnboardingScreenWidget extends StatefulWidget {
  @override
  _OnboardingScreenWidgetState createState() => _OnboardingScreenWidgetState();
}

class _OnboardingScreenWidgetState extends State<OnboardingScreenWidget> {
  final PageController _pageController = PageController();
  int _currentPageIndex = 0;
  bool _isLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: onboardingScreens.length,
            itemBuilder: (context, index) {
              return onboardingScreens[index];
            },
            onPageChanged: (int index) {
              setState(() {
                _currentPageIndex = index;
                _isLastPage = index == onboardingScreens.length - 1;
              });
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: FractionallySizedBox(
              widthFactor: 1,
              child: Container(
                margin: EdgeInsets.only(bottom: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    onboardingScreens.length,
                    (index) => Container(
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _currentPageIndex == index
                            ? Colors.black
                            : Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: GestureDetector(
              onTap: () {
                if (_isLastPage) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => MyHome()),
                  );
                } else {
                  _pageController.nextPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.ease,
                  );
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => MyHome()),
                  );
                }
              },
              child: Text(
                _isLastPage ? 'Get Started' : 'Skip',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main Page'),
      ),
      body: const Center(
        child: Text('This is the main page!'),
      ),
    );
  }
}
