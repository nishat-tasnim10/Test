import 'package:flutter/material.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int selectedOptionIndex = -1; // tracks selected option

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),

              // ✅ Header Row with Back button and Title
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.blue),
                    onPressed: () {
                      Navigator.pop(context); // go back
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
                  const SizedBox(width: 48), // balance spacing
                ],
              ),

              const SizedBox(height: 25),

              // ✅ Progress Bar
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: 3 / 8, // example progress
                  minHeight: 6,
                  backgroundColor: Colors.grey.shade300,
                  color: Colors.blue,
                ),
              ),

              const SizedBox(height: 8),

              const Center(
                child: Text(
                  "Question 3 of 8",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              const SizedBox(height: 25),

              // ✅ Question Container
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Given Question: What is the capital of France?",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Divider(height: 20),
                    SizedBox(height: 10),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // ✅ Options
              buildOption(0, "Paris"),
              const SizedBox(height: 15),
              buildOption(1, "London"),
              const SizedBox(height: 15),
              buildOption(2, "Berlin"),
              const SizedBox(height: 15),
              buildOption(3, "Rome"),

              const Spacer(),

              // ✅ Next Button
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
                    // Example: print selection
                    print(
                        "Selected Option: $selectedOptionIndex");

                    // TODO: Navigate to next question
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

  /// 🔹 Option Widget
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
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 12,
              backgroundColor: Colors.transparent,
              child: Icon(
                isSelected ? Icons.check_circle : Icons.circle_outlined,
                color: isSelected ? Colors.blue : Colors.grey,
                size: 22,
              ),
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