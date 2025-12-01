import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Premium pill button with press animation, shadow, and haptics
class PremiumButton extends StatefulWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool loading;

  const PremiumButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.loading = false,
  });

  @override
  State<PremiumButton> createState() => _PremiumButtonState();
}

class _PremiumButtonState extends State<PremiumButton> {
  bool _isPressed = false;

  void _handleTapDown(TapDownDetails details) {
    if (widget.onPressed != null && !widget.loading) {
      setState(() => _isPressed = true);
      HapticFeedback.lightImpact();
    }
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() => _isPressed = false);
  }

  void _handleTapCancel() {
    setState(() => _isPressed = false);
  }

  void _handleTap() {
    if (widget.onPressed != null && !widget.loading) {
      widget.onPressed!();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final isEnabled = widget.onPressed != null && !widget.loading;

    Color buttonColor;
    Color textColor;

    if (!isEnabled) {
      buttonColor = isDark ? const Color(0xFF2A2A2A) : const Color(0xFFE0E0E0);
      textColor = isDark ? const Color(0xFF666666) : const Color(0xFFA0A0A0);
    } else {
      buttonColor = isDark ? const Color(0xFFF5F5F5) : Colors.black;
      textColor = isDark ? const Color(0xFF0A0A0A) : Colors.white;
    }

    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      onTap: _handleTap,
      child: AnimatedScale(
        scale: _isPressed && isEnabled ? 0.97 : 1.0,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeOut,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          width: double.infinity,
          height: 58,
          decoration: BoxDecoration(
            color: buttonColor,
            borderRadius: BorderRadius.circular(32),
            boxShadow: isEnabled && !_isPressed
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(isDark ? 0.3 : 0.15),
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : [],
          ),
          child: Center(
            child: widget.loading
                ? SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      valueColor: AlwaysStoppedAnimation<Color>(textColor),
                    ),
                  )
                : Text(
                    widget.label,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: textColor,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}

/// Selectable card for onboarding options - no checkmarks, pastel tints
class PastelCard extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color accentColor;
  final bool selected;
  final VoidCallback onTap;

  const PastelCard({
    super.key,
    required this.label,
    required this.icon,
    required this.accentColor,
    required this.selected,
    required this.onTap,
  });

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
    if (icon == Icons.home_outlined) return Icons.home;
    return icon;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final backgroundColor = selected
        ? accentColor.withOpacity(isDark ? 0.15 : 0.08)
        : (isDark ? const Color(0xFF1A1A1A) : Colors.white);

    final borderColor = selected
        ? accentColor
        : (isDark ? const Color(0xFF2A2A2A) : const Color(0xFFE4E4E4));

    final textColor = selected
        ? accentColor
        : (isDark ? const Color(0xFFF5F5F5) : const Color(0xFF0A0A0A));

    return GestureDetector(
      onTap: () {
        HapticFeedback.mediumImpact();
        onTap();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: borderColor,
            width: 1,
          ),
          boxShadow: [],
        ),
        child: Row(
          children: [
            Icon(
              selected ? _getFilledIcon(icon) : icon,
              size: 24,
              color: accentColor,
            ),
            const SizedBox(width: 14),
            Expanded(
              child: AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 250),
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 16,
                  fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                  color: textColor,
                ),
                child: Text(label),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Custom text field with pill shape
class PillTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final String? label;
  final TextInputType? keyboardType;
  final bool obscureText;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;

  const PillTextField({
    super.key,
    required this.controller,
    required this.hint,
    this.label,
    this.keyboardType,
    this.obscureText = false,
    this.validator,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: theme.textTheme.bodySmall,
          ),
          const SizedBox(height: 6),
        ],
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          validator: validator,
          inputFormatters: inputFormatters,
          style: theme.textTheme.bodyMedium,
          decoration: InputDecoration(
            hintText: hint,
          ),
        ),
      ],
    );
  }
}
