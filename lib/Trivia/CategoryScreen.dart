import 'dart:async';
import 'package:codit_competition/Trivia/Questions_Screen.dart';
import 'package:codit_competition/Trivia/teams.dart';
import 'package:codit_competition/questions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import 'MUBCtriviaquestions.dart';

class OneVOne extends StatefulWidget {
  const OneVOne({
    super.key,
    required this.competition,
    required this.team1,
    required this.team2,
    required this.teams,
    this.demo = false,
    this.questions = generalQuestions,
    this.answers = generalAnswers,
    required this.category,
  });
  final Club competition;
  final Team team1;
  final Team team2;
  final bool demo;
  final List<Team> teams;
  final List<String> questions;
  final List<List<String>> answers;
  final CategoryType category;
  @override
  State<OneVOne> createState() => _OneVOneState();
}

class _OneVOneState extends State<OneVOne> {
  int _counter = 5;
  Timer? _timer;
  late Club comp;
  bool countDownStarted = false;
  bool DarkMode = true;
  @override
  void initState() {
    super.initState();
    comp = widget.competition;
  }

  void _startTimer() {
    setState(() {
      countDownStarted = true;
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_counter == 0) {
        _timer?.cancel();
        // Navigate to another screen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) => QuestionsScreen(
                  competitionType: comp,
                  team1: widget.team1,
                  team2: widget.team2,
                  teams: widget.teams,
                  questions: widget.questions,
                  answers: widget.answers,
                ),
          ),
        );
      } else {
        setState(() {
          _counter--;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          Lottie.asset(
            "assets/Background.json",
            width: width,
            height: height,
            fit: BoxFit.cover,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: height * 0.2),
                Container(
                  decoration: BoxDecoration(
                    color:
                        DarkMode
                            ? Colors.black.withOpacity(0.4)
                            : Colors.white.withOpacity(0.18),
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.3),
                      width: DarkMode ? 3 : 0,
                    ),
                  ),

                  child:
                      countDownStarted
                          ? SizedBox(
                            width: width > 700 ? 130 : 100,
                            height: width > 700 ? 130 : 100,
                            child: Center(
                              child: Text(
                                "$_counter",
                                style: GoogleFonts.aBeeZee(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: width > 700 ? 75 : 50,
                                ),
                              ),
                            ),
                          )
                          : IconButton(
                            onPressed: _startTimer,
                            icon: Icon(
                              Icons.play_arrow,
                              color: Colors.white,
                              size: 114,
                            ),
                          ),
                ),
              ],
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 100),
                SizedBox(
                  width: width * 0.85,
                  child: Text(
                    CategoryTypeName(widget.category).displayName,
                    style: GoogleFonts.aBeeZee(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 140,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
