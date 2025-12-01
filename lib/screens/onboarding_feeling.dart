import 'package:flutter/material.dart';
import 'onboarding_weight.dart';
import '../widgets/ui_components.dart';

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
                'How have you been\nfeeling lately?',
                style: TextStyle(
                  fontFamily: 'DM Sans',
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 32),
              Expanded(
                child: ListView.builder(
                  itemCount: feelings.length,
                  itemBuilder: (context, index) {
                    final feeling = feelings[index];
                    final isSelected = selectedFeeling == feeling['label'];

                    return SelectableCard(
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
              PrimaryButton(
                label: 'Continue',
                onPressed: selectedFeeling != null
                    ? () {
                        Navigator.of(context).push(
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    const OnboardingWeight(),
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
