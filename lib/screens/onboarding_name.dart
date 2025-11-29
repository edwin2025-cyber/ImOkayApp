import 'package:flutter/material.dart';
import 'onboarding_age.dart';
import '../widgets/ui_components.dart';

class OnboardingName extends StatefulWidget {
  const OnboardingName({super.key});

  @override
  State<OnboardingName> createState() => _OnboardingNameState();
}

class _OnboardingNameState extends State<OnboardingName> {
  final TextEditingController _nameController = TextEditingController();
  bool _isValid = false;

  @override
  void initState() {
    super.initState();
    _nameController.addListener(() {
      setState(() {
        _isValid = _nameController.text.trim().isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              const Text(
                'What should I\ncall you?',
                style: TextStyle(
                  fontFamily: 'DM Sans',
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 32),
              TextField(
                controller: _nameController,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 16,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  hintText: 'Your first name',
                  hintStyle: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 16,
                    color: Color(0xFF6E6E6E),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Color(0xFFE4E4E4),
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Colors.black,
                      width: 1.5,
                    ),
                  ),
                ),
              ),
              const Spacer(),
              PrimaryButton(
                label: 'Continue',
                onPressed: _isValid
                    ? () {
                        Navigator.of(context).push(
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    OnboardingAge(
                                        name: _nameController.text.trim()),
                            transitionsBuilder:
                                (context, animation, secondaryAnimation, child) {
                              return FadeTransition(
                                opacity: animation,
                                child: child,
                              );
                            },
                            transitionDuration:
                                const Duration(milliseconds: 400),
                          ),
                        );
                      }
                    : null,
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
