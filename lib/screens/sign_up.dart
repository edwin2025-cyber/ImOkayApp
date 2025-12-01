import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/user_profile.dart';
import '../models/onboarding_data.dart';
import '../widgets/premium_widgets.dart';
import 'creator_intro.dart';

class SignUpScreen extends StatefulWidget {
  final OnboardingData onboardingData;

  const SignUpScreen({super.key, required this.onboardingData});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  String? _validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your name';
    }
    return null;
  }

  String? _validateAge(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null; // Optional
    }
    final age = int.tryParse(value);
    if (age == null || age < 13 || age > 120) {
      return 'Please enter a valid age';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your email';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value.trim())) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value != _passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  Future<void> _handleSignUp() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isLoading = true);

    // Save user profile
    final profile = UserProfile(
      name: _nameController.text.trim(),
      age: int.tryParse(_ageController.text.trim()),
      email: _emailController.text.trim(),
      password: _passwordController.text,
    );

    await profile.save();
    await widget.onboardingData.save();

    if (!mounted) return;

    // Navigate to creator intro
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            CreatorIntroScreen(userName: profile.name ?? 'friend'),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        transitionDuration: const Duration(milliseconds: 400),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Create your space',
                  style: theme.textTheme.headlineMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  'Just a few details so we can make this feel like it\'s really yours.',
                  style: theme.textTheme.bodyLarge,
                ),
                const SizedBox(height: 32),

                // Name field
                PillTextField(
                  controller: _nameController,
                  hint: 'Your first name',
                  label: 'Name',
                  validator: _validateName,
                ),
                const SizedBox(height: 16),

                // Age field
                PillTextField(
                  controller: _ageController,
                  hint: 'Optional',
                  label: 'Age',
                  keyboardType: TextInputType.number,
                  validator: _validateAge,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(3),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4, left: 4),
                  child: Text(
                    'This helps us keep things age-appropriate.',
                    style: theme.textTheme.bodySmall?.copyWith(fontSize: 12),
                  ),
                ),
                const SizedBox(height: 16),

                // Email field
                PillTextField(
                  controller: _emailController,
                  hint: 'you@example.com',
                  label: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  validator: _validateEmail,
                ),
                const SizedBox(height: 16),

                // Password field
                PillTextField(
                  controller: _passwordController,
                  hint: 'At least 6 characters',
                  label: 'Password',
                  obscureText: true,
                  validator: _validatePassword,
                ),
                const SizedBox(height: 16),

                // Confirm password field
                PillTextField(
                  controller: _confirmPasswordController,
                  hint: 'Re-enter your password',
                  label: 'Confirm Password',
                  obscureText: true,
                  validator: _validateConfirmPassword,
                ),
                const SizedBox(height: 32),

                // Sign up button
                PremiumButton(
                  label: 'Sign up',
                  onPressed: _handleSignUp,
                  loading: _isLoading,
                ),

                const SizedBox(height: 16),

                // Sign in link (placeholder)
                Center(
                  child: TextButton(
                    onPressed: () {
                      // TODO: Navigate to sign in
                    },
                    child: Text(
                      'Already have an account? Sign in',
                      style: theme.textTheme.bodySmall,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
