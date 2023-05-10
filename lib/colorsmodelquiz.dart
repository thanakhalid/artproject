import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:project2/main.dart';

class Question {
  final String text;
  final List<Option> options;
  bool isLocked;
  Option? selectedOption;

  Question(
      {required this.text,
      this.isLocked = false,
      required this.options,
      this.selectedOption});
}

class Option {
  final String text;
  final bool isCorrect;

  const Option({
    required this.text,
    required this.isCorrect,
  });
}

final questions = [
  Question(
    text: 'q1',
    options: [
      const Option(text: 'yes', isCorrect: true),
      const Option(text: 'no', isCorrect: false),
      const Option(text: 'no', isCorrect: false),
      const Option(text: 'no', isCorrect: false),
    ],
  ),
  Question(
    text: 'q2',
    options: [
      const Option(text: 'no', isCorrect: false),
      const Option(text: 'yes', isCorrect: true),
      const Option(text: 'no', isCorrect: false),
      const Option(text: 'no', isCorrect: false),
    ],
  ),
  Question(
    text: 'q3',
    options: [
      const Option(text: 'no', isCorrect: false),
      const Option(text: 'no', isCorrect: false),
      const Option(text: 'yes', isCorrect: true),
      const Option(text: 'no', isCorrect: false),
    ],
  ),
  Question(
    text: 'q4',
    options: [
      const Option(text: 'no', isCorrect: false),
      const Option(text: 'no', isCorrect: false),
      const Option(text: 'no', isCorrect: false),
      const Option(text: 'yes', isCorrect: true),
    ],
  ),
];

class Colorsmodel extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/colors.jpg"), fit: BoxFit.cover),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Card(
              color: Colors.white60,
              margin: EdgeInsets.all(10),
              child: SizedBox(
                width: 300,
                height: 100,
                child: Center(
                    child: Text(
                  'colors models quiz',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                )),
              ),
            ),
            ElevatedButton(
              child: const Text('start quiz'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QuestionWidget()),
                );
              },
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Go back!'),
            ),
          ],
        ),
      ),
    ));
  }
}

class QuestionWidget extends StatefulWidget {
  const QuestionWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<QuestionWidget> createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  int _Qno = 1;
  int _score = 0;
  bool _isLocked = false;
  void _resetq() {
    setState(() {
      _Qno = 0;
      _score = 0;
      _isLocked = false;
    });
  }

  late PageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
            height: 32,
          ),
          Text('Question $_Qno/ ${questions.length}'),
          const Divider(
            thickness: 1,
            color: Colors.grey,
          ),
          Expanded(
              child: PageView.builder(
            itemCount: questions.length,
            controller: _controller,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final _question = questions[index];
              return bulidQ(_question);
            },
          )),
          _isLocked ? bulidElevatedButton() : const SizedBox.shrink(),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    ));
  }

  Column bulidQ(Question question) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 32,
        ),
        Text(
          question.text,
          style: const TextStyle(fontSize: 25),
        ),
        const SizedBox(
          height: 32,
        ),
        Expanded(
            child: OptionWidget(
          question: question,
          onClickOption: (option) {
            if (question.isLocked) {
              return;
            } else {
              setState(() {
                question.isLocked = true;
                question.selectedOption = option;
              });
              _isLocked = question.isLocked;
              if (question.selectedOption!.isCorrect) {
                _score++;
              }
            }
          },
        ))
      ],
    );
  }

  ElevatedButton bulidElevatedButton() {
    return ElevatedButton(
        onPressed: () {
          if (_Qno < questions.length) {
            _controller.nextPage(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInExpo,
            );
            setState(() {
              _Qno++;
              _isLocked = false;
            });
          } else {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => ResultPage(
                          score: _score,
                        )));
          }
        },
        child: Text(_Qno < questions.length ? 'Next Page' : 'see The Result'));
  }
}

class OptionWidget extends StatelessWidget {
  final Question question;
  final ValueChanged<Option> onClickOption;

  const OptionWidget({
    Key? key,
    required this.question,
    required this.onClickOption,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Column(
          children: question.options
              .map((option) => bulidOption(context, option))
              .toList(),
        ),
      );

  Widget bulidOption(BuildContext, Option option) {
    final color = getColorForOption(option, question);
    return GestureDetector(
        onTap: () => onClickOption(option),
        child: Container(
            height: 50,
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: color),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  option.text,
                  style: const TextStyle(fontSize: 20),
                ),
                getIconForOption(option, question),
              ],
            )));
  }

  Color getColorForOption(Option option, Question question) {
    final isSelected = option == question.selectedOption;
    if (question.isLocked) {
      if (isSelected) {
        return option.isCorrect ? Colors.green : Colors.red;
      } else if (option.isCorrect) {
        return Colors.green;
      }
    }
    return Colors.grey;
  }

  Widget getIconForOption(Option option, Question question) {
    final isSelected = option == question.selectedOption;
    if (question.isLocked) {
      if (isSelected) {
        return option.isCorrect
            ? const Icon(
                Icons.check_circle,
                color: Colors.green,
              )
            : const Icon(
                Icons.cancel,
                color: Colors.red,
              );
      } else if (option.isCorrect) {
        return const Icon(
          Icons.check_circle,
          color: Colors.green,
        );
      }
    }
    return const SizedBox.shrink();
  }
}

class ResultPage extends StatelessWidget {
  const ResultPage({Key? key, required this.score})
      : super(key: key);
  final int score;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(children: [
          SizedBox(
            height: 100,
          ),
          Text('you got $score/${questions.length}'),
          ElevatedButton(
            child: const Text('go back'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyApp()),
              );
            },
          ),
        ]),
      ),
    );
  }
}
