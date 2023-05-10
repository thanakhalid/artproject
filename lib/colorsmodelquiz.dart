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
    text: 'two primary colors that produce white color are:',
    options: [
      const Option(text: 'Complementary colors', isCorrect: true),
      const Option(text: 'primary colors', isCorrect: false),
      const Option(text: 'original colord', isCorrect: false),
      const Option(text: 'white and yellow', isCorrect: false),
    ],
  ),
  Question(
    text: 'The human eye can perceive about___different colors:',
    options: [
      const Option(text: '100', isCorrect: false),
      const Option(text: '382000', isCorrect: true),
      const Option(text: '2', isCorrect: false),
      const Option(text: 'i am colorblind person', isCorrect: false),
    ],
  ),
  Question(
    text: 'which one is not a colors model:',
    options: [
      const Option(text: 'CMY', isCorrect: false),
      const Option(text: 'RGB', isCorrect: false),
      const Option(text: 'HLV', isCorrect: true),
      const Option(text: 'CIE', isCorrect: false),
    ],
  ),
  Question(
    text:
        '_______are obtained by adding a white pigment to the original color making it lighter.',
    options: [
      const Option(text: 'Shadows', isCorrect: false),
      const Option(text: 'Tones', isCorrect: false),
      const Option(text: 'Pure', isCorrect: false),
      const Option(text: 'Tints', isCorrect: true),
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
              image: AssetImage("images/gback.gif"), fit: BoxFit.cover),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Center(
                child: Text(
              'colors models quiz',
              style: TextStyle(
                fontSize: 40.0,
                color: Colors.white,
              ),
            )),
            SizedBox(
              height: 50.0,
            ),
            ElevatedButton(
              child: const Text(
                'start quiz',
                style: TextStyle(fontSize: 30.0),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QuestionWidget()),
                );
              },
            ),
            SizedBox(
              height: 50,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Go back!',
                style: TextStyle(fontSize: 30.0),
              ),
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
  int _Qno = 0;
  int _score = 0;
  bool _isLocked = false;
  void _resetq() {
    setState(() {
      _Qno = 0;
      _score = 0;
      _isLocked = false;
      for (int i = 0; i < questions.length; i++) {
        questions[i].isLocked = false;
      }
      ;
    });
  }

  late PageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: 0);
    _resetq();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
          height: double.maxFinite,
          width: double.maxFinite,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/gback.gif"), fit: BoxFit.cover),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                height: 32,
              ),
              Center(
                  child: Text(
                'Question $_Qno/ ${questions.length}',
                style: TextStyle(color: Colors.white, fontSize: 30.0),
              )),
              const Divider(
                thickness: 1,
                color: Colors.white,
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
          )),
    ));
  }

  Column bulidQ(Question question) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 32,
        ),
        Center(
          child: Card(
              color: Colors.white30,
              child: SizedBox(
                  height: 200,
                  width: 350,
                  child: Center(
                    child: Text(
                      question.text,
                      style: const TextStyle(fontSize:20, color: Colors.white),
                    ),
                  ))),
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
          if (_Qno < questions.length - 1) {
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
        child: Text(
          _Qno < questions.length - 1 ? 'Next Page' : 'see The Result',
          style: TextStyle(fontSize: 30.0),
        ));
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
            height: 80,
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            decoration: BoxDecoration(
              color: Colors.white38,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: color),
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(option.text,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      )),
                  getIconForOption(option, question),
                ],
              ),
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
  const ResultPage({Key? key, required this.score}) : super(key: key);
  final int score;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/gback.gif"), fit: BoxFit.cover),
        ),
        child: Center(
          child: Column(children: [
            SizedBox(
              height: 100,
            ),
            Text(
              'you got $score/${questions.length}',
              style: TextStyle(
                fontSize: 40.0,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              child: const Text(
                'go back',
                style: TextStyle(fontSize: 25.0),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyApp()),
                );
              },
            ),
          ]),
        ),
      ),
    );
  }
}
