import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/data/questions.dart';
import 'package:quiz_app/questions_summary.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({
    super.key,
    required this.chosenAnswers,
    required this.onRestartQuiz,
  });

  final List<String> chosenAnswers;
  final void Function() onRestartQuiz;

  List<Map<String, Object>> get summaryData {
    // getter
    final List<Map<String, Object>> summary = [];

    for (var i = 0; i < chosenAnswers.length; i++) {
      summary.add({
        'question_index': i,
        'question': questions[i].text,
        'correct_answer': questions[i].answers[0],
        'user_answer': chosenAnswers[i],
      });
    }

    return summary;
  }

  @override
  Widget build(BuildContext context) {
    final numTotalQuestions = questions.length;
    final numCorrectQuestions = summaryData
        .where((data) => // arrow function
            data['user_answer'] == data['correct_answer'])
        .length;
        
    return Container(
      margin: const EdgeInsets.all(40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            textAlign: TextAlign.center,
            style: GoogleFonts.lato(
              fontSize: 24,
              color: const Color.fromARGB(255, 0, 0, 0),
            ),
            'You Answered $numCorrectQuestions out of $numTotalQuestions questions correctly!',
          ),
          const SizedBox(
            height: 30,
          ),
          QuestionsSummary(
            summaryData,
          ),
          const SizedBox(
            height: 30,
          ),
          TextButton.icon(
            icon: const Icon(Icons.restart_alt),
            onPressed: onRestartQuiz,
            label: Text(
              style: GoogleFonts.lato(
                fontSize: 18,
                color: const Color.fromARGB(255, 0, 0, 0),
              ),
              'Restart Quiz',
            ),
          ),
        ],
      ),
    );
  }
}
