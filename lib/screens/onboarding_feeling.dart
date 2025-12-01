import 'package:flutter/material.dart';
import 'onboarding_weight.dart';
import '../widgets/premium_widgets.dart';
import '../models/onboarding_data.dart';

class OnboardingFeeling extends StatefulWidget {
  const OnboardingFeeling({super.key});

  @override
  State<OnboardingFeeling> createState() => _OnboardingFeelingState();
}

class _OnboardingFeelingState extends State<OnboardingFeeling> {
  String? selectedFeeling;

  final List<Map<String, dynamic>> feelings = [
    {
      'label': 'Calm or good',
      'icon': Icons.wb_sunny_outlined,
      'color': const Color(0xFF87CEEB), // baby blue
    },
    {
      'label': 'Low or sad',
      'icon': Icons.cloud_outlined,
      'color': const Color(0xFF6B9BD1), // soft blue
    },
    {
      'label': 'Tired or burnt out',
      'icon': Icons.bedtime_outlined,
      'color': const Color(0xFFFFB366), // soft orange
    },
    {
      'label': 'Holding up okay',
      'icon': Icons.favorite_border,
      'color': const Color(0xFF98D8C8), // mint
    },
    {
      'label': 'Not sure yet',
      'icon': Icons.help_outline,
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
                'How have you been\nfeeling lately?',
                style: theme.textTheme.displayMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 32),
              Expanded(
                child: ListView.builder(
                  itemCount: feelings.length,
                  itemBuilder: (context, index) {
                    final feeling = feelings[index];
                    final isSelected = selectedFeeling == feeling['label'];

                    return PastelCard(
                      label: feeling['label'],
                      icon: feeling['icon'],
                      accentColor: feeling['color'],
                      selected: isSelected,
                      onTap: () {
                        setState(() {
                          selectedFeeling = feeling['label'];
                        });
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              PremiumButton(
                label: 'Continue',
                onPressed: selectedFeeling != null
                    ? () {
                        final data = OnboardingData(mood: selectedFeeling);
                        Navigator.of(context).push(
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    OnboardingWeight(onboardingData: data),
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
