import 'package:flutter/material.dart';

class chemistry extends StatefulWidget {
  const chemistry({super.key});

  @override
  State<chemistry> createState() => chemistryState();
}

class chemistryState extends State<chemistry> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _animation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( backgroundColor:Color(0xFF132E35) ,),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFB2DFDB),
              Color(0xFFE0F7FA),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Chemistry Topics",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                ),
                const SizedBox(height: 30),

                SlideTransition(
                  position: _animation,
                  child: buildBox("Organic Chemistry"),
                ),
                const SizedBox(height: 20),
                SlideTransition(
                  position: _animation,
                  child: buildBox("Inorganic Chemistry"),
                ),
                const SizedBox(height: 20),
                SlideTransition(
                  position: _animation,
                  child: buildBox("Physical Chemistry"),
                ),
                const SizedBox(height: 20),
                SlideTransition(
                  position: _animation,
                  child: buildBox("Analytical Chemistry"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildBox(String title) {
    return Container(
      height: 80,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Center(
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.teal,
          ),
        ),
      ),
    );
  }
}