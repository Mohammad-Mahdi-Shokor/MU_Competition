import 'dart:math';

import 'package:codit_competition/screens/start_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart' show GoogleFonts;
import 'package:lottie/lottie.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({
    super.key,
    required this.team1Score,
    required this.team2Score,
    required this.team1Name,
    required this.team2Name,
  });
  final int team1Score;
  final int team2Score;
  final String team1Name;
  final String team2Name;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(child: Lottie.asset("Confetti.json")),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                team1Score != team2Score
                    ? Text(
                      "Congrats, ${team1Score > team2Score ? team1Name : team2Name} won \n with a score of ${max(team1Score, team2Score)}",
                      style: GoogleFonts.aBeeZee(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 80,
                      ),
                    )
                    : Text(
                      "Congrats, it is a draw!!!",
                      style: GoogleFonts.aBeeZee(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 80,
                      ),
                    ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => StartScreen()),
                    );
                  },
                  child: Text("Go back to start"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
