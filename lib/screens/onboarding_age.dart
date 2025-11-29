import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/ui_components.dart';

class OnboardingAge extends StatefulWidget {
  final String name;

  const OnboardingAge({super.key, required this.name});

  @override
  State<OnboardingAge> createState() => _OnboardingAgeState();
}

class _OnboardingAgeState extends State<OnboardingAge> {
  final TextEditingController _ageController = TextEditingController();
  bool _isValid = false;

  @override
  void initState() {
    super.initState();
    _ageController.addListener(() {
      final age = int.tryParse(_ageController.text.trim());
      setState(() {
        _isValid = age != null && age >= 13 && age <= 120;
      });
    });
  }

  @override
  void dispose() {
    _ageController.dispose();
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
              Text(
                'Nice to meet you, ${widget.name}.',
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF6E6E6E),
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'How old are you?',
                style: TextStyle(
                  fontFamily: 'DM Sans',
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'This helps personalize your experience.',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 14,
                  color: Color(0xFF6E6E6E),
                ),
              ),
              const SizedBox(height: 32),
              TextField(
                controller: _ageController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(3),
                ],
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 16,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  hintText: 'Your age',
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
                label: 'Get Started',
                onPressed: _isValid
                    ? () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Welcome, ${widget.name}!',
                              style: const TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                            backgroundColor: Colors.black,
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
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
