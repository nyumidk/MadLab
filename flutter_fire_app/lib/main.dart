import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

// Generated automatically by running `flutterfire configure`
// in the project root — see README.md. Do not write this by hand.
import 'firebase_options.dart';
import 'home_screen.dart';

void main() async {
  // Firebase.initializeApp() is async, so the binding must be ready first.
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Firebase Notes',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}