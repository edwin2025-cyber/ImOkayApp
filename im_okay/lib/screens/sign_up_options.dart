import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import '../models/user_profile.dart';
import '../models/onboarding_data.dart';
import '../widgets/premium_widgets.dart';
import 'creator_intro.dart';
import 'sign_in.dart';

class SignUpOptionsScreen extends StatefulWidget {
  final OnboardingData onboardingData;

  const SignUpOptionsScreen({super.key, required this.onboardingData});

  @override
  State<SignUpOptionsScreen> createState() => _SignUpOptionsScreenState();
}

class _SignUpOptionsScreenState extends State<SignUpOptionsScreen> {
  bool _showEmailForm = false;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _ensureFirebaseInitialized() async {
    if (kIsWeb) {
      // On web, JS SDK initializes. Do nothing to avoid channel errors.
      return;
    }
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp(
        options: const FirebaseOptions(
          apiKey: "AIzaSyDC64q3neG5Pwxe_Ecoq-iZCYGO6qtcydo",
          authDomain: "imokayapp-741a0.firebaseapp.com",
          databaseURL: "https://imokayapp-741a0-default-rtdb.firebaseio.com",
          projectId: "imokayapp-741a0",
          storageBucket: "imokayapp-741a0.firebasestorage.app",
          messagingSenderId: "566836508326",
          appId: "1:566836508326:web:bd31b835487758b0d6e667",
          measurementId: "G-YXCMLFX4DJ",
        ),
      );
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<int?> _promptAge() async {
    final ageController = TextEditingController();
    return showDialog<int>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Your age'),
        content: TextField(
          controller: ageController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(hintText: 'Enter your age'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final age = int.tryParse(ageController.text.trim());
              Navigator.pop(context, age);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  Future<void> _handleAppleSignUp() async {
    if (!kIsWeb) HapticFeedback.lightImpact();
    try {
      await _ensureFirebaseInitialized();
      final appleProvider = OAuthProvider('apple.com');
      final userCredential = await FirebaseAuth.instance.signInWithPopup(appleProvider);
      final user = userCredential.user;
      if (user != null) {
        int? age = int.tryParse(_ageController.text.trim());
        if (age == null) {
          age = await _promptAge();
        }
        final profile = UserProfile(
          name: _nameController.text.trim().isNotEmpty ? _nameController.text.trim().split(' ').first : (user.displayName?.split(' ').first ?? 'friend'),
          age: age,
          email: user.email,
          password: null,
        );
        await profile.save();
        await widget.onboardingData.save();

        if (!mounted) return;
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
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Apple sign-in failed: $e')),
      );
    }
  }

  Future<void> _handleGoogleSignUp() async {
    if (!kIsWeb) HapticFeedback.lightImpact();
    try {
      await _ensureFirebaseInitialized();
      final userCredential = await FirebaseAuth.instance.signInWithPopup(GoogleAuthProvider());
      final user = userCredential.user;
      if (user != null) {
        // Persist minimal profile locally
        int? age = int.tryParse(_ageController.text.trim());
        if (age == null) {
          age = await _promptAge();
        }
        final profile = UserProfile(
          name: _nameController.text.trim().isNotEmpty ? _nameController.text.trim().split(' ').first : (user.displayName?.split(' ').first),
          age: age,
          email: user.email,
          password: null,
        );
        await profile.save();
        await widget.onboardingData.save();

        if (!mounted) return;
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
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Google sign-in failed: $e')),
      );
    }
  }

  Future<void> _handleEmailSignUp() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isLoading = true);
    try {
      await _ensureFirebaseInitialized();
      final email = _emailController.text.trim();
      final password = _passwordController.text;
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final profile = UserProfile(
        name: _nameController.text.trim().split(' ').first,
        age: int.tryParse(_ageController.text.trim()),
        email: email,
        password: null,
      );
      await profile.save();
      await widget.onboardingData.save();

      if (!mounted) return;
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
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? 'Sign-up failed')),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Sign up to create your space',
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 32),

              if (!_showEmailForm) ...[
                // Apple Sign Up
                _buildSocialButton(
                  label: 'Apple',
                  iconWidget: const Icon(Icons.apple, size: 22),
                  onPressed: _handleAppleSignUp,
                  isDark: isDark,
                ),
                const SizedBox(height: 12),

                // Google Sign Up
                  _buildSocialButton(
                    label: 'Google',
                    iconWidget: Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          'G',
                          style: TextStyle(
                            fontFamily: 'DmSans',
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF4285F4),
                          ),
                        ),
                      ),
                    ),
                    onPressed: _handleGoogleSignUp,
                    isDark: isDark,
                  ),
                const SizedBox(height: 24),

                // Divider
                Row(
                  children: [
                    Expanded(child: Divider(color: theme.colorScheme.secondary.withOpacity(0.3))),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text('OR', style: theme.textTheme.bodySmall),
                    ),
                    Expanded(child: Divider(color: theme.colorScheme.secondary.withOpacity(0.3))),
                  ],
                ),
                const SizedBox(height: 24),

                // Email Sign Up Button
                PremiumButton(
                  label: 'Email',
                  onPressed: () {
                    setState(() => _showEmailForm = true);
                  },
                ),
              ] else ...[
                // Email form
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      PillTextField(
                        controller: _nameController,
                        hint: 'Your first name',
                        label: 'Name',
                        validator: (value) =>
                            value?.trim().isEmpty ?? true ? 'Please enter your name' : null,
                      ),
                      const SizedBox(height: 16),

                      PillTextField(
                        controller: _ageController,
                        hint: 'Required',
                        label: 'Age',
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value?.trim().isEmpty ?? true) return 'Please enter your age';
                          final age = int.tryParse(value!);
                          if (age == null || age < 13 || age > 120) {
                            return 'Please enter a valid age';
                          }
                          return null;
                        },
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(3),
                        ],
                      ),
                      const SizedBox(height: 16),

                      PillTextField(
                        controller: _emailController,
                        hint: 'you@example.com',
                        label: 'Email',
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value?.trim().isEmpty ?? true) return 'Please enter your email';
                            if (!(value!.contains('@') && value.contains('.'))) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      PillTextField(
                        controller: _passwordController,
                        hint: 'At least 6 characters',
                        label: 'Password',
                        obscureText: true,
                        validator: (value) {
                          if (value?.isEmpty ?? true) return 'Please enter a password';
                          if (value!.length < 6) return 'Password must be at least 6 characters';
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      PillTextField(
                        controller: _confirmPasswordController,
                        hint: 'Re-enter your password',
                        label: 'Confirm Password',
                        obscureText: true,
                        validator: (value) {
                          if (value != _passwordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 24),

                      // Terms text
                      Text(
                        'By signing up, you agree to our Terms and Privacy Policy.',
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodySmall,
                      ),
                      const SizedBox(height: 24),

                      PremiumButton(
                        label: 'Sign up',
                        onPressed: _handleEmailSignUp,
                        loading: _isLoading,
                      ),
                    ],
                  ),
                ),
              ],

              const SizedBox(height: 16),

              // Sign in link
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const SignInScreen(),
                      ),
                    );
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
    );
  }

  Widget _buildSocialButton({
    required String label,
    required Widget iconWidget,
    required VoidCallback onPressed,
    required bool isDark,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        height: 56,
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1A1A1A) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isDark ? const Color(0xFF2A2A2A) : const Color(0xFFE4E4E4),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            iconWidget,
            const SizedBox(width: 12),
            Text(
              label,
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
