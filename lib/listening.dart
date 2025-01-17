import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../components/Reading/progress_bar.dart';
import '../components/custom_button.dart';
import '../components/Reading/header_quiz.dart';
import '../components/Reading/feedback_popup.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ListeningQuizPage extends StatefulWidget {
  const ListeningQuizPage({super.key});

  @override
  _ListeningQuizPageState createState() => _ListeningQuizPageState();
}

class _ListeningQuizPageState extends State<ListeningQuizPage> {
  // Variabel untuk menyimpan urutan kata dari Group 2 yang dimasukkan ke Group 1
  List<String?> targetWords = List.filled(5, null); // Group 1
  List<String> answer = "My Mom Is Fourty Eight Years".trim().split(" ");
  List<String> draggableWords = [
    "Years",
    "Is",
    "My",
    "Mom",
    "Fourty Eight"
  ]; // Group 2
  String? userId = "1";
  bool isFeedback = false;
  bool mistake = false;

  void checkAns() {
    for (int i = 0; i < targetWords.length; i++) {
      if (targetWords[i] != answer[i]) {
        mistake = true;
      }
    }

    setState(() {
      isFeedback = true;
    });
  }

  Future<void> loadSession() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      userId = prefs.getString("user_id");
    });
  }

  Future<void> updateStatus() async {
    int progress = (1 * 100).toInt();
    print(progress);
    final response = await http.post(
      Uri.parse('https://lexigo-api.codebloop.my.id/user/update_listening'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'user_id': userId,
        'listening_answered': answer,
        'progress': 100,
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

  @override
  Widget build(BuildContext context) {
    final FlutterSoundPlayer _audioPlayer = FlutterSoundPlayer();
    bool _isPlaying = false;

    @override
    void initState() {
      super.initState();
      loadSession();
    }

    void _playAudio() async {
      try {
        await _audioPlayer.openPlayer();
        await _audioPlayer.startPlayer(
          fromURI:
              'assets/The-Audio.mp3', // You can use a URL or local file path
          whenFinished: () {
            setState(() {
              _isPlaying = false;
            });
          },
        );
        setState(() {
          _isPlaying = true;
        });
      } catch (e) {
        print("Error while playing audio: $e");
      }
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            const QuizHeader(
              title: "Listening Quiz",
              backgroundColor: Color(0xFFFFC200),
            ),

            // Progress Bar
            const SizedBox(height: 20),
            const ProgressBar(progress: 0.3),

            // Main Image
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'assets/speak.png',
                  fit: BoxFit.scaleDown,
                  height: 200,
                  width: 250,
                ),
              ),
            ),

            // Listen Carefully Button
            const SizedBox(height: 20),
            GestureDetector(
              onTap: _isPlaying ? null : _playAudio,
              child: Container(
                height: 45,
                width: 200,
                margin: const EdgeInsets.symmetric(horizontal: 50),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: const Color(0xFFE5E5E5),
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/speaker_icon.svg',
                      width: 24,
                      height: 24,
                      color: const Color(0xFF2196F3),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      "Listen carefully",
                      style: TextStyle(
                        color: Color(0xFF3C3C3C),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Group 1 - Target Boxes
            const SizedBox(height: 20),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 10,
              runSpacing: 10,
              children: List.generate(5, (index) {
                return DragTarget<String>(
                  builder: (context, candidateData, rejectedData) {
                    return GestureDetector(
                      onTap: () {
                        // Jika kotak di Group 1 diklik, kembalikan ke Group 2
                        if (targetWords[index] != null) {
                          setState(() {
                            draggableWords.add(targetWords[index]!);
                            targetWords[index] = null;
                          });
                        }
                      },
                      child: Container(
                        width: 100,
                        height: 50,
                        decoration: BoxDecoration(
                          color: targetWords[index] == null
                              ? Colors.white
                              : const Color(0xFFFFF6DC),
                          border: Border.all(color: const Color(0xFFE5E5E5)),
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            targetWords[index] ?? "",
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  onAccept: (data) {
                    setState(() {
                      targetWords[index] = data;
                      draggableWords.remove(data);
                    });
                  },
                );
              }),
            ),

            // Group 2 - Draggable Words
            const SizedBox(height: 20),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 10,
              runSpacing: 10,
              children: draggableWords.map((word) {
                return Draggable<String>(
                  data: word,
                  feedback: Material(
                    child: Container(
                      width: 100,
                      height: 50,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE5E5E5),
                        border: Border.all(color: const Color(0xFFE5E5E5)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          word,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  childWhenDragging: Container(
                    width: 100,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(child: Text("...")),
                  ),
                  child: Container(
                    width: 100,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: const Color(0xFFE5E5E5)),
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        word,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),

            // Submit Button Row
            const SizedBox(height: 20),
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
                    onPressed: () async {
                      print("Submitted words: $targetWords");
                      checkAns();
                      await updateStatus();
                    }),
              ],
            ),

            SizedBox(height: 30),
            if (isFeedback)
              Align(
                alignment: Alignment.bottomCenter,
                child: FeedbackPopup(
                  isCorrect: !mistake,
                  onContinue: () {
                    Navigator.pop(context, true);
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
