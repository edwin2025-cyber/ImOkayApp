import 'package:flutter/material.dart';
import 'onboarding_weight.dart';

class OnboardingMood extends StatefulWidget {
  const OnboardingMood({super.key});

  @override
  State<OnboardingMood> createState() => _OnboardingMoodState();
}

class _OnboardingMoodState extends State<OnboardingMood> {
  String? selectedMood;

  final List<Map<String, dynamic>> moods = [
    {
      "label": "Calm",
      "icon": Icons.spa_rounded,
      "highlight": "I'm glad you're feeling some peace.",
      "color": Color(0xFFB8E0D2)
    },
    {
      "label": "Overthinking",
      "icon": Icons.cloud_rounded,
      "highlight": "Your mind feels busy. Thanks for being honest.",
      "color": Color(0xFFCBB8FF)
    },
    {
      "label": "Happy",
      "icon": Icons.wb_sunny_rounded,
      "highlight": "That's beautiful to hear.",
      "color": Color(0xFFFFE8A3)
    },
    {
      "label": "Stressed",
      "icon": Icons.error_outline_rounded,
      "highlight": "I’m here with you. You’re not alone.",
      "color": Color(0xFFFFC5C0)
    },
    {
      "label": "Not sure",
      "icon": Icons.help_outline_rounded,
      "highlight": "It’s okay to feel uncertain.",
      "color": Color(0xFFD9D9D9)
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const SizedBox(height: 40),

              // Soft heart icon
              Center(
                child: Icon(
                  Icons.favorite,
                  size: 38,
                  color: Colors.pink.shade300,
                ),
              ),

              const SizedBox(height: 30),

              Text(
                "Let’s check in for a moment.",
                style: TextStyle(
                  fontFamily: "DmSans",
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),

              const SizedBox(height: 6),

              Text(
                "How are you feeling right now?",
                style: TextStyle(
                  fontFamily: "Inter",
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),

              const SizedBox(height: 26),

              Expanded(
                child: ListView.builder(
                  itemCount: moods.length,
                  itemBuilder: (context, index) {
                    final mood = moods[index];
                    final bool isSelected = selectedMood == mood["label"];

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedMood = mood["label"];
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        margin: const EdgeInsets.only(bottom: 14),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(22),
                          border: Border.all(
                            color: isSelected
                                ? Color(0xFFFFB3C1)
                                : Colors.grey.shade200,
                            width: isSelected ? 2.5 : 1,
                          ),
                          boxShadow: isSelected
                              ? [
                                  BoxShadow(
                                    color: mood["color"].withOpacity(0.35),
                                    blurRadius: 18,
                                    offset: const Offset(0, 6),
                                  ),
                                ]
                              : [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.04),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: mood["color"].withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Icon(
                                    mood["icon"],
                                    size: 24,
                                    color: mood["color"],
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Text(
                                    mood["label"],
                                    style: TextStyle(
                                      fontFamily: "Inter",
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF2D2D2D),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            if (isSelected) ...[
                              const SizedBox(height: 14),
                              Text(
                                mood["message"],
                                style: TextStyle(
                                  fontFamily: "Inter",
                                  fontSize: 14,
                                  color: Color(0xFF6A6A6A),
                                  fontStyle: FontStyle.italic,
                                  height: 1.4,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 12),

              GestureDetector(
                onTap: selectedMood == null
                    ? null
                    : () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    const OnboardingWeight(),
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              return FadeTransition(
                                  opacity: animation, child: child);
                            },
                            transitionDuration:
                                const Duration(milliseconds: 500),
                          ),
                        );
                      },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  decoration: BoxDecoration(
                    color: selectedMood == null
                        ? Colors.black.withOpacity(0.15)
                        : Color(0xFF2D2D2D),
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: selectedMood == null
                        ? []
                        : [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.08),
                              blurRadius: 16,
                              offset: const Offset(0, 4),
                            ),
                          ],
                  ),
                  child: Center(
                    child: Text(
                      "Continue",
                      style: TextStyle(
                        fontFamily: "Inter",
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 28),
            ],
          ),
        ),
      ),
    );
  }
}
