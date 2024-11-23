import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/quiz_provider.dart';
import 'home_screen.dart';

class ResultScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final quizProvider = Provider.of<QuizProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(21)),
        backgroundColor: Colors.grey,
        title: Text('Quiz Result',style: TextStyle(fontSize:25 , fontWeight: FontWeight.bold),),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Your Score: ${quizProvider.score}',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(style: ButtonStyle(backgroundColor: WidgetStateProperty.all<Color>(Colors.cyan),),
              onPressed: () {
                quizProvider.resetQuiz();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
              child: Text('Restart Quiz'),
            ),
          ],
        ),
      ),
    );
  }
}
