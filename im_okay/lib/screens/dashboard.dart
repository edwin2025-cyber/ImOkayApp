import 'package:flutter/material.dart';
import '../models/user_profile.dart';
import '../models/onboarding_data.dart';
import 'profile.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  UserProfile? _userProfile;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    final profile = await UserProfile.load();
    setState(() {
      _userProfile = profile;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // For development: reset onboarding
  Future<void> _resetOnboarding() async {
    await OnboardingData.clear();
    await UserProfile.clear();
    if (mounted) {
      Navigator.of(context).pushReplacementNamed('/');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: _selectedIndex == 0 ? _buildHomeView() : const ProfileScreen(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: theme.scaffoldBackgroundColor,
        selectedItemColor: isDark ? const Color(0xFFF5F5F5) : Colors.black,
        unselectedItemColor: theme.colorScheme.secondary,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _buildHomeView() {
    final theme = Theme.of(context);
    final userName = _userProfile?.name ?? 'friend';

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome back, $userName',
            style: theme.textTheme.headlineMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'How are you feeling today?',
            style: theme.textTheme.bodyLarge,
          ),
          const SizedBox(height: 32),

          // Today's check-in card
          _buildCard(
            theme,
            title: "Today's Check-in",
            subtitle: 'Take a moment to reflect',
            icon: Icons.edit_note_outlined,
            color: const Color(0xFF87CEEB),
          ),

          const SizedBox(height: 16),

          // Quick tools section
          Text(
            'Quick Tools',
            style: theme.textTheme.titleLarge,
          ),
          const SizedBox(height: 16),

          Row(
            children: [
              Expanded(
                child: _buildSmallCard(
                  theme,
                  title: 'Breathing',
                  icon: Icons.air,
                  color: const Color(0xFF98D8C8),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildSmallCard(
                  theme,
                  title: 'Journal',
                  icon: Icons.book_outlined,
                  color: const Color(0xFFFFB366),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Row(
            children: [
              Expanded(
                child: _buildSmallCard(
                  theme,
                  title: 'Meditate',
                  icon: Icons.spa_outlined,
                  color: const Color(0xFFB39DDB),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildSmallCard(
                  theme,
                  title: 'Resources',
                  icon: Icons.favorite_border,
                  color: const Color(0xFFFFB3C1),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProfileView() {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Profile',
            style: theme.textTheme.headlineMedium,
          ),
          const SizedBox(height: 24),

          if (_userProfile != null) ...[
            _buildProfileRow(theme, 'Name', _userProfile!.name ?? 'Not set'),
            _buildProfileRow(theme, 'Age', _userProfile!.age?.toString() ?? 'Not set'),
            _buildProfileRow(theme, 'Email', _userProfile!.email ?? 'Not set'),
          ],

          const SizedBox(height: 32),

          // Dev option to reset
          TextButton(
            onPressed: _resetOnboarding,
            child: const Text('Reset Onboarding (Dev)'),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(ThemeData theme, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
  }) {
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1A1A1A) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? const Color(0xFF2A2A2A) : const Color(0xFFE4E4E4),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: theme.textTheme.titleLarge),
                const SizedBox(height: 4),
                Text(subtitle, style: theme.textTheme.bodySmall),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSmallCard(ThemeData theme, {
    required String title,
    required IconData icon,
    required Color color,
  }) {
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1A1A1A) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? const Color(0xFF2A2A2A) : const Color(0xFFE4E4E4),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 12),
          Text(title, style: theme.textTheme.bodyMedium),
        ],
      ),
    );
  }

  Widget _buildProfileRow(ThemeData theme, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            child: Text(label, style: theme.textTheme.bodySmall),
          ),
          Expanded(
            child: Text(value, style: theme.textTheme.bodyMedium),
          ),
        ],
      ),
    );
  }
}
