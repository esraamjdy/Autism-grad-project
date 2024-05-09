// ignore_for_file: unused_field, library_private_types_in_public_api, unnecessary_question_mark, depend_on_referenced_packages, unused_import, duplicate_ignore, use_build_context_synchronously, unused_local_variable
// ignore: unused_import
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grad/Screens/predict/result.dart';

class Form extends StatefulWidget {
  const Form({Key? key}) : super(key: key);
  @override
  _Form createState() => _Form();
}

class FillForm extends StatelessWidget {
  const FillForm({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Form(),
      theme: ThemeData(
        primaryColor: Colors.blue[900],
        hintColor: Colors.blueAccent,
        backgroundColor: const Color.fromARGB(255, 172, 204, 237),
      ),
    );
  }
}

class _Form extends State<Form> {
  final ScrollController _scrollController = ScrollController();
  bool _showAppbarColor = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    setState(() {
      _showAppbarColor = _scrollController.offset > 50;
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  Map<String, dynamic?> selectedChoices = {
    'A1': null,
    'A2': null,
    'A3': null,
    'A4': null,
    'A5': null,
    'A6': null,
    'A7': null,
    'A8': null,
    'A9': null,
    'A10_Autism_Spectrum_Quotient': null,
    'Sex': null,
    'Ethnicity': null,
    'Jaundice': null,
    'Family_mem_with_ASD': null,
    'Who_completed_the_test': null,
    'Age_Years': null,
  };

  void _handleChoiceSelection(String question, dynamic choice) {
    setState(() {
      selectedChoices[question] = choice;
    });
  }

  void _submitForm() async {
    bool allQuestionsAnswered =
        selectedChoices.values.every((value) => value != null);

    if (!allQuestionsAnswered) {
      Fluttertoast.showToast(
        msg: "Please answer all questions.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: const Color.fromARGB(255, 105, 102, 104),
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return;
    }

    Map<String, int> intChoices = {
      'A1': (selectedChoices['A1'] == 'Never' ||
              selectedChoices['A1'] == 'Sometimes' ||
              selectedChoices['A1'] == 'Rarly')
          ? 1
          : 0,
      'A2': (selectedChoices['A2'] == 'Never' ||
              selectedChoices['A2'] == 'Sometimes' ||
              selectedChoices['A2'] == 'Rarly')
          ? 1
          : 0,
      'A3': (selectedChoices['A3'] == 'Never' ||
              selectedChoices['A3'] == 'Sometimes' ||
              selectedChoices['A3'] == 'Rarly')
          ? 1
          : 0,
      'A4': (selectedChoices['A4'] == 'Never' ||
              selectedChoices['A4'] == 'Sometimes' ||
              selectedChoices['A4'] == 'Rarly')
          ? 1
          : 0,
      'A5': (selectedChoices['A5'] == 'Never' ||
              selectedChoices['A5'] == 'Sometimes' ||
              selectedChoices['A5'] == 'Rarly')
          ? 1
          : 0,
      'A6': (selectedChoices['A6'] == 'Never' ||
              selectedChoices['A6'] == 'Sometimes' ||
              selectedChoices['A6'] == 'Rarly')
          ? 1
          : 0,
      'A7': (selectedChoices['A7'] == 'Never' ||
              selectedChoices['A7'] == 'Sometimes' ||
              selectedChoices['A7'] == 'Rarly')
          ? 1
          : 0,
      'A8': (selectedChoices['A8'] == 'Never' ||
              selectedChoices['A8'] == 'Sometimes' ||
              selectedChoices['A8'] == 'Rarly')
          ? 1
          : 0,
      'A9': (selectedChoices['A9'] == 'Never' ||
              selectedChoices['A9'] == 'Sometimes' ||
              selectedChoices['A9'] == 'Rarly')
          ? 1
          : 0,
      'A10_Autism_Spectrum_Quotient':
          (selectedChoices['A10_Autism_Spectrum_Quotient'] == 'Always' ||
                  selectedChoices['A10_Autism_Spectrum_Quotient'] ==
                      'Usually' ||
                  selectedChoices['A10_Autism_Spectrum_Quotient'] ==
                      'Sometimes')
              ? 1
              : 0,
      'Age_Years': int.tryParse(selectedChoices['Age_Years'] ?? '') ?? 0,
      'Qchat_10_Score': 0,
      'Sex': selectedChoices['Sex'] == 'M' ? 1 : 0,
      'Jaundice': selectedChoices['Jaundice'] == 'Yes' ? 1 : 0,
      'Ethnicity_Black': selectedChoices['Ethnicity'] == 'Black' ? 1 : 0,
      'Ethnicity_Hispanic': selectedChoices['Ethnicity'] == 'Hispanic' ? 1 : 0,
      'Ethnicity_Latino': selectedChoices['Ethnicity'] == 'Latino' ? 1 : 0,
      'Ethnicity_Middle Eastern':
          selectedChoices['Ethnicity'] == 'Middle Eastern' ? 1 : 0,
      'Ethnicity_Mixed': selectedChoices['Ethnicity'] == 'Mixed' ? 1 : 0,
      'Ethnicity_Native Indian':
          selectedChoices['Ethnicity'] == 'Native Indian' ? 1 : 0,
      'Ethnicity_Others': selectedChoices['Ethnicity'] == 'Others' ? 1 : 0,
      'Ethnicity_Pacifica': selectedChoices['Ethnicity'] == 'Pacifica' ? 1 : 0,
      'Ethnicity_South Asian':
          selectedChoices['Ethnicity'] == 'South Asian' ? 1 : 0,
      'Ethnicity_White European':
          selectedChoices['Ethnicity'] == 'White European' ? 1 : 0,
      'Family_mem_with_ASD':
          selectedChoices['Family_mem_with_ASD'] == 'Yes' ? 1 : 0,
      'Who_completed_the_test_Health Care Professional':
          selectedChoices['Who_completed_the_test'] ==
                  'Health Care Professional'
              ? 1
              : 0,
      'Who_completed_the_test_Others':
          selectedChoices['Who_completed_the_test'] == 'Others' ? 1 : 0,
      'Who_completed_the_test_School and NGO':
          selectedChoices['Who_completed_the_test'] == 'School and NGO' ? 1 : 0,
      'Who_completed_the_test_Self':
          selectedChoices['Who_completed_the_test'] == 'Self' ? 1 : 0,
    };

    for (int i = 1; i <= 9; i++) {
      intChoices['Qchat_10_Score'] =
          (intChoices['Qchat_10_Score'])! + (intChoices['A$i'])!;
    }
    intChoices['Qchat_10_Score'] = (intChoices['Qchat_10_Score'])! +
        (intChoices['A10_Autism_Spectrum_Quotient'])!;
    print(intChoices);

    String jsonData = jsonEncode(intChoices);
    try {
      final response = await http.post(
        Uri.parse('http://192.168.1.11:5000/predict'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonData,
      );

      if (response.statusCode == 200) {
        String result = jsonDecode(response.body);
        //result = responseData.toString();
        print('//////////////Status code: ${response.statusCode}');
        print(result);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FormResult(outcome: result),
          ),
        );
      } else {
        Fluttertoast.showToast(
          msg: "Failed to send data. Status code: ${response.statusCode}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: const Color.fromARGB(255, 105, 102, 104),
          textColor: Colors.white,
          fontSize: 16.0,
        );
        print('Failed to send data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Error sending request: $e",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: const Color.fromARGB(255, 105, 102, 104),
        textColor: Colors.white,
        fontSize: 16.0,
      );
      print('Error sending request: $e');
    }
  }

  Widget _buildDropdownQuestion(
    String question,
    String text,
    List<String> choices,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.teal.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Colors.teal.withOpacity(0.5), width: 2.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              text,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ),
          DropdownButtonFormField<String>(
            value: selectedChoices[question],
            items: choices.map((value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: const TextStyle(fontSize: 16),
                ),
              );
            }).toList(),
            onChanged: (String? value) {
              _handleChoiceSelection(question, value);
            },
            decoration: InputDecoration(
              labelText: 'Select choice',
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.teal),
                borderRadius: BorderRadius.circular(10.0),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
          ),
        ],
      ),
    );
  }

  String _getQuestionText(int index) {
    switch (index) {
      case 1:
        return 'Does your child look at you when you call his/her name?';
      case 2:
        return 'How easy is it for you to get eye contact with your child?';
      case 3:
        return 'Does your child point to indicate that s/he wants something?';
      case 4:
        return 'Does your child point to share interest with you?';
      case 5:
        return 'Does your child pretend?';
      case 6:
        return 'Does your child follow where you’re looking?';
      case 7:
        return 'If you or someone else in the family is visibly upset, does your child show signs of wanting to comfort them?';
      case 8:
        return 'Would you describe your child’s first words as:';
      case 9:
        return 'Does your child use simple gestures?';
      default:
        return '';
    }
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
        title: const Text(
          'Detection Form',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.teal,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var i = 1; i <= 9; i++)
                _buildDropdownQuestion(
                  'A$i',
                  _getQuestionText(i),
                  ['Never', 'Rarely', 'Sometimes', 'Usually', 'Always'],
                ),
              _buildDropdownQuestion(
                'A10_Autism_Spectrum_Quotient',
                'Does your child stare at nothing with no apparent purpose?',
                ['Never', 'Rarely', 'Sometimes', 'Usually', 'Always'],
              ),
              _buildDropdownQuestion(
                'Age_Years',
                'Child\'s Age (Years)',
                List<String>.generate(18, (i) => (i + 1).toString()),
              ),
              _buildDropdownQuestion(
                'Sex',
                'Child\'s Sex',
                ['M', 'F'],
              ),
              _buildDropdownQuestion(
                'Jaundice',
                'Jaundice history',
                ['Yes', 'No'],
              ),
              _buildDropdownQuestion(
                'Ethnicity',
                'Child\'s Ethnicity',
                [
                  'Black',
                  'Hispanic',
                  'Latino',
                  'Middle Eastern',
                  'Mixed',
                  'Native Indian',
                  'Others',
                  'Pacifica',
                  'South Asian',
                  'White European'
                ],
              ),
              _buildDropdownQuestion(
                'Family_mem_with_ASD',
                'Family member with ASD',
                ['Yes', 'No'],
              ),
              _buildDropdownQuestion(
                'Who_completed_the_test',
                'Who completed the test?',
                [
                  'Health Care Professional',
                  'Others',
                  'School and NGO',
                  'Self'
                ],
              ),
              const SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.teal,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: const Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
