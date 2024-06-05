import 'package:flutter/material.dart';

class RTOQuestionsPage extends StatefulWidget {
  const RTOQuestionsPage({super.key});

  @override
  State<RTOQuestionsPage> createState() => _RTOQuestionsPageState();
}

class _RTOQuestionsPageState extends State<RTOQuestionsPage> {
  List<Icon> _scoreTracker = [];
  int _questionIndex = 0;
  int _totalScore = 0;
  bool answerWasSelected = false;
  bool endOfQuiz = false;
  bool correctAnswerSelected = false;

  void _questionAnswered(bool answerScore) {
    setState(() {
      answerWasSelected = true;

      if (answerScore) {
        _totalScore++;
        correctAnswerSelected = true;
      }

      _scoreTracker.add(
        answerScore
            ? const Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 20,
              )
            : const Icon(
                Icons.clear,
                color: Colors.red,
                size: 20,
              ),
      );
      if (_questionIndex + 1 == _questions.length) {
        endOfQuiz = true;
      }
    });
  }

  void _nextQuestion() {
    setState(() {
      _questionIndex++;
      answerWasSelected = false;
      correctAnswerSelected = false;
    });
    if (_questionIndex >= _questions.length) {
      _questionIndex = 0;
      _totalScore = 0;
      _scoreTracker = [];
      endOfQuiz = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    const backgroundColor = Color(0xFFE7ECEF);
    var size = MediaQuery.of(context).size;

    var width = size.width;
    String Correct = 'Correct Answer';
    String Wrong = 'Wrong Answer';

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("RTO Questions"),
      ),
      body: Center(
        child: Column(children: [
          const SizedBox(
            height: 5,
          ),
          Wrap(
            children: [
              const SizedBox(
                width: 15,
              ),
              if (_scoreTracker.isEmpty)
                const SizedBox(
                  height: 25.0,
                ),
              if (_scoreTracker.isNotEmpty) ..._scoreTracker,
              const SizedBox(width: 190),
            ],
          ),
          const SizedBox(height: 5),
          Container(
            height: 150,
            width: double.infinity,
            margin: const EdgeInsets.fromLTRB(12, 12, 12, 0),
            decoration: BoxDecoration(
                color: Colors.blue[200],
                borderRadius: BorderRadius.circular(12)),
            child: Center(
                child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Question- ${_questionIndex + 1}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 19,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  _questions[_questionIndex]['question'] as String,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 19,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            )),
          ),
          const SizedBox(
            height: 10,
          ),
          ...(_questions[_questionIndex]['answers']
                  as List<Map<String, Object>>)
              .map((answer) => Answer(
                    answerText: answer['answerText'] as String,
                    answerColor: answerWasSelected
                        ? (answer['score'] as bool ? Colors.green : Colors.red)
                        : Colors.white,
                    answerTap: () {
                      if (answerWasSelected) {
                        return;
                      }
                      _questionAnswered(answer['score'] as bool);
                    },
                  )),
          const SizedBox(
            height: 15,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(fixedSize: Size(width / 2, 40)),
            onPressed: () {
              if (!answerWasSelected) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  backgroundColor: Colors.blue,
                  content: Text(
                      textAlign: TextAlign.center,
                      'Please Select Your Answer First ',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold)),
                ));
                return;
              }
              _nextQuestion();
            },
            child: Text(
              endOfQuiz ? 'Restart Quiz' : 'Next Question',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(12)),
              height: 50,
              width: width - 30,
              child: Center(
                child: Row(
                  children: [
                    const SizedBox(
                      width: 65,
                    ),
                    const Text(
                      textAlign: TextAlign.center,
                      'Total Score :',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      textAlign: TextAlign.center,
                      ' ${_totalScore.toString()}/${_questions.length}',
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ],
                ),
              )),
          const SizedBox(
            height: 20,
          ),
          if (answerWasSelected && !endOfQuiz)
            Container(
                height: 50,
                width: width - 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: correctAnswerSelected ? Colors.green : Colors.red,
                ),
                child: Center(
                  child: Text(correctAnswerSelected ? Correct : Wrong,
                      style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold)),
                )),
          if (endOfQuiz)
            Container(
              height: 50,
              width: width - 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                  child: Text(
                _totalScore > 11
                    ? 'Congratulations! '
                    : 'Better Luck Next Time',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: correctAnswerSelected ? Colors.green : Colors.red),
              )),
            )
        ]),
      ),
    );
  }
}

class Answer extends StatelessWidget {
  final String answerText;
  final Color answerColor;
  final answerTap;
  const Answer(
      {super.key,
      required this.answerText,
      required this.answerColor,
      required this.answerTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: answerTap,
      child: Container(
        padding: const EdgeInsets.all(15.0),
        margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
        width: double.infinity,
        decoration: BoxDecoration(
          color: answerColor,
          border: Border.all(color: Colors.blue, width: 2),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          answerText,
          style: const TextStyle(
            fontSize: 15.0,
          ),
        ),
      ),
    );
  }
}

final _questions = [
  {
    'question':
        "Near a pedestrian crossing when the pedestrians are waiting to cross the road you should...",
    'answers': [
      {'answerText': 'Sound horn and proceed', 'score': false},
      {'answerText': 'Slow down,sound horn and pass', 'score': false},
      {
        'answerText':
            'Stop the vehicle and wait till the pedestrians cross the road and then proceed',
        'score': true
      },
    ],
  },
  {
    'question':
        'You are approaching a narrow bridge, another vehicle is about to enter the bridge from opposite side, you should',
    'answers': [
      {
        'answerText':
            'Wait till the other vehicle crosses	the bridge	and then proceed',
        'score': true
      },
      {
        'answerText': 'Put on   the head light and pass the bridge',
        'score': false
      },
      {
        'answerText':
            'Increase the speed and try to cross the bridge as fast as possible',
        'score': false
      },
    ],
  },
  {
    'question':
        'When a vehicle is involved in an accident causing injury to any person?',
    'answers': [
      {
        'answerText':
            'Take the vehicle to the nearest police station and report the accident',
        'score': false
      },
      {
        'answerText': 'Stop	the vehicle	and report to the police station',
        'score': false
      },
      {
        'answerText':
            'Take	all reasonable steps to secure medical attention to the	injured and report to the	nearest police station within	24',
        'score': true
      },
    ],
  },
  {
    'question': "On	a	road designated	as one way",
    'answers': [
      {'answerText': 'Parking	is prohibited', 'score': false},
      {'answerText': 'Overtaking is prohibited', 'score': false},
      {'answerText': 'Should	not drive	in reverse gear', 'score': true},
    ],
  },
  {
    'question': "You can overtake a vehicle in front",
    'answers': [
      {'answerText': 'From the right side of that vehicle', 'score': true},
      {'answerText': 'Through the left side', 'score': false},
      {
        'answerText': 'Through the left side, if the road is wide',
        'score': false
      },
    ],
  },
  {
    'question': "Validity	of learner’s licence",
    'answers': [
      {'answerText': 'Till	the driving licence	is', 'score': false},
      {'answerText': '6	months from the date of issue', 'score': true},
      {'answerText': '30 Days', 'score': false},
    ],
  },
  {
    'question': "In	a	road without footpath, the pedestrians",
    'answers': [
      {
        'answerText': 'Should walk on the left side of the road',
        'score': false
      },
      {
        'answerText': 'Should walk on the right side of the road',
        'score': true
      },
      {'answerText': 'May walk on either side of the road', 'score': false},
    ],
  },
  {
    'question':
        "Free	passage should be given to the following types of vehicles",
    'answers': [
      {'answerText': 'Small vehicles', 'score': false},
      {'answerText': 'Express, Super Express buses', 'score': false},
      {'answerText': 'Ambulance and fire service vehicles', 'score': true},
    ],
  },
  {
    'question': "Fog lamps are used",
    'answers': [
      {'answerText': 'During night', 'score': false},
      {'answerText': 'When there is fog', 'score': true},
      {
        'answerText': 'When	the opposite vehicle is not using dim light',
        'score': false
      },
    ],
  },
  {
    'question': "Zebra lines are meant for.",
    'answers': [
      {'answerText': 'stopping vehicle', 'score': false},
      {'answerText': 'for	giving preference to vehicle', 'score': false},
      {'answerText': 'pedestrians crossing', 'score': true},
    ],
  },
  {
    'question': "Red traffic light indicates.",
    'answers': [
      {'answerText': 'stop	the vehicle', 'score': true},
      {'answerText': 'vehicle	can proceed with caution', 'score': false},
      {'answerText': 'slow down', 'score': false},
    ],
  },
  {
    'question':
        "Where	the “Slippery road sign” is seen on the	road, the driver shall",
    'answers': [
      {'answerText': 'reduce speed by changing to lower gear', 'score': true},
      {'answerText': 'apply brake', 'score': false},
      {'answerText': 'proceed in the same speed', 'score': false},
    ],
  },
  {
    'question': "What	is	the Validity	of Pollution Under Control Certificate?",
    'answers': [
      {'answerText': '6 months', 'score': true},
      {'answerText': '1 Year', 'score': false},
      {'answerText': '2 Years', 'score': false},
    ],
  },
  {
    'question': "Overtaking when approaching a",
    'answers': [
      {'answerText': 'is permissible', 'score': false},
      {'answerText': 'not permissible', 'score': true},
      {'answerText': 'is permissible with care', 'score': false},
    ],
  },
  {
    'question': "Drunken driving is",
    'answers': [
      {'answerText': 'allowed	in private vehicles', 'score': false},
      {'answerText': 'allowed during night time', 'score': false},
      {'answerText': 'prohibited in all vehicles', 'score': true},
    ],
  },
];
