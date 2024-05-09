import 'package:flutter/material.dart';

class ImagePredict extends StatelessWidget {
  final String result;

  ImagePredict({required this.result});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Prediction Result'),
      ),
      body: Center(
        child: Text(result),
      ),
    );
  }
}
