import 'package:flutter/material.dart';
import 'onboarding_name.dart';
import '../widgets/ui_components.dart';

class OnboardingWeight extends StatefulWidget {
  const OnboardingWeight({super.key});

  @override
  State<OnboardingWeight> createState() => _OnboardingWeightState();
}

class _OnboardingWeightState extends State<OnboardingWeight> {
  final Set<String> selected = {};

  final List<Map<String, dynamic>> weights = [
    {
      'label': 'Anxiety or stress',
      'icon': Icons.sentiment_neutral_outlined,
      'color': const Color(0xFFFFB366), // soft orange
    },
    {
      'label': 'School or expectations',
      'icon': Icons.school_outlined,
      'color': const Color(0xFF87CEEB), // baby blue
    },
    {
      'label': 'Relationships or friendships',
      'icon': Icons.people_outline,
      'color': const Color(0xFFFFB3C1), // soft pink
    },
    {
      'label': 'Family pressures',
      'icon': Icons.home_outlined,
      'color': const Color(0xFF98D8C8), // mint
    },
    {
      'label': 'Loneliness or isolation',
      'icon': Icons.error_outline,
      'color': const Color(0xFF6B9BD1), // soft blue
    },
    {
      'label': 'Something else',
      'icon': Icons.more_horiz,
      'color': const Color(0xFFB0B0B0), // neutral grey
    },
  ];

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
                "What's been\nweighing on you?",
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
                'Select all that apply',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 15,
                  color: Color(0xFF6E6E6E),
                ),
              ),
              const SizedBox(height: 32),
              Expanded(
                child: ListView.builder(
                  itemCount: weights.length,
                  itemBuilder: (context, index) {
                    final weight = weights[index];
                    final isSelected = selected.contains(weight['label']);

                    return SelectableCard(
                      label: weight['label'],
                      icon: weight['icon'],
                      accentColor: weight['color'],
                      selected: isSelected,
                      onTap: () {
                        setState(() {
                          if (isSelected) {
                            selected.remove(weight['label']);
                          } else {
                            selected.add(weight['label']);
                          }
                        });
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              PrimaryButton(
                label: 'Continue',
                onPressed: selected.isNotEmpty
                    ? () {
                        Navigator.of(context).push(
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    const OnboardingName(),
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
            ],
          ),
        ),
      ),
    );
  }
}
