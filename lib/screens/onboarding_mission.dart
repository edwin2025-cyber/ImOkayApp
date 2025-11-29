import 'package:flutter/material.dart';

class OnboardingMission extends StatelessWidget {
  const OnboardingMission({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF8F3),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.favorite,
                size: 50,
                color: Colors.pink.shade300,
              ),
              const SizedBox(height: 40),

              Text(
                "You’re doing your best.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "DmSans",
                  fontSize: 34,
                  fontWeight: FontWeight.w700,
                ),
              ),

              const SizedBox(height: 16),

              Text(
                "I’m here to help you slow down,\nbreathe, and understand yourself better.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "Inter",
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
