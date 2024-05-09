// ignore_for_file: unused_import, depend_on_referenced_packages, library_private_types_in_public_api

import 'dart:io';
import 'package:grad/Screens/Games/attention_to_details.dart';
import 'package:grad/Screens/contactUs.dart';
import 'package:grad/Screens/firstPage.dart';
import 'package:grad/Screens/home.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

class Games extends StatefulWidget {
  const Games({Key? key});

  @override
  _GamesState createState() => _GamesState();
}

class games extends StatelessWidget {
  const games({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Image.asset(
              'assets/icon/icon2.png',
              color: Colors.white,
            ),
          ),
        ],
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.teal,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/icon/icon2.png',
                    width: 89,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'ASD',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              title: Text(
                'Home',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyHome(),
                  ),
                );
              },
            ),
            ListTile(
              title: Text(
                'Detection',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FirstPage(),
                  ),
                );
              },
            ),
            ListTile(
              title: Text(
                'Activities',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => games(),
                  ),
                );
              },
            ),
            ListTile(
              title: Text(
                'Contact Us',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ContactUsPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Get some Entertainment and knowledge',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 20,
              runSpacing: 20,
              children: [
                GameCard(
                  image: 'assets/images/learning.png',
                  title: 'Learning',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            GameCategoryPage(category: 'Learning'),
                      ),
                    );
                  },
                ),
                GameCard(
                  image: 'assets/images/social.png',
                  title: 'Social Skills',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            GameCategoryPage(category: 'Social Skills'),
                      ),
                    );
                  },
                ),
                GameCard(
                  image: 'assets/images/detail.png',
                  title: 'Imagination',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            GameCategoryPage(category: 'Imagination'),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class GameCard extends StatelessWidget {
  final String image;
  final String title;
  final VoidCallback onTap;

  const GameCard({
    required this.image,
    required this.title,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              image,
              width: 80,
              height: 80,
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GameCategoryPage extends StatelessWidget {
  final String category;

  // List of games for each category
  final Map<String, List<String>> gamesByCategory = {
    'Learning': ['Learn Basics'],
    'Social Skills': ['Learn Emotions'],
    'Imagination': ['Puzzle'],
  };

  GameCategoryPage({required this.category});

  @override
  Widget build(BuildContext context) {
    List<String> games = gamesByCategory[category] ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text(category),
        backgroundColor: Colors.teal,
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 1.0, // Adjust as needed
        ),
        itemCount: games.length,
        itemBuilder: (context, index) {
          String gameName = games[index];
          return GameCard(
            image: 'assets/images/$gameName.png',
            title: gameName,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GameDetailsPage(gameName: gameName),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class GameDetailsPage extends StatelessWidget {
  final String gameName;

  GameDetailsPage({required this.gameName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(gameName),
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Text('Details of $gameName'),
      ),
    );
  }
}

class _GamesState extends State<Games> {
  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }
}
