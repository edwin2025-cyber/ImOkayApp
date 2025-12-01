import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/onboarding_data.dart';
import '../widgets/premium_widgets.dart';
import 'dashboard.dart';

class CreatorIntroScreen extends StatefulWidget {
  final String userName;

  const CreatorIntroScreen({super.key, required this.userName});

  @override
  State<CreatorIntroScreen> createState() => _CreatorIntroScreenState();
}

class _CreatorIntroScreenState extends State<CreatorIntroScreen> {
  bool _showLine1 = false;
  bool _showLine2 = false;
  bool _showParagraph = false;
  bool _showButton = false;

  @override
  void initState() {
    super.initState();
    _startTextReveal();
  }

  Future<void> _startTextReveal() async {
    // Line 1 appears immediately
    setState(() => _showLine1 = true);

    // Lines 2-3 appear together after 800ms
    await Future.delayed(const Duration(milliseconds: 800));
    if (!mounted) return;
    setState(() => _showLine2 = true);

    // Paragraph 1 appears after 1400ms
    await Future.delayed(const Duration(milliseconds: 1400));
    if (!mounted) return;
    setState(() => _showParagraph = true);

    // Button appears after 2400ms
    await Future.delayed(const Duration(milliseconds: 2400));
    if (!mounted) return;
    setState(() => _showButton = true);
  }

  Future<void> _handleContinue() async {
    HapticFeedback.lightImpact();
    
    // Mark onboarding as complete
    await OnboardingData.markComplete();

    if (!mounted) return;

    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const DashboardScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final offsetAnimation = Tween<Offset>(
            begin: const Offset(0, 0.05),
            end: Offset.zero,
          ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOut));

          return FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: offsetAnimation,
              child: child,
            ),
          );
        },
        transitionDuration: const Duration(milliseconds: 500),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            children: [
              SizedBox(height: height * 0.15),

              // Staggered text content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Line 1
                    AnimatedOpacity(
                      opacity: _showLine1 ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 600),
                      child: AnimatedSlide(
                        offset: _showLine1 ? Offset.zero : const Offset(0, -0.1),
                        duration: const Duration(milliseconds: 600),
                        curve: Curves.easeOut,
                        child: Text(
                          'Hi, ${widget.userName}. I\'m Edwin.',
                          style: theme.textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Lines 2-3
                    AnimatedOpacity(
                      opacity: _showLine2 ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 600),
                      child: AnimatedSlide(
                        offset: _showLine2 ? Offset.zero : const Offset(0, -0.1),
                        duration: const Duration(milliseconds: 600),
                        curve: Curves.easeOut,
                        child: Text(
                          'I built this app during a time when everything felt heavy in ways I didn\'t know how to explain.\nLate nights, quiet rooms, thoughts that wouldn\'t settle,\nI kept wishing there was a place that felt safe, calm, and warm…\nsomewhere I could just be, without pretending.',
                          style: theme.textTheme.bodyLarge,
                        ),
                      ),
                    ),

                    const SizedBox(height: 28),

                    // Paragraph 1
                    AnimatedOpacity(
                      opacity: _showParagraph ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 800),
                      child: AnimatedSlide(
                        offset: _showParagraph ? Offset.zero : const Offset(0, -0.1),
                        duration: const Duration(milliseconds: 800),
                        curve: Curves.easeOut,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'So I decided to create that place myself.\nAnd now you\'re here.',
                              style: theme.textTheme.bodyLarge,
                            ),
                            const SizedBox(height: 28),
                            Text(
                              'If you\'ve ever felt overwhelmed or alone with your thoughts,\nI hope this reminds you that you don\'t have to hold everything by yourself.',
                              style: theme.textTheme.bodyLarge,
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Final emphasized line
                    AnimatedOpacity(
                      opacity: _showButton ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 700),
                      child: AnimatedScale(
                        scale: _showButton ? 1.0 : 0.98,
                        duration: const Duration(milliseconds: 700),
                        curve: Curves.easeOutBack,
                        child: Text(
                          'You\'re welcome here — exactly as you are.',
                          style: theme.textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Button (appears last)
              AnimatedOpacity(
                opacity: _showButton ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 600),
                child: PremiumButton(
                  label: 'Continue',
                  onPressed: _showButton ? _handleContinue : null,
                ),
              ),

              SizedBox(height: height * 0.06),
            ],
          ),
        ),
      ),
    );
  }
}
