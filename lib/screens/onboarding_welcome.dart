import 'package:flutter/material.dart';
import 'onboarding_feeling.dart';
import '../widgets/ui_components.dart';

class OnboardingWelcome extends StatefulWidget {
  const OnboardingWelcome({super.key});

  @override
  State<OnboardingWelcome> createState() => _OnboardingWelcomeState();
}

class _OnboardingWelcomeState extends State<OnboardingWelcome>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
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
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                children: [
                  SizedBox(height: height * 0.2),

                  // Clean greeting
                  Text(
                    "Hi, I'm glad you're here.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "DmSans",
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                      height: 1.3,
                      letterSpacing: -0.5,
                    ),
                  ),

                  const SizedBox(height: 16),

                  Text(
                    "Let's take this one step at a time.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "Inter",
                      fontSize: 17,
                      height: 1.5,
                      color: Color(0xFF6E6E6E),
                    ),
                  ),

                  const Spacer(),

                  // Black rounded button
                  PrimaryButton(
                    label: 'Begin',
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  const OnboardingFeeling(),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            return FadeTransition(
                                opacity: animation, child: child);
                          },
                          transitionDuration: const Duration(milliseconds: 400),
                        ),
                      );
                    },
                  ),

                  SizedBox(height: height * 0.08),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
