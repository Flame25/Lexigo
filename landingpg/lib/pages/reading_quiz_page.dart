import 'package:flutter/material.dart';
import '../components/Reading/header_quiz.dart';
import '../components/Reading/progress_bar.dart';
import '../components/Reading/question_content.dart';
import '../components/Reading/answer_option.dart';
import '../components/custom_button.dart';
import '../components/Reading/feedback_popup.dart';

class ReadingQuizPage extends StatefulWidget {
  const ReadingQuizPage({super.key});

  @override
  _ReadingQuizPageState createState() => _ReadingQuizPageState();
}

class _ReadingQuizPageState extends State<ReadingQuizPage> {
  int selectedOption = -1;
  bool showFeedback = false;
  bool isAnswerCorrect = false;

  void checkAnswer() {
    setState(() {
      showFeedback = true;
      isAnswerCorrect = selectedOption == 0; // Jawaban benar adalah A (indeks 0)
    });
  }

  void continueQuiz() {
    setState(() {
      showFeedback = false;
      selectedOption = -1; // Reset jawaban
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                const ProgressBar(progress: 0.4),

                // Question Content
                const SizedBox(height: 20),
                const QuestionContent(
                  paragraph:
                  "People made the earliest textiles for clothing and dwellings. Then textiles became a necessary article of commerce and trade among the peoples of the world. The trade grew and flourished - from China through India, over the Arabian desert to the ports of Egypt and Turkey, and across the Mediterranean Sea to Italy. Caravans took beautiful silk brocades, cotton calicoes, gauzes, and the fine linens to Europe. Local artisans learned how to make them.",
                  question: "The text as a whole tells us about ...",
                ),

                // Answer Options
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: AnswerOption(
                    optionLabel: "A",
                    optionText: "the earliest textiles",
                    isSelected: selectedOption == 0,
                    isCorrect: true,
                    highlightCorrect: showFeedback,
                    onTap: () {
                      setState(() {
                        selectedOption = 0;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: AnswerOption(
                    optionLabel: "B",
                    optionText: "how textiles were made",
                    isSelected: selectedOption == 1,
                    isCorrect: false,
                    highlightCorrect: showFeedback,
                    onTap: () {
                      setState(() {
                        selectedOption = 1;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: AnswerOption(
                    optionLabel: "C",
                    optionText: "the machines for making textiles",
                    isSelected: selectedOption == 2,
                    isCorrect: false,
                    highlightCorrect: showFeedback,
                    onTap: () {
                      setState(() {
                        selectedOption = 2;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: AnswerOption(
                    optionLabel: "D",
                    optionText: "the development of the textile industry",
                    isSelected: selectedOption == 3,
                    isCorrect: false,
                    highlightCorrect: showFeedback,
                    onTap: () {
                      setState(() {
                        selectedOption = 3;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: AnswerOption(
                    optionLabel: "E",
                    optionText: "the textile industry after the Industrial Revolution",
                    isSelected: selectedOption == 4,
                    isCorrect: false,
                    highlightCorrect: showFeedback,
                    onTap: () {
                      setState(() {
                        selectedOption = 4;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 20),

                // Submit Button Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Tombol SKIP
                    CustomButton(
                      text: "SKIP",
                      width: 120,
                      backgroundColor: Colors.white,
                      shadowColor: Colors.grey.withOpacity(0.6),
                      textColor: Colors.black,
                      onPressed: () {
                        print("Skip clicked!");
                      },
                    ),

                    // Tombol CHECK
                    CustomButton(
                      text: "CHECK",
                      width: 120,
                      backgroundColor: const Color(0xFF58CC02),
                      shadowColor: const Color(0xFF41A000),
                      textColor: Colors.white,
                      onPressed: checkAnswer,
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
    );
  }
}
