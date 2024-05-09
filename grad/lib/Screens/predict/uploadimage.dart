// ignore_for_file: depend_on_referenced_packages, use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_constructors, avoid_print, unused_import, unused_local_variable

import 'dart:convert';
import 'dart:io';
import 'package:grad/Screens/predict/ImageResult.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

class UploadImageDemo extends StatefulWidget {
  @override
  _UploadImageDemoState createState() => _UploadImageDemoState();
}

//upload image
//convert images from pixels to encode base62
//http.put(uri.parse(url), body:base64, header:JSON)

class Uploading extends StatelessWidget {
  const Uploading({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Upload Child Image',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: UploadImageDemo(),
    );
  }
}

class _UploadImageDemoState extends State<UploadImageDemo> {
  File? _imageFile;
  bool _uploading = false;
  String _uploadMessage = '';

  Future<void> uploadImage(String title, File? file) async {
    if (file == null) {
      print('No image selected.');
      return;
    }

    setState(() {
      _uploading = true;
      _uploadMessage = 'Uploading image...';
    });

    try {
      var request = http.MultipartRequest(
        "POST",
        Uri.parse("http://192.168.1.11:3000/upload_image"),
      );
      request.fields['title'] = title;
      var picture = http.MultipartFile(
        'file',
        File(_imageFile!.path).readAsBytes().asStream(),
        file.lengthSync(),
        filename: 'testimage.png',
      );
      request.files.add(picture);
      var response = await request.send();
      var responseData = await response.stream.toBytes();
      var result = String.fromCharCodes(responseData);
      print(result);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ImgResult(
            outcome: result,
          ),
        ),
      );
      /*setState(() {
        _uploading = false;
        _uploadMessage = result;
      });*/
    } catch (e) {
      setState(() {
        _uploading = false;
        _uploadMessage = 'Error uploading image: $e';
      });
    }
  }

  Future<void> _getImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

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
        backgroundColor: Colors.teal,
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Upload a Child Image',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'Please select an image of the child for analysis.',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey[700],
                ),
              ),
              SizedBox(height: 20.0),
              ElevatedButton.icon(
                onPressed: () {
                  if (!_uploading) {
                    _getImage();
                  }
                },
                icon: Icon(Icons.camera_alt),
                label: Text('Select Image'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.teal,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.teal,
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: _imageFile != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.file(
                          _imageFile!,
                          height: 200.0,
                          width: 200.0,
                          fit: BoxFit.cover,
                        ),
                      )
                    : Container(
                        height: 200.0,
                        width: 200.0,
                        color: Colors.grey[200],
                        child: Center(
                          child: Text(
                            'No Image Selected',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
              ),
              SizedBox(height: 20.0),
              if (_uploading)
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: CircularProgressIndicator(),
                ),
              if (_uploadMessage.isNotEmpty)
                Text(
                  _uploadMessage,
                  style: TextStyle(
                    color: Colors.teal,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  if (!_uploading) {
                    uploadImage('file', _imageFile);
                  }
                },
                child: Text('see the Result'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.teal,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }
}
