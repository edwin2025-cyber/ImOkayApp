import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfile {
  String? name;
  int? age;
  String? email;
  String? password;
  
  UserProfile({this.name, this.age, this.email, this.password});

  Map<String, dynamic> toJson() => {
        'name': name,
        'age': age,
        'email': email,
        // Don't store password in production - this is just for demo
      };

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
        name: json['name'],
        age: json['age'],
        email: json['email'],
      );

  // Save to local storage
  Future<void> save() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_profile', jsonEncode(toJson()));
  }

  // Load from local storage
  static Future<UserProfile?> load() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('user_profile');
    if (data == null) return null;
    return UserProfile.fromJson(jsonDecode(data));
  }

  // Clear user profile
  static Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_profile');
  }
}
