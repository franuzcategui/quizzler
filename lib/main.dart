import 'package:flutter/material.dart';
import 'package:quizzler/quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() {
  runApp(Quizzler());
}

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: QuizPage(),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scoreKeeper = [];

  QuizBrain quizBrain = QuizBrain();

  //Checks answers and generates

  void checkAnswer(bool userPickedAnswer, BuildContext context) {
    if (userPickedAnswer == quizBrain.getQuestionAnswer()) {
      scoreKeeper.add(Icon(
        Icons.check,
        color: Colors.green,
      ));
    } else {
      scoreKeeper.add(Icon(
        Icons.close,
        color: Colors.red,
      ));
    }

    if (quizBrain.isFinished()) {
      scoreKeeper.clear();
      quizBrain.clear();
      _onBasicAlertPressed(context);
    }
  }

  _onBasicAlertPressed(context) {
    Alert(
      context: context,
      title: "You are a Genius",
      desc: "Would be a cool thing to be told",
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 6,
            child: Container(
                alignment: AlignmentDirectional.center,
                child: Text(quizBrain.getQuestionText())),
          ),
          Expanded(
            flex: 1,
            child: ConstrainedBox(
              constraints: BoxConstraints.expand(),
              child: Card(
                color: Colors.green,
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      checkAnswer(true, context);
                      quizBrain.nextQuestion();
                    });
                  },
                  child: Text(
                    'True',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: ConstrainedBox(
              constraints: BoxConstraints.expand(),
              child: Card(
                color: Colors.red,
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      checkAnswer(false, context);
                      quizBrain.nextQuestion();
                    });
                  },
                  child: Text(
                    'False',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Row(
            children: scoreKeeper,
          )
        ],
      ),
    );
  }
}
