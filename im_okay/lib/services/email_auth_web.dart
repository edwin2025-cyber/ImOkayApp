import 'dart:async';
import 'dart:convert';
import 'dart:html' as html;

// Uses Firebase Identity Toolkit REST API for web sign-up to avoid FlutterFire channel issues
Future<void> emailSignUp(String email, String password) async {
  const apiKey = "AIzaSyDC64q3neG5Pwxe_Ecoq-iZCYGO6qtcydo";
  final url = Uri.parse('https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$apiKey');

  final req = await html.HttpRequest.request(
    url.toString(),
    method: 'POST',
    requestHeaders: {
      'Content-Type': 'application/json',
    },
    sendData: jsonEncode({
      'email': email,
      'password': password,
      'returnSecureToken': true,
    }),
  );

  if (req.status != 200) {
    throw Exception(req.responseText ?? 'Sign-up failed');
  }
  // You can parse idToken/localId from the response if needed
}
