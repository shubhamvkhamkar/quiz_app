import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../model/question.dart';

class QuizProvider extends ChangeNotifier{
  List<Question> _questions = [];
  int _currentQuestionIndex = 0;
  int _score = 0;
  bool _isLoading = false;


  List<Question> get questions => _questions;
  int get currentQuestionIndex => _currentQuestionIndex;
  int get score => _score;
  bool get isLoading => _isLoading;

  Question get currentQuestion => _questions[_currentQuestionIndex];

  bool get isQuizCompleted => _currentQuestionIndex >= _questions.length;

  Future<void> fetchQuestions() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await Dio().get(
        'https://opentdb.com/api.php?amount=10',
        queryParameters: {
          'amount': 10, // Number of questions
          'category': 12, //
          'type': 'multiple',
        },
      );

      final data = response.data['results'] as List;

      _questions = data.map((questionData) {
        // Map incorrect answers to Option objects
        List<Option> options = (questionData['incorrect_answers'] as List<dynamic>)
            .map((option) => Option(option.toString(), false))
            .toList();

        // Add the correct answer
        options.add(Option(questionData['correct_answer'].toString(), true));
        options.shuffle();

        // Return the constructed Question object
        return Question(
          questionData['question'].toString(),
           options,
        );
      }).toList();

      _currentQuestionIndex = 0;
      _score = 0;
    } catch (e) {
      print('Error fetching questions: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }


   void answerQuestions(bool isCorrect){
     if(isCorrect){
       _score++;
     }
     _currentQuestionIndex++;
     notifyListeners();
   }

   void resetQuiz(){
     _questions = [];
     _currentQuestionIndex = 0;
     _score=0;
     notifyListeners();
   }
}

