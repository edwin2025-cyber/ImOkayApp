import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/splash_screen.dart';
import 'theme.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
  
  // Set system UI overlay style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  
  runApp(const ImOkayApp());
}

class ImOkayApp extends StatelessWidget {
  const ImOkayApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "I'm Okay",
      themeMode: ThemeMode.system,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: const SplashScreen(),
    );
  }
}
