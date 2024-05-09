// ignore_for_file: non_constant_identifier_names, unused_import, depend_on_referenced_packages, unnecessary_const

import 'dart:io';
import 'dart:ui';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:grad/Screens/contactUs.dart';
import 'package:grad/Screens/firstPage.dart';
import 'package:grad/Screens/games.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class MyHome extends StatelessWidget {
  final List<Map<String, dynamic>> symptoms = [
    {
      "image": "assets/images/n1.png",
      "title": "Hyperactive",
    },
    {
      "image": "assets/images/n2.png",
      "title": "Depression",
    },
    {
      "image": "assets/images/n3.png",
      "title": "Rejecting Cuddles.",
    },
    {
      "image": "assets/images/n4.png",
      "title": "Not Responding.",
    },
    {
      "image": "assets/images/n5.png",
      "title": "Epilepsy.",
    },
    {"image": "assets/images/n6.png", "title": "Prefer to Play Alone."},
    {"image": "assets/images/n7.png", "title": "Connection Problems."},
    {"image": "assets/images/n8.png", "title": "Learning Disability."},
    {
      "image": "assets/images/slider_common/Not calm easily.png",
      "title": "He cannot be calmed easily.",
    },
    {
      "image": "assets/images/slider_common/repeated.png",
      "title": "Repeats some words constantly without a clear goal ",
    },
    {
      "image": "assets/images/slider_common/not eating.png",
      "title": "Has difficulty eating",
    },
    {
      "image": "assets/images/slider_common/Delay.png",
      "title": "He has a significant language delay",
    },
    {
      "image": "assets/images/slider_common/hyperactive,.png",
      "title": "He may be hyperactive, or distracted",
    },
    {
      "image": "assets/images/slider_common/Physical.png",
      "title": "Avoids physical contact with others."
    },
    {
      "image": "assets/images/slider_common/reflect.png",
      "title": 'Reflects pronouns, for example, saying "you" instead of "I".'
    },
  ];

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
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Text(
              'You can detect Autism',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FirstPage(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.teal,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'Diagnose',
                style: TextStyle(fontSize: 20),
              ),
            ),
            SizedBox(height: 30),
            Text(
              'Activities for your child:',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => games(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.teal,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'Activities',
                style: TextStyle(fontSize: 20),
              ),
            ),
            SizedBox(height: 30),
            Text(
              'Common Symptoms',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            SizedBox(
              height: 300,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: symptoms.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Container(
                      width: 250,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(1, 0),
                            spreadRadius: 0,
                            blurRadius: 4,
                            color: Colors.grey,
                          )
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: const EdgeInsets.all(8),
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            symptoms[index]['image'],
                            height: 170,
                            width: 180,
                            fit: BoxFit.contain,
                          ),
                          SizedBox(height: 7),
                          Text(
                            symptoms[index]['title'],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color.fromARGB(255, 138, 138, 138),
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
