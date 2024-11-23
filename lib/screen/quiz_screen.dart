import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/quiz_provider.dart';
import 'result_screen.dart';

class QuizScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final quizProvider = Provider.of<QuizProvider>(context);

    if (quizProvider.isLoading) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (quizProvider.isQuizCompleted) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ResultScreen()),
        );
      });
      return SizedBox.shrink();
    }

    final question = quizProvider.currentQuestion;

    return Scaffold(
      backgroundColor: Colors.blueAccent,
      appBar: AppBar(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(21)),
        backgroundColor: Colors.grey,
        title: Text('Quiz',style: TextStyle(fontSize:25 , fontWeight: FontWeight.bold),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Question ${quizProvider.currentQuestionIndex + 1}/${quizProvider.questions.length}',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              question.questionText,
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            ...question.options.map((option) {
              return ElevatedButton(
                onPressed: () => quizProvider.answerQuestions(option.isCorrect),
                child: Text(option.text,style: TextStyle(fontSize: 18,color: Colors.green),),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
