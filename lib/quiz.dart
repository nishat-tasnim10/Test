import 'package:flutter/material.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int selectedOptionIndex = -1;
  int currentQuestionIndex = 0;

  
  List<Map<String, dynamic>> questions = [
    {
      "question": "What is the capital of France?",
      "options": ["Paris", "London", "Berlin", "Rome"],
      "answer": 0,
    },
    {
      "question": "2 + 2 = ?",
      "options": ["3", "4", "5", "6"],
      "answer": 1,
    },
    {
      "question": "Which is a programming language?",
      "options": ["HTML", "CSS", "Python", "Photoshop"],
      "answer": 2,
    },
  ];

  @override
  Widget build(BuildContext context) {
    var currentQuestion = questions[currentQuestionIndex];

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),

              // 🔹 Header
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.blue),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  const Expanded(
                    child: Center(
                      child: Text(
                        "Quiz",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 48),
                ],
              ),

              const SizedBox(height: 25),

            
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value:
                  (currentQuestionIndex + 1) / questions.length, // FIXED
                  minHeight: 6,
                  backgroundColor: Colors.teal.shade300,
                  color: Colors.blue,
                ),
              ),

              const SizedBox(height: 8),

              Center(
                child: Text(
                  "Question ${currentQuestionIndex + 1} of ${questions.length}",
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              const SizedBox(height: 25),

          
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.teal,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  currentQuestion["question"], // FIXED
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 25),

              // 🔹 Dynamic Options
              ...List.generate(
                currentQuestion["options"].length,
                    (index) {
                  return Column(
                    children: [
                      buildOption(
                        index,
                        currentQuestion["options"][index],
                      ),
                      const SizedBox(height: 15),
                    ],
                  );
                },
              ),

              const Spacer(),

              // 🔹 Next Button
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: selectedOptionIndex == -1
                      ? null
                      : () {
                    if (currentQuestionIndex <
                        questions.length - 1) {
                      setState(() {
                        currentQuestionIndex++;
                        selectedOptionIndex = -1; // reset
                      });
                    } else {
                      // ✅ Quiz finished
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: const Text("Finished"),
                          content:
                          const Text("You completed the quiz!"),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                              child: const Text("OK"),
                            )
                          ],
                        ),
                      );
                    }
                  },
                  child: const Text(
                    "Next",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // 🔹 Option Widget
  Widget buildOption(int index, String text) {
    bool isSelected = selectedOptionIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedOptionIndex = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white, // FIXED (better UI)
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              isSelected
                  ? Icons.check_circle
                  : Icons.circle_outlined,
              color: isSelected ? Colors.blue : Colors.grey,
            ),
            const SizedBox(width: 10),
            Text(
              text,
              style: TextStyle(
                fontSize: 16,
                color: isSelected ? Colors.blue : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
