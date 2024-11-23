import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/provider/quiz_provider.dart';
import 'package:quiz_app/screen/quiz_screen.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(21)),
        backgroundColor: Colors.amber,
        title: Center(child: Text("Quiz App", style: TextStyle(fontSize: 36,fontWeight: FontWeight.bold),)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to app Quiz!',
              style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
              color: Colors.purpleAccent),
            ),
            SizedBox(height: 20,),
            Row(
              children: [
                Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ElevatedButton(
                        style: ButtonStyle(backgroundColor: WidgetStateProperty.all<Color>(Colors.cyan),),
                          onPressed: () async {
                        final quizProvider =
                        Provider.of<QuizProvider>(context,listen: false);
                        await quizProvider.fetchQuestions();
                        if(!quizProvider.isLoading && quizProvider.questions.isNotEmpty) {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) => QuizScreen(),));
                        }
                      },
                          child: Text('Start Quiz',style:
                            TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 23),)),
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
