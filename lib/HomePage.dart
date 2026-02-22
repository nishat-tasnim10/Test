import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'PomodoroPage.dart';


class AppColors {
  // static const bg       =  Color(0xFF132E35);
  static const bg       = Color(0xFF9BA8AB);
  static const darkTeal = Color(0xFF132E35);
  static const midTeal  = Color(0xFF1F4B4F);
  static const peach    = Color(0xFFFED7A5);
  static const grayBlue = Color(0xFF9BA8AB);
}


class _Feature {
  final String label;
  final IconData icon;
  final Color bg, fg;
  final Widget page;
  const _Feature(this.label, this.icon, this.bg, this.fg,  this.page);
}



final _features = [
  _Feature('Courses',  Icons.menu_book_rounded,   Color(0xFF132E35), AppColors.grayBlue, PomodoroPage()),
  _Feature('Quiz',     Icons.quiz_rounded,         Color(0xFF1F4B4F), Color(0xFFFED7A5), PomodoroPage()),
  _Feature('Pomodoro', Icons.timer_rounded,        Color(0xFF9BA8AB), Color(0xFF132E35), PomodoroPage()),
  _Feature('Progress', Icons.bar_chart_rounded,    Color(0xFFFED7A5), Color(0xFF132E35), PomodoroPage()),
];

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _searchCtrl = TextEditingController();
  bool _searchFocused = false;

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  void _navigate(Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => page));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        backgroundColor: AppColors.darkTeal,title: Text("Home",style: TextStyle(color: AppColors.peach),),
       
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.peach, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: AppColors.midTeal, height: 1),
        ),
      ),
      body: Stack(
        children: [
          const _BgBlobs(),
          SafeArea(
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(child: _buildHeader()),
                SliverToBoxAdapter(child: _buildQuoteCard()),
                SliverToBoxAdapter(child: _buildSearchBar()),
                SliverToBoxAdapter(child: _buildSectionLabel('Your Features')),
                SliverToBoxAdapter(child: _buildFeatureGrid()),
                const SliverToBoxAdapter(child: SizedBox(height: 40)),
              ],
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 28, 24, 0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Container(
                    width: 8, height: 8,
                    decoration: BoxDecoration(
                      color: AppColors.peach,
                      shape: BoxShape.circle,
                      boxShadow: [BoxShadow(color: AppColors.peach.withOpacity(0.6), blurRadius: 8)],
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text('GOOD MORNING',
                      style: TextStyle(color: AppColors.darkTeal, fontSize: 18,
                          letterSpacing: 3, fontWeight: FontWeight.w600)),
                ]),
                const SizedBox(height: 8),
                RichText(
                  text: const TextSpan(children: [
                    TextSpan(
                      text: 'Welcome\n',
                      style: TextStyle(color: Colors.white, fontSize: 36,
                          fontWeight: FontWeight.w700, height: 1.1),
                    ),
                    TextSpan(
                      text: 'back, Student',
                      style: TextStyle(color: AppColors.darkTeal, fontSize: 36,
                          fontWeight: FontWeight.w700, height: 1.1, letterSpacing: -1),
                    ),
                  ]),
                ),
              ],
            ),
          ),
          Container(
            width: 56, height: 56,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                begin: Alignment.topLeft, end: Alignment.bottomRight,
                colors: [AppColors.midTeal, AppColors.darkTeal],
              ),
              border: Border.all(color: AppColors.peach.withOpacity(0.45), width: 1.5),
              boxShadow: [BoxShadow(color: AppColors.peach.withOpacity(0.90), blurRadius: 20, spreadRadius: 2)],
            ),
            child: const Icon(Icons.person_rounded, color: AppColors.peach, size: 30),
          ),
        ],
      ),
    );
  }


  Widget _buildQuoteCard() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 22, 24, 0),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: LinearGradient(
            begin: Alignment.topLeft, end: Alignment.bottomRight,
            colors: [AppColors.midTeal.withOpacity(0.8), AppColors.darkTeal.withOpacity(0.9)],
          ),
          border: Border.all(color: AppColors.peach.withOpacity(0.12), width: 1),
          boxShadow: [BoxShadow(color: AppColors.midTeal.withOpacity(0.3), blurRadius: 24, offset: const Offset(0, 8))],
        ),
        child: Row(children: [
          Container(
            width: 42, height: 42,
            decoration: BoxDecoration(
              color: AppColors.peach.withOpacity(0.1),
              borderRadius: BorderRadius.circular(13),
            ),
            child: const Center(child: Text('*', style: TextStyle(fontSize: 20, color: AppColors.peach))),
          ),
          const SizedBox(width: 14),
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '"The secret of getting ahead is getting started!"',
                style: TextStyle(color: Colors.white, fontSize: 23,
                    fontStyle: FontStyle.normal, height: 1),
              ),
              const SizedBox(height: 4),
            ],
          )),
        ]),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
      child: Focus(
        onFocusChange: (f) => setState(() => _searchFocused = f),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: 56,
          decoration: BoxDecoration(
            color: AppColors.midTeal.withOpacity(0.6),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: _searchFocused
                  ? AppColors.peach.withOpacity(0.5)
                  : AppColors.grayBlue.withOpacity(0.15),
              width: 1.5,
            ),
            boxShadow: _searchFocused
                ? [BoxShadow(color: AppColors.peach.withOpacity(0.1), blurRadius: 20)]
                : [],
          ),
          child: TextField(
            controller: _searchCtrl,
            style: const TextStyle(color: Color(0xFF132E35), fontSize: 15),
            decoration: InputDecoration(
              hintText: 'Search .........',
              hintStyle: TextStyle(color: AppColors.darkTeal.withOpacity(0.55), fontSize: 14),
              prefixIcon: Padding(
                padding: const EdgeInsets.only(left: 16, right: 10),
                child: Icon(Icons.search_rounded,
                    color: _searchFocused ? AppColors.peach : AppColors.darkTeal, size: 22),
              ),
              prefixIconConstraints: const BoxConstraints(),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 17),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionLabel(String text) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 28, 24, 14),
      child: Row(children: [
        Container(
          width: 3, height: 14,
          decoration: BoxDecoration(
            color: AppColors.peach,
            borderRadius: BorderRadius.circular(4),
            boxShadow: [BoxShadow(color: AppColors.peach.withOpacity(0.5), blurRadius: 6)],
          ),
        ),
        const SizedBox(width: 10),
        Text(text.toUpperCase(),
            style: const TextStyle(color: AppColors.darkTeal, fontSize: 18,
                letterSpacing: 2.5, fontWeight: FontWeight.w700)),
      ]),
    );
  }


  Widget _buildFeatureGrid() {
    final cardW = (MediaQuery.of(context).size.width - 48 - 20) / 3;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          // Row 1: Courses + Quiz
          Row(mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(2, (i) => Padding(
              padding: EdgeInsets.only(right: i == 0 ? 10 : 0),
              child: SizedBox(
                width: cardW,
                child: _FeatureCard(
                  feature: _features[i],
                  onTap: () => _navigate(_features[i].page),
                ),
              ),
            )),
          ),
          const SizedBox(height: 10),
          // Row 2: Pomodoro + Progress
          Row(mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(2, (i) => Padding(
              padding: EdgeInsets.only(right: i == 0 ? 10 : 0),
              child: SizedBox(
                width: cardW,
                child: _FeatureCard(
                  feature: _features[2 + i],
                  onTap: () => _navigate(_features[2 + i].page),
                ),
              ),
            )),
          ),
        ],
      ),
    );
  }
}

