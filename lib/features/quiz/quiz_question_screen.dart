import 'package:flutter/material.dart';
import '../../core/constants/gradients.dart';
import '../result/result_screen.dart';

class QuizQuestionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: kMainGradient),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text("Question 1/10", style: TextStyle(color: Colors.white)), Text("15s", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))]),
                    SizedBox(height: 10),
                    LinearProgressIndicator(value: 0.1, backgroundColor: Colors.white24, valueColor: AlwaysStoppedAnimation(Colors.cyanAccent)),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(20),
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(30)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("What is the powerhouse of the cell?", textAlign: TextAlign.center, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                      SizedBox(height: 30),
                      _answerOption("Nucleus"),
                      _answerOption("Mitochondria"),
                      _answerOption("Ribosome"),
                      _answerOption("Vacuole"),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.white, minimumSize: Size(double.infinity, 55), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ResultScreen())),
                  child: Text("Submit Answer", style: TextStyle(color: Color(0xFF2575FC), fontWeight: FontWeight.bold)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _answerOption(String title) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      padding: EdgeInsets.all(15),
      width: double.infinity,
      decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(15), border: Border.all(color: Colors.grey[300]!)),
      child: Text(title, textAlign: TextAlign.center, style: TextStyle(fontSize: 16)),
    );
  }
}