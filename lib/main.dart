import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/provider/quiz_provider.dart';
import 'package:quiz_app/screen/home_screen.dart';

void main() {
  runApp(
      MultiProvider(
      providers:[
        ChangeNotifierProvider(create: (_) => QuizProvider()),
      ],
    child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quiz App',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellow),
        useMaterial3: true,
      ),
      home: HomeScreen(),
    );
  }
}