class _FeatureCard extends StatefulWidget {
  final _Feature feature;
  final VoidCallback onTap;
  const _FeatureCard({required this.feature, required this.onTap});
  @override
  State<_FeatureCard> createState() => _FeatureCardState();
}

class _FeatureCardState extends State<_FeatureCard> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final f = widget.feature;
    return GestureDetector(
      onTapDown: (_) { HapticFeedback.lightImpact(); setState(() => _pressed = true); },
      onTapUp: (_) { setState(() => _pressed = false); widget.onTap(); },
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedScale(
        scale: _pressed ? 0.94 : 1.0,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOut,
        child: Container(
          height: 118,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            gradient: LinearGradient(
              begin: Alignment.topLeft, end: Alignment.bottomRight,
              colors: [f.bg, Color.lerp(f.bg, Colors.black, 0.18)!],
            ),
            boxShadow: [
              BoxShadow(color: f.bg.withOpacity(0.45), blurRadius: 20, offset: const Offset(0, 8), spreadRadius: -4),
              BoxShadow(color: Colors.black.withOpacity(0.25), blurRadius: 10, offset: const Offset(0, 4)),
            ],
          ),
          padding: const EdgeInsets.fromLTRB(13, 16, 13, 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 42, height: 42,
                decoration: BoxDecoration(
                  color: f.fg.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Icon(f.icon, color: f.fg, size: 22),
              ),
              const Spacer(),
              Text(f.label,
                  style: TextStyle(color: f.fg, fontSize: 12.5,
                      fontWeight: FontWeight.w800, letterSpacing: -0.2)),
              const SizedBox(height: 3),
            ],
          ),
        ),
      ),
    );
  }
}

class _BgBlobs extends StatelessWidget {
  const _BgBlobs();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(children: [
      Positioned(
        top: -80, right: -60,
        child: Container(
          width: 260, height: 260,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(colors: [AppColors.midTeal.withOpacity(0.45), Colors.transparent]),
          ),
        ),
      ),
      Positioned(
        bottom: 80, left: -80,
        child: Container(
          width: 300, height: 300,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(colors: [AppColors.peach.withOpacity(0.07), Colors.transparent]),
          ),
        ),
      ),
      Positioned(
        top: size.height * 0.38, left: size.width * 0.3,
        child: Container(
          width: 180, height: 180,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(colors: [AppColors.grayBlue.withOpacity(0.07), Colors.transparent]),
          ),
        ),
      ),
    ]);
  }
}