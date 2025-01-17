import 'package:flutter/material.dart';
import '../components/Reading/header_quiz.dart';
import '../components/Reading/progress_bar.dart';
import '../components/Reading/question_content.dart';
import '../components/Reading/answer_option.dart';
import '../components/custom_button.dart';
import '../components/Reading/feedback_popup.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ReadingQuizPage extends StatefulWidget {
  const ReadingQuizPage({super.key});

  @override
  _ReadingQuizPageState createState() => _ReadingQuizPageState();
}

class _ReadingQuizPageState extends State<ReadingQuizPage> {
  int currentQuestionIndex = 1;
  int selectedOption = -1;
  bool showFeedback = false;
  bool isAnswerCorrect = false;
  String? userId = "1";

  final List<Color> questionColors = [
    const Color(0xFFFFF8C6), // Default color (Yellow)
    const Color(0xFFFFF8C6),
    const Color(0xFFFFF8C6),
  ];

  List<int> answer = [-1, -1, -1];

  List<bool> questionsChecked = [
    false,
    false,
    false
  ]; // Track checked questions

  final List<Map<String, dynamic>> questions = [
    {
      "paragraph":
      "People made the earliest textiles for clothing and dwellings. Then textiles became a necessary article of commerce and trade among the peoples of the world. The trade grew and flourished - from China through India, over the Arabian desert to the ports of Egypt and Turkey, and across the Mediterranean Sea to Italy. Caravans took beautiful silk brocades, cotton calicoes, gauzes, and the fine linens to Europe. Local artisans learned how to make them.",
      "question": "The text as a whole tells us about ...",
      "options": [
        "the earliest textiles",
        "how textiles were made",
        "the machines for making textiles",
        "the development of the textile industry",
        "the textile industry after the Industrial Revolution"
      ],
      "correctIndex": 0
    },
    {
      "paragraph":
      "The invention of the printing press in the 15th century revolutionized the way information was shared and preserved. Before the invention, books were laboriously copied by hand, making them rare and expensive. With the printing press, books could be produced in large quantities, making them more accessible to the general public.",
      "question": "What is the main idea of the text?",
      "options": [
        "The invention of the printing press",
        "The cost of books in the past",
        "The laborious process of copying books",
        "The general public's access to books",
        "The preservation of information"
      ],
      "correctIndex": 0
    },
    {
      "paragraph":
      "Electricity is a form of energy that powers many of the devices and machines we use every day. It is generated in power plants and transmitted through wires to homes and businesses. Electricity has become essential in modern life, enabling everything from lighting and heating to communication and entertainment.",
      "question": "Which of the following best summarizes the text?",
      "options": [
        "Electricity's role in modern life",
        "The generation of electricity",
        "The transmission of electricity",
        "The use of electricity in communication",
        "The importance of power plants"
      ],
      "correctIndex": 0
    }
  ];

