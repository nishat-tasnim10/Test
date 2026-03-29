import 'package:flutter/material.dart';

class physics extends StatefulWidget {
  const physics({super.key});

  @override
  State<physics> createState() => physicsState();
}

class physicsState extends State<physics>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late List<Animation<Offset>> _animations;

  final List<String> topics = [
    "Mechanics",
    "Electromagnetism",
    "Optics",
    "Thermodynamics",
  ];

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    // Staggered animation like Biology & Math
    _animations = List.generate(topics.length, (index) {
      final start = index * 0.1;
      final end = start + 0.5;

      return Tween<Offset>(
        begin: const Offset(0, 1),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(start, end, curve: Curves.easeOut),
        ),
      );
    });

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
      appBar: AppBar(
        title: const Text("Physics"),
        backgroundColor: const Color(0xFF132E35),
      ),
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
            padding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Physics Topics",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                ),
                const SizedBox(height: 30),

                /// Animated Buttons
                ...List.generate(topics.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: SlideTransition(
                      position: _animations[index],
                      child: _PhysicsButton(title: topics[index]),
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PhysicsButton extends StatefulWidget {
  final String title;

  const _PhysicsButton({required this.title});

  @override
  State<_PhysicsButton> createState() => _PhysicsButtonState();
}

class _PhysicsButtonState extends State<_PhysicsButton> {
  bool isHovering = false;
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => isHovering = true),
      onExit: (_) => setState(() => isHovering = false),
      child: GestureDetector(
        onTapDown: (_) => setState(() => isPressed = true),
        onTapUp: (_) => setState(() => isPressed = false),
        onTapCancel: () => setState(() => isPressed = false),
        onTap: () {
          print("${widget.title} clicked");
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          height: 80,
          width: double.infinity,
          transform: Matrix4.identity()..scale(isPressed ? 0.97 : 1.0),
          decoration: BoxDecoration(
            color: isHovering
                ? const Color(0xFF004D40)
                : Colors.white,
            borderRadius: BorderRadius.circular(20),

            // Border glow
            border: Border.all(
              color: isHovering ? Colors.tealAccent : Colors.transparent,
              width: 2,
            ),

            // Shadow
            boxShadow: [
              BoxShadow(
                color:
                Colors.black.withOpacity(isHovering ? 0.35 : 0.1),
                blurRadius: isHovering ? 20 : 8,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Center(
            child: Text(
              widget.title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: isHovering ? Colors.white : Colors.teal,
              ),
            ),
          ),
        ),
      ),
    );
  }
}