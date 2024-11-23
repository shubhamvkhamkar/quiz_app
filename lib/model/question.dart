class Question{
  final String questionText;
  final List<Option> options;

  Question(this.questionText, this.options);
}

class Option {
  final String text;
  final bool isCorrect;

  Option(this.text, this.isCorrect);
}