import 'package:flutter/material.dart';

void main() {
  runApp(const Quizzler());
}

class Question {
  String questionText;
  bool questionAnswer;

  Question({
    required this.questionText,
    required this.questionAnswer,
  });
}

List<Question> questionBank = [
  Question(
    questionText: 'Flutter được phát triển bởi Google.',
    questionAnswer: true,
  ),
  Question(
    questionText: 'Flutter chỉ chạy được trên Android.',
    questionAnswer: false,
  ),
  Question(
    questionText: 'Dart là ngôn ngữ được sử dụng với Flutter.',
    questionAnswer: true,
  ),
  Question(
    questionText: 'Flutter là một cơ sở dữ liệu.',
    questionAnswer: false,
  ),
];

class Quizzler extends StatefulWidget {
  const Quizzler({super.key});

  @override
  State<Quizzler> createState() => _QuizzlerState();
}

class _QuizzlerState extends State<Quizzler> {
  int questionNumber = 0;

  List<Icon> scoreKeeper = [];

  bool? selectedAnswer;

  void checkAnswer(bool userAnswer) {
    bool correctAnswer =
        questionBank[questionNumber].questionAnswer;

    setState(() {
      selectedAnswer = userAnswer;

      if (userAnswer == correctAnswer) {
        scoreKeeper.add(
          const Icon(
            Icons.check_circle,
            color: Colors.green,
            size: 24,
          ),
        );
      } else {
        scoreKeeper.add(
          const Icon(
            Icons.cancel,
            color: Colors.red,
            size: 24,
          ),
        );
      }
    });

    Future.delayed(const Duration(milliseconds: 500), () {
      if (!mounted) return;

      setState(() {
        if (questionNumber < questionBank.length - 1) {
          questionNumber++;
          selectedAnswer = null;
        } else {
          questionNumber = 0;
          scoreKeeper = [];
          selectedAnswer = null;
        }
      });
    });
  }

  Color getAnswerColor(bool answer) {
    if (selectedAnswer == null) {
      return Colors.white;
    }

    if (selectedAnswer == answer) {
      bool correctAnswer =
          questionBank[questionNumber].questionAnswer;

      if (answer == correctAnswer) {
        return Colors.green.shade100;
      } else {
        return Colors.red.shade100;
      }
    }

    return Colors.white;
  }

  Color getBorderColor(bool answer) {
    if (selectedAnswer == null) {
      return Colors.grey.shade300;
    }

    if (selectedAnswer == answer) {
      bool correctAnswer =
          questionBank[questionNumber].questionAnswer;

      if (answer == correctAnswer) {
        return Colors.green;
      } else {
        return Colors.red;
      }
    }

    return Colors.grey.shade300;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Arial',
      ),
      home: Scaffold(
        backgroundColor: const Color(0xFFF5F7FB),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'QUIZZLER',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF202A44),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Câu hỏi đúng hay sai',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Câu ${questionNumber + 1} / ${questionBank.length}',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF53627C),
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(25),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.06),
                                blurRadius: 15,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              const Icon(
                                Icons.quiz_outlined,
                                size: 45,
                                color: Color(0xFF536DFE),
                              ),
                              const SizedBox(height: 20),
                              Text(
                                questionBank[questionNumber]
                                    .questionText,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF202A44),
                                  height: 1.4,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 25),
                        GestureDetector(
                          onTap: selectedAnswer == null
                              ? () => checkAnswer(true)
                              : null,
                          child: AnimatedContainer(
                            duration:
                            const Duration(milliseconds: 200),
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                              vertical: 18,
                              horizontal: 20,
                            ),
                            decoration: BoxDecoration(
                              color: getAnswerColor(true),
                              borderRadius:
                              BorderRadius.circular(15),
                              border: Border.all(
                                color: getBorderColor(true),
                                width: 2,
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.check_circle_outline,
                                  color: selectedAnswer == true
                                      ? getBorderColor(true)
                                      : Colors.green,
                                  size: 28,
                                ),
                                const SizedBox(width: 15),
                                const Text(
                                  'ĐÚNG',
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF202A44),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        GestureDetector(
                          onTap: selectedAnswer == null
                              ? () => checkAnswer(false)
                              : null,
                          child: AnimatedContainer(
                            duration:
                            const Duration(milliseconds: 200),
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                              vertical: 18,
                              horizontal: 20,
                            ),
                            decoration: BoxDecoration(
                              color: getAnswerColor(false),
                              borderRadius:
                              BorderRadius.circular(15),
                              border: Border.all(
                                color: getBorderColor(false),
                                width: 2,
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.cancel_outlined,
                                  color: selectedAnswer == false
                                      ? getBorderColor(false)
                                      : Colors.red,
                                  size: 28,
                                ),
                                const SizedBox(width: 15),
                                const Text(
                                  'SAI',
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF202A44),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 15,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: scoreKeeper,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}