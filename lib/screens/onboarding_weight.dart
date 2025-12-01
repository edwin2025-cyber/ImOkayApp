import 'package:flutter/material.dart';
import 'sign_up_options.dart';
import '../widgets/premium_widgets.dart';
import '../models/onboarding_data.dart';

class OnboardingWeight extends StatefulWidget {
  final OnboardingData onboardingData;

  const OnboardingWeight({super.key, required this.onboardingData});

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
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "What's been weighing on you?",
                style: theme.textTheme.displayMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Select all that apply',
                style: theme.textTheme.bodySmall,
              ),
              const SizedBox(height: 32),
              Expanded(
                child: ListView.builder(
                  itemCount: weights.length,
                  itemBuilder: (context, index) {
                    final weight = weights[index];
                    final isSelected = selected.contains(weight['label']);

                    return PastelCard(
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
              PremiumButton(
                label: 'Continue',
                onPressed: selected.isNotEmpty
                    ? () {
                        widget.onboardingData.concerns = selected.toList();
                        Navigator.of(context).push(
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    SignUpOptionsScreen(onboardingData: widget.onboardingData),
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
