import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingData {
  String? mood;
  List<String> concerns;
  bool completed;
  
  OnboardingData({
    this.mood,
    this.concerns = const [],
    this.completed = false,
  });

  Map<String, dynamic> toJson() => {
        'mood': mood,
        'concerns': concerns,
        'completed': completed,
      };

  factory OnboardingData.fromJson(Map<String, dynamic> json) => OnboardingData(
        mood: json['mood'],
        concerns: List<String>.from(json['concerns'] ?? []),
        completed: json['completed'] ?? false,
      );

  // Save to local storage
  Future<void> save() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('onboarding_data', jsonEncode(toJson()));
  }

  // Load from local storage
  static Future<OnboardingData?> load() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('onboarding_data');
    if (data == null) return null;
    return OnboardingData.fromJson(jsonDecode(data));
  }

  // Mark onboarding as complete
  static Future<void> markComplete() async {
    final data = await load() ?? OnboardingData();
    data.completed = true;
    await data.save();
  }

  // Check if onboarding is complete
  static Future<bool> isComplete() async {
    final data = await load();
    return data?.completed ?? false;
  }

  // Clear onboarding data
  static Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('onboarding_data');
  }
}
