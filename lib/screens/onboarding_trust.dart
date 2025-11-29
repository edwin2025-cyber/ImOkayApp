import 'package:flutter/material.dart';
import 'onboarding_name.dart';

class OnboardingTrust extends StatefulWidget {
  const OnboardingTrust({super.key});

  @override
  State<OnboardingTrust> createState() => _OnboardingTrustState();
}

class _OnboardingTrustState extends State<OnboardingTrust>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.9, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 0.8, curve: Curves.easeOutCubic),
      ),
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
      backgroundColor: const Color(0xFFFFF0F3),
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                children: [
                  SizedBox(height: height * 0.18),

                  // Heartfelt icon
                  Icon(
                    Icons.favorite_rounded,
                    size: 70,
                    color: Color(0xFFFFB3C1),
                  ),

                  const SizedBox(height: 36),

                  Text(
                    "Thank you for being open with me today.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "DmSans",
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF2D2D2D),
                      height: 1.3,
                      letterSpacing: -0.5,
                    ),
                  ),

                  const SizedBox(height: 22),

                  Text(
                    "You're doing the best you can,\nand that's more than enough.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "Inter",
                      fontSize: 18,
                      height: 1.6,
                      color: Color(0xFF6A6A6A),
                      letterSpacing: 0.2,
                    ),
                  ),

                  const Spacer(),

                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  const OnboardingName(),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            return FadeTransition(
                                opacity: animation, child: child);
                          },
                          transitionDuration: const Duration(milliseconds: 500),
                        ),
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      decoration: BoxDecoration(
                        color: Color(0xFF2D2D2D),
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
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
                            letterSpacing: 0.3,
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: height * 0.06),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
