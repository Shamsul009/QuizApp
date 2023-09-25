// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:my_app/question_vault.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() => runApp(WiseApp());

class WiseApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuestionPage(),
          ),
        ),
      ),
    );
  }
}

class QuestionPage extends StatefulWidget {
  @override
  QuestionPageState createState() => QuestionPageState();
}

class QuestionPageState extends State<QuestionPage> {
  List<Widget> iconList = [];

  // List<String> questions = [
  //   'Flutter can only develop mobile applications.',
  //   'Colombo is the capital of Sri Lanka.',
  //   'Cox\'s Bazar is the longest sea beach in the world.'
  // ];

  // List<String> images = [
  //   "images/flutter.png",
  //   "images/colombo.jpeg",
  //   "images/sea-beach.jpeg"
  // ];

  // List<bool> answers = [false, true, true];

  QuestionVault questionVault = QuestionVault();

  bool shouldContinue = true; // A flag to control further execution.
  // void resetQuiz(int index) {
  //   questionVault.nextQuestion(index);
  //   setState(() {
  //     iconList.clear(); // Clear the answer list.
  //     shouldContinue = true; // Reset the flag to true to continue the quiz.
  //   });
  // }

  void clickAnswer(bool clickedAnswer) {

    bool ans = questionVault.getAnswer();
    setState(() {
      if (ans == clickedAnswer) {
        iconList.add(Icon(
          Icons.check,
          color: Colors.green,
        ));
      } else {
        iconList.add(Icon(
          Icons.close,
          color: Colors.red,
        ));
      }
      int index = questionVault.nextQuestion();
      print(index);
      if (index >= 10) {
        Alert(
                context: context,
                title: "Out of Legue",
                desc: "Sorry!No Qustion are available for you.")
            .show();
        
        iconList.clear();
        questionVault.nextQuestion();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                questionVault.getQuestionTitle(),
                //questions[currentQuestion],
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Card(
                color: Colors.white,
                shadowColor: Colors.grey,
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: AssetImage(
                        questionVault.getImage(),
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                clickAnswer(true);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                clickAnswer(false);
                //The user picked false.
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(children: iconList),
        )
        //TODO: Add a Row here to show your right or wrong answer
      ],
    );
  }
}