  Future<void> updateStatus() async {
    int progress = (calculateProgress() * 100).toInt();
    print(progress);
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8000/user/update_reading'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
          'user_id': userId,
          'reading_answered': answer,
          'progress': progress
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['status'] == 'Success') {
        // Navigate to the next page or show a success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Update Successful'),
          ),
        );
      }
    }
  }

  Future<void> loadSession() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
        userId = prefs.getString("user_id");
    });

    final response = await http.post(
      Uri.parse('http://10.0.2.2:8000/user/profile'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'user_id': userId}),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> parsedJson = jsonDecode(response.body);
      Map<String, dynamic> userInfo = parsedJson["user_info"];

      List<int> answered_q =
      userInfo["reading_answered"].whereType<int>().toList();
      print(answered_q);

      setState(() {
          answer = answered_q;
          currentQuestionIndex = getNum() - 1  < 1 ? 0 : getNum() - 1;
          if (answer[currentQuestionIndex] != -1) {
            selectedOption = answer[currentQuestionIndex];
            showFeedback = true;
            checkAnswer();
          }
          sessionAnswerCheck();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    loadSession();
  }

  void sessionAnswerCheck() {
    setState(() {
        for (int i = 0; i < answer.length; i++) {
          if (answer[i] != -1) {
            if (answer[i] != questions[i]["correctIndex"]) {
              questionColors[i] = const Color(0xFFFFB8B8); // Red
            } else {
              questionColors[i] = const Color(0xFF89E219); // Green
            }
            questionsChecked[i] = true;
          }
        }
    });

    print(questionColors);
  }

  void checkAnswer() {
    setState(() {
        showFeedback = true;
        isAnswerCorrect =
        selectedOption == questions[currentQuestionIndex]["correctIndex"];
        questionColors[currentQuestionIndex] = isAnswerCorrect
        ? const Color(0xFF89E219) // Green
        : const Color(0xFFFFB8B8); // Red
        questionsChecked[currentQuestionIndex] = true; // Mark question as checked
        answer[currentQuestionIndex] = selectedOption;
    });
  }

  int getNum() {
    // Always return to previous answered question
    for (int i = 0; i < answer.length; i++) {
      if (answer[i] == -1) {
        return i;
      }
    }
    return answer.length;
  }

  void continueQuiz() {
    if (questionsChecked.every((checked) => checked)) {
      Navigator.pop(context, 'true'); // Navigate to home if all checked
    } else if (currentQuestionIndex < questions.length - 1) {
      setState(() {
          currentQuestionIndex++;
          selectedOption = -1;
          showFeedback = false;
      });
    } else {
      int nextUnansweredIndex =
      questionsChecked.indexWhere((isChecked) => !isChecked);

      if (nextUnansweredIndex != -1) {
        setState(() {
            currentQuestionIndex = nextUnansweredIndex;
            selectedOption = -1;
            showFeedback = false;
        });
      }
    }
    updateStatus();
  }

  double calculateProgress() {
    int counter = 0;
    for (int i = 0; i < questionsChecked.length; i++) {
      if (questionsChecked[i]) {
        counter++;
      }
    }
    return counter / questions.length;
  }

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () async {
        print("HAI");
        Navigator.pop(context, true);
        return false;
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF7F7F7),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  // Header
                  const QuizHeader(
                    title: "Reading Quiz",
                    backgroundColor: Color(0xFF58CC02),
                  ),

                  // Progress Bar
                  const SizedBox(height: 20),
                  ProgressBar(progress: calculateProgress()),

                  // Question Numbers
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(questions.length, (index) {
                        return GestureDetector(
                          onTap: !questionsChecked[index] && !showFeedback
                          ? () {
                            setState(() {
                                currentQuestionIndex = index;
                                selectedOption = -1;
                            });
                          }
                          : null,
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 12),
                            decoration: BoxDecoration(
                              color: index == currentQuestionIndex
                              ? const Color(0xFFFFDE00) // Orange for active
                              : questionColors[index],
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              "${index + 1}",
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                    }),
                  ),

                  // Question Content
                  const SizedBox(height: 20),
                  QuestionContent(
                    paragraph: questions[currentQuestionIndex]["paragraph"],
                    question: questions[currentQuestionIndex]["question"],
                  ),

                  // Answer Options
                  const SizedBox(height: 20),
                  ...List.generate(
                    questions[currentQuestionIndex]["options"].length, (index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: AnswerOption(
                          optionLabel: String.fromCharCode(65 + index),
                          optionText: questions[currentQuestionIndex]["options"]
                          [index],
                          isSelected: selectedOption == index,
                          isCorrect: index ==
                          questions[currentQuestionIndex]["correctIndex"],
                          highlightCorrect: showFeedback,
                          onTap: () {
                            if (!showFeedback) {
                              setState(() {
                                  selectedOption = index;
                              });
                            }
                          },
                        ),
                      );
                  }),

                  const SizedBox(height: 20),

                  // Submit Button Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Skip Button
                      CustomButton(
                        text: "SKIP",
                        width: 120,
                        backgroundColor: Colors.white,
                        shadowColor: Colors.grey.withOpacity(0.6),
                        textColor: Colors.black,
                        onPressed: () {
                          setState(() {
                              currentQuestionIndex == answer.length - 1
                              ? answer.length - 1
                              : currentQuestionIndex++;
                              selectedOption = -1;
                              showFeedback = false;
                          });
                        },
                      ),

                      // Check/Continue Button
                      CustomButton(
                        text: showFeedback ? "CONTINUE" : "CHECK",
                        width: 120,
                        backgroundColor: const Color(0xFF58CC02),
                        shadowColor: const Color(0xFF41A000),
                        textColor: Colors.white,
                        onPressed: showFeedback ? continueQuiz : checkAnswer,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Feedback Pop-Up
            if (showFeedback)
            Align(
              alignment: Alignment.bottomCenter,
              child: FeedbackPopup(
                isCorrect: isAnswerCorrect,
                onContinue: continueQuiz,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
