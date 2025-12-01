import 'package:flutter/material.dart';

/// Reusable selectable card component for mood/weight screens
class SelectableCard extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color accentColor;
  final bool selected;
  final VoidCallback onTap;

  const SelectableCard({
    super.key,
    required this.label,
    required this.icon,
    required this.accentColor,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: selected ? accentColor.withOpacity(0.08) : Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: selected ? accentColor : const Color(0xFFE4E4E4),
            width: selected ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(selected ? 0.04 : 0.02),
              blurRadius: selected ? 4 : 2,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Icon with accent color
            Icon(
              selected ? _getFilledIcon(icon) : icon,
              size: 24,
              color: accentColor,
            ),
            const SizedBox(width: 14),
            // Label text
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),
            // Checkmark when selected
            if (selected)
              Icon(
                Icons.check_circle,
                size: 20,
                color: accentColor,
              ),
          ],
        ),
      ),
    );
  }

  // Helper to convert outline icons to filled versions when selected
  IconData _getFilledIcon(IconData icon) {
    if (icon == Icons.cloud_outlined) return Icons.cloud;
    if (icon == Icons.favorite_border) return Icons.favorite;
    if (icon == Icons.help_outline) return Icons.help;
    if (icon == Icons.bedtime_outlined) return Icons.bedtime;
    if (icon == Icons.wb_sunny_outlined) return Icons.wb_sunny;
    if (icon == Icons.school_outlined) return Icons.school;
    if (icon == Icons.people_outline) return Icons.people;
    if (icon == Icons.error_outline) return Icons.error;
    if (icon == Icons.sentiment_neutral_outlined) return Icons.sentiment_neutral;
    return icon; // Default fallback
  }
}

/// Reusable primary button component for all bottom CTAs
class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;

  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final bool isEnabled = onPressed != null;

    return GestureDetector(
      onTap: onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
        width: double.infinity,
        height: 56,
        decoration: BoxDecoration(
          color: isEnabled ? Colors.black : const Color(0xFFE0E0E0),
          borderRadius: BorderRadius.circular(24),
          boxShadow: isEnabled
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: isEnabled ? Colors.white : const Color(0xFFA0A0A0),
            ),
          ),
        ),
      ),
    );
  }
}
