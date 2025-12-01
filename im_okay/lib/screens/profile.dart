import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/user_profile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserProfile? _userProfile;
  bool _darkMode = false;
  bool _soundsEnabled = true;
  bool _hapticsEnabled = true;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final profile = await UserProfile.load();
    setState(() {
      _userProfile = profile;
      // TODO: Load saved preferences
    });
  }

  void _toggleDarkMode(bool value) {
    HapticFeedback.lightImpact();
    setState(() => _darkMode = value);
    // TODO: Save preference and update theme
  }

  void _toggleSounds(bool value) {
    HapticFeedback.lightImpact();
    setState(() => _soundsEnabled = value);
    // TODO: Save preference
  }

  void _toggleHaptics(bool value) {
    if (_hapticsEnabled) {
      HapticFeedback.lightImpact();
    }
    setState(() => _hapticsEnabled = value);
    // TODO: Save preference
  }

  void _exportData() {
    HapticFeedback.mediumImpact();
    // TODO: Implement data export
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Export feature coming soon')),
    );
  }

  void _deleteAccount() {
    HapticFeedback.mediumImpact();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Account'),
        content: const Text(
          'Are you sure? This will permanently delete all your data and cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // TODO: Implement account deletion
              Navigator.pop(context);
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.red,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          const SizedBox(height: 24),

          // User Info Section
          _buildSection(
            context,
            children: [
              _buildInfoRow(
                context,
                icon: Icons.person_outline,
                label: 'Name',
                value: _userProfile?.name ?? 'Loading...',
              ),
              _buildDivider(isDark),
              _buildInfoRow(
                context,
                icon: Icons.cake_outlined,
                label: 'Age',
                value: _userProfile?.age.toString() ?? 'Loading...',
              ),
              _buildDivider(isDark),
              _buildInfoRow(
                context,
                icon: Icons.email_outlined,
                label: 'Email',
                value: _userProfile?.email ?? 'Loading...',
              ),
            ],
          ),

          const SizedBox(height: 32),

          // Account Actions
          _buildSection(
            context,
            children: [
              _buildActionRow(
                context,
                icon: Icons.download_outlined,
                label: 'Export my data',
                onTap: _exportData,
              ),
              _buildDivider(isDark),
              _buildActionRow(
                context,
                icon: Icons.delete_outline,
                label: 'Delete account',
                onTap: _deleteAccount,
                destructive: true,
              ),
            ],
          ),

          const SizedBox(height: 32),

          // Settings Section
          _buildSection(
            context,
            children: [
              _buildToggleRow(
                context,
                icon: Icons.dark_mode_outlined,
                label: 'Dark mode',
                value: _darkMode,
                onChanged: _toggleDarkMode,
              ),
              _buildDivider(isDark),
              _buildToggleRow(
                context,
                icon: Icons.volume_up_outlined,
                label: 'Sounds',
                value: _soundsEnabled,
                onChanged: _toggleSounds,
              ),
              _buildDivider(isDark),
              _buildToggleRow(
                context,
                icon: Icons.vibration_outlined,
                label: 'Haptics',
                value: _hapticsEnabled,
                onChanged: _toggleHaptics,
              ),
            ],
          ),

          const SizedBox(height: 32),

          // Support Section
          _buildSection(
            context,
            children: [
              _buildActionRow(
                context,
                icon: Icons.help_outline,
                label: 'Help & Support',
                onTap: () {
                  HapticFeedback.lightImpact();
                  // TODO: Navigate to help
                },
              ),
              _buildDivider(isDark),
              _buildActionRow(
                context,
                icon: Icons.info_outline,
                label: 'About',
                onTap: () {
                  HapticFeedback.lightImpact();
                  // TODO: Navigate to about
                },
              ),
            ],
          ),

          const SizedBox(height: 32),

          // Version Footer
          Center(
            child: Text(
              'Version 1.0.0',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.secondary,
              ),
            ),
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildSection(BuildContext context, {required List<Widget> children}) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.3 : 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }

  Widget _buildDivider(bool isDark) {
    return Divider(
      height: 1,
      thickness: 1,
      indent: 56,
      color: isDark ? const Color(0xFF2C2C2C) : const Color(0xFFF0F0F0),
    );
  }

  Widget _buildInfoRow(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
  }) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        children: [
          Icon(icon, size: 24, color: theme.colorScheme.secondary),
          const SizedBox(width: 16),
          Text(
            label,
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.secondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionRow(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    bool destructive = false,
  }) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          children: [
            Icon(
              icon,
              size: 24,
              color: destructive ? Colors.red : theme.colorScheme.secondary,
            ),
            const SizedBox(width: 16),
            Text(
              label,
              style: theme.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: destructive ? Colors.red : null,
              ),
            ),
            const Spacer(),
            Icon(
              Icons.chevron_right,
              color: destructive ? Colors.red : theme.colorScheme.secondary,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleRow(
    BuildContext context, {
    required IconData icon,
    required String label,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 24, color: theme.colorScheme.secondary),
          const SizedBox(width: 16),
          Text(
            label,
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: const Color(0xFF87CEEB),
          ),
        ],
      ),
    );
  }
}
