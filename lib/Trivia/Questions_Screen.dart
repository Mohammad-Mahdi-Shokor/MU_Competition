import 'dart:async';
import 'package:codit_competition/Trivia/LeaderBoardScreen.dart';
import 'package:codit_competition/Trivia/oneVOneResults.dart';
import 'package:codit_competition/Trivia/teams.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({
    super.key,
    this.competitionType = Club.MUBC,
    required this.team1,
    required this.team2,
    required this.teams,
    this.Draw = false,
    this.Demo = false,
    required this.questions,
    required this.answers,
  });
  final Club competitionType;
  final Team team1;
  final Team team2;
  final List<Team> teams;
  final bool Draw;
  final bool Demo;
  final List<String> questions;
  final List<List<String>> answers;
  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen>
    with SingleTickerProviderStateMixin {
  int index = 0;

  late List<String> shownQuestionTexts;
  late List<List<String>> shownAnswers;
  bool DarkMode = true;
  late String team1 = widget.team1.TeamName;
  late String team2 = widget.team2.TeamName;
  List<Team> teams = [];
  int team1Score = 0;
  int team2Score = 0;
  int _secondsRemaining = 30;
  Timer? _timer;
  int currentTeam = 1;
  bool _isTimerPaused = false;

  // TEAM COLORS
  Color team1Color = Colors.white.withOpacity(0.3);
  Color team2Color = Colors.white.withOpacity(0.3);
  Color get ContainerColor {
    return DarkMode
        ? Colors.black.withOpacity(0.3)
        : Colors.white.withOpacity(0.18);
  }

  // bool check = true; // for second team attempts
  bool buttonsEnabled = false;
  String? selectedAnswer;

  late AnimationController _controller;

  void goToPreviousQuestion() {
    // Don't go back if we're at the first question
    if (index <= 0) {
      // Optional: Show a snackbar or toast to indicate can't go back
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Already at the first question"),
          duration: Duration(seconds: 1),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    // Cancel current timer
    _timer?.cancel();

    setState(() {
      index--; // Decrement index to go to previous question

      // Reset all states for the new question
      selectedAnswer = null;
      lastTeamAttempted = null;
      NextQuestion = false;
      buttonsEnabled = false;
      team1Color = Colors.white.withOpacity(0.3);
      team2Color = Colors.white.withOpacity(0.3);
      _isTimerPaused = false;
      _secondsRemaining = 30;
    });

    // Start timer for the new question
    startTimer(reset: true); // Reset to 25 seconds

    // Enable buttons after delay
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          buttonsEnabled = true;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();

    // Use default questions from widget or demo questions
    List<String> questionList =
        widget.questions.isNotEmpty ? widget.questions : [];
    List<List<String>> answersList =
        widget.answers.isNotEmpty ? widget.answers : [];
    teams = widget.teams;
    shownQuestionTexts = questionList;
    shownAnswers =
        answersList.map((answerList) {
          List<String> shuffled = List.from(answerList);
          shuffled.shuffle();
          return shuffled;
        }).toList();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat(reverse: true);

    loadNextQuestion();
    startTimer(reset: true);
  }

  bool NextQuestion = false;
  // ----------------------------------------------------------
  // LOAD NEXT QUESTION (buttons locked 3 secs)
  // ----------------------------------------------------------
  void showNextQuestionButton() {
    setState(() {
      NextQuestion = true;
      buttonsEnabled = false;
    });
  }

  void loadNextQuestion() {
    setState(() {
      selectedAnswer = null;
      buttonsEnabled = false;
      NextQuestion = false;
      team1Color = Colors.white.withOpacity(0.3);
      team2Color = Colors.white.withOpacity(0.3);
      lastTeamAttempted = null; // Add this
    });

    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;
      setState(() {
        buttonsEnabled = true;
      });
    });
  }

  // ----------------------------------------------------------
  // FIXED TIMER
  // ----------------------------------------------------------
  void startTimer({bool reset = false}) {
    if (_isTimerPaused) return; // Don't start timer if paused

    _timer?.cancel();
    if (reset) {
      _secondsRemaining = 30;
    }

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_isTimerPaused) return; // Skip if paused

      if (_secondsRemaining <= 0) {
        timer.cancel();

        // Reset team color to yellow after timeout
        if (currentTeam == 1) {
          team1Color = Colors.white.withOpacity(0.3);
        } else {
          team2Color = Colors.white.withOpacity(0.3);
        }

        setState(() {
          currentTeam = currentTeam == 1 ? 2 : 1;
        });

        if (!mounted) return;

        showNextQuestionButton();

        if (index >= shownQuestionTexts.length) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (context) => Onevoneresults(
                    team1: widget.team1,
                    competition: widget.competitionType,
                    team2: widget.team2,
                    team1Score: team1Score,
                    team2Score: team2Score,
                    teams: teams,
                    questions: widget.questions,
                    answers: widget.answers,
                  ),
            ),
          );
          return;
        }
        return;
      }

      setState(() {
        _secondsRemaining--;
      });
    });
  }

  void resetQuestion() {
    // Cancel existing timer first
    _timer?.cancel();

    setState(() {
      selectedAnswer = null;
      lastTeamAttempted = null; // This was missing in your setState
      NextQuestion = false;
      buttonsEnabled = false; // Ensure buttons are disabled initially
      team1Color = Colors.white.withOpacity(0.3);
      team2Color = Colors.white.withOpacity(0.3);
      _isTimerPaused = false;
      _secondsRemaining = 25; // Reset timer value
    });

    // Start timer immediately
    startTimer(reset: true);

    // Enable buttons after delay
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          buttonsEnabled = true;
        });
      }
    });
  }

  String? lastTeamAttempted; // track who tried first

  // ----------------------------------------------------------
  // ANSWER LOGIC
  // ----------------------------------------------------------
  // tracks which team already tried this question

  void answerQuestion(String answer) async {
    if (_secondsRemaining == 0 || !mounted) return;

    _timer?.cancel(); // pause timer

    // Ask which team answered
    String? teamSelected = await showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        // Colors and style
        Color dialogBackground = Colors.black.withOpacity(0.9);
        Color buttonColor = Colors.blueAccent;
        Color cancelColor = Colors.redAccent;
        TextStyle buttonTextStyle = GoogleFonts.aBeeZee(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 30,
        );

        // Helper to build styled buttons
        Widget teamButton(String team) {
          return ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: buttonColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            onPressed: () => Navigator.pop(context, team),
            child: Text(team, style: buttonTextStyle),
          );
        }

        return AlertDialog(
          backgroundColor: dialogBackground,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          title: Text(
            "Which team answered?",
            textAlign: TextAlign.center,
            style: GoogleFonts.aBeeZee(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 35,
            ),
          ),
          content: Text(
            "Select the team that answered this question.",
            textAlign: TextAlign.center,
            style: GoogleFonts.aBeeZee(color: Colors.white70, fontSize: 24),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 10,
              children: [
                if (lastTeamAttempted == null) ...[
                  teamButton(team1),
                  teamButton(team2),
                ] else ...[
                  // Second attempt: only show the team that didn't answer yet
                  teamButton(lastTeamAttempted == team1 ? team2 : team1),
                ],
                // Cancel button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: cancelColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: () => Navigator.pop(context, null),
                  child: Text("Cancel", style: buttonTextStyle),
                ),
              ],
            ),
            // First attempt: show both teams
          ],
        );
      },
    );

    if (teamSelected == null) {
      startTimer(); // resume if dismissed
      return;
    }

    bool isTeam1 = teamSelected == widget.team1.TeamName;
    bool isCorrect = answer == widget.answers[index][0];
    setState(() {
      selectedAnswer = answer; // Keep this set to show color
      buttonsEnabled = false;
      if (isCorrect) {
        if (isTeam1) {
          team1Score++;
          team1Color = Colors.green;
        } else {
          team2Score++;
          team2Color = Colors.green;
        }
      } else {
        if (isTeam1) {
          team1Color = Colors.red;
        } else {
          team2Color = Colors.red;
        }
      }
    });

    await Future.delayed(const Duration(seconds: 2));

    if (widget.Draw && isCorrect) {
      navigateToResults();
    }
    if (isCorrect || lastTeamAttempted != null) {
      showNextQuestionButton();
      return;
    } else {
      // First team wrong, let other team try
      lastTeamAttempted = teamSelected;
      // DON'T reset selectedAnswer here either
      setState(() {
        buttonsEnabled = true;
      });
      startTimer();
    }
  }

  void navigateToResults() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder:
            (context) => Onevoneresults(
              team1: widget.team1,
              competition: widget.competitionType,
              team2: widget.team2,
              team1Score: team1Score,
              team2Score: team2Score,
              teams: teams,
              questions: widget.questions,
              answers: widget.answers,
            ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  // ----------------------------------------------------------
  // UI
  // ----------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      // appBar: AppBar(
      //   actions: [
      //     IconButton(
      //       onPressed: () {
      //         Navigator.pushReplacement(
      //           context,
      //           MaterialPageRoute(
      //             builder: (context) {
      //               return DefaultCompetitionStartScreen();
      //             },
      //           ),
      //         );
      //       },
      //       icon: Icon(Icons.arrow_back),
      //     ),
      //   ],
      // ),
      body: Stack(
        children: [
          Lottie.asset(
            "assets/Background.json",
            width: width,
            height: height,
            fit: BoxFit.cover,
          ),
          // the question , answers and scorecards
          Center(
            child: SizedBox(
              width: width > 700 ? double.infinity : width * 0.85,
              child: Column(
                children: [
                  // QUESTION
                  Expanded(
                    child: Center(
                      child: AnimatedSwitcher(
                        duration: Duration(seconds: 1),
                        child: Container(
                          key: ValueKey(shownQuestionTexts[index]),
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: ContainerColor,
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.3),
                              width: 1,
                            ),
                          ),
                          child: Text(
                            shownQuestionTexts[index],
                            textAlign: TextAlign.center,
                            style: GoogleFonts.aBeeZee(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: width > 700 ? 40 : 28,
                            ),
                          ),
                        ),
                        // transitionBuilder: (
                        //   Widget child,
                        //   Animation<double> animation,
                        // ) {
                        //   return ScaleTransition(
                        //     scale: animation,
                        //     child: child,
                        //   );
                        // },
                      ),
                    ),
                  ),

                  // ANSWERS
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: width > 700 ? 300 : 50,
                      ),
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing:
                                  30, // Add spacing between grid items
                              mainAxisSpacing: 20, // Add spacing between rows
                              childAspectRatio:
                                  6, // Adjust this to control button height relative to width
                            ),
                        itemCount:
                            shownAnswers[index]
                                .length, // Use the actual number of answers
                        itemBuilder: (BuildContext context, int answerIndex) {
                          final answer = shownAnswers[index][answerIndex];
                          return SizedBox(
                            width: width > 700 ? width * 0.48 : width * 0.85,
                            // Remove fixed height or adjust as needed
                            child: ElevatedButton(
                              style: ButtonStyle(
                                elevation: MaterialStateProperty.all(0),
                                backgroundColor:
                                    MaterialStateProperty.resolveWith((states) {
                                      if (answer == selectedAnswer) {
                                        bool isCorrect =
                                            answer == widget.answers[index][0];
                                        return isCorrect
                                            ? Colors.green.withOpacity(0.8)
                                            : Colors.red.withOpacity(0.8);
                                      }
                                      if (states.contains(
                                        MaterialState.disabled,
                                      )) {
                                        return DarkMode
                                            ? Colors.black.withOpacity(0.2)
                                            : Colors.blueGrey.withOpacity(0.3);
                                      }
                                      return ContainerColor;
                                    }),
                                foregroundColor:
                                    MaterialStateProperty.resolveWith((states) {
                                      if (states.contains(
                                        MaterialState.disabled,
                                      )) {
                                        return Colors.white.withOpacity(0.5);
                                      }
                                      return Colors.white;
                                    }),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    side: BorderSide(
                                      color: Colors.white.withOpacity(0.3),
                                      width: 1,
                                    ),
                                  ),
                                ),
                              ),
                              onPressed:
                                  buttonsEnabled
                                      ? () => answerQuestion(answer)
                                      : null,
                              child: AnimatedSwitcher(
                                duration: Duration(seconds: 1),
                                child: Text(
                                  answer,
                                  key: ValueKey(answer),
                                  style: GoogleFonts.aBeeZee(
                                    fontWeight: FontWeight.w500,
                                    fontSize: width > 700 ? 25 : 18,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  width > 700 ? Container() : SizedBox(height: 100),
                  // SCORE + TIMER
                  width > 700
                      ? Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: width * 0.08,
                          vertical: width * 0.005,
                        ),
                        child: Row(
                          children: [
                            SizedBox(width: 150),
                            buildScoreCard(widget.team1, team1Score, width, 1),

                            SizedBox(width: 150),
                            // option1
                            Container(
                              decoration: BoxDecoration(
                                color: ContainerColor,
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.3),
                                  width: 1,
                                ),
                              ),
                              child: SizedBox(
                                width: width > 600 ? 0.09 * width : 100,
                                height: width > 600 ? 0.09 * width : 100,
                                child: Center(
                                  child: Text(
                                    "$_secondsRemaining",
                                    style: GoogleFonts.aBeeZee(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: width > 700 ? 90 : 40,
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            //option2
                            // IconButton(
                            //   icon: Icon(
                            //     Icons.refresh,
                            //     color: Colors.white,
                            //     size: 100,
                            //   ),
                            //   onPressed: () {
                            //     setState(() {
                            //       _isTimerPaused = false;
                            //       _timer?.cancel();
                            //       _secondsRemaining = 25;
                            //       startTimer();
                            //     });
                            //   },
                            // ),
                            // SizedBox(width: 50),
                            // Container(
                            //   decoration: BoxDecoration(
                            //     color: ContainerColor,
                            //     borderRadius: BorderRadius.circular(50),
                            //     border: Border.all(
                            //       color: Colors.white.withOpacity(0.3),
                            //       width: 1,
                            //     ),
                            //   ),
                            //   child: SizedBox(
                            //     width: width > 600 ? 0.11 * width : 100,
                            //     height: width > 600 ? 0.11 * width : 100,
                            //     child: MouseRegion(
                            //       onEnter: (_) {
                            //         setState(() {
                            //           _isHoveringOnTimer = true;
                            //         });
                            //       },
                            //       onExit: (_) {
                            //         setState(() {
                            //           _isHoveringOnTimer = false;
                            //         });
                            //       },
                            //       child: Stack(
                            //         alignment: Alignment.center,
                            //         children: [
                            //           if (_isHoveringOnTimer &&
                            //               !NextQuestion)
                            //             IconButton(
                            //               icon: Icon(
                            //                 _isTimerPaused
                            //                     ? Icons.play_arrow
                            //                     : Icons.pause,
                            //                 color: Colors.white,
                            //                 size: 100,
                            //               ),
                            //               onPressed: () {
                            //                 setState(() {
                            //                   _isTimerPaused =
                            //                       !_isTimerPaused;
                            //                   if (_isTimerPaused) {
                            //                     _timer?.cancel();
                            //                   } else {
                            //                     startTimer();
                            //                   }
                            //                 });
                            //               },
                            //             )
                            //           else
                            //             Text(
                            //               "$_secondsRemaining",
                            //               style: GoogleFonts.aBeeZee(
                            //                 color: Colors.white,
                            //                 fontWeight: FontWeight.bold,
                            //                 fontSize: width > 700 ? 90 : 40,
                            //               ),
                            //             ),
                            //           // Hover Controls
                            //         ],
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            // SizedBox(width: 50),
                            // IconButton(
                            //   icon: Icon(
                            //     Icons.skip_next,
                            //     size: 100,
                            //     color: Colors.white,
                            //   ),
                            //   onPressed: () {
                            //     index++;

                            //     if (index >= question.length) {
                            //       navigateToResults();
                            //       return;
                            //     }

                            //     // IMPORTANT FIX
                            //     lastTeamAttempted = null;

                            //     NextQuestion = false;
                            //     loadNextQuestion();
                            //     startTimer(reset: true);
                            //   },
                            // ),
                            SizedBox(width: 150),
                            buildScoreCard(widget.team2, team2Score, width, 2),
                            SizedBox(width: 150),
                          ],
                        ),
                      )
                      : Row(
                        children: [
                          buildScoreCard(widget.team1, team1Score, width, 1),

                          const Spacer(),

                          Container(
                            decoration: BoxDecoration(
                              color: ContainerColor,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: SizedBox(
                              width: width > 600 ? 0.11 * width : 100,
                              height: width > 600 ? 0.11 * width : 100,
                              child: Center(
                                child: Text(
                                  "$_secondsRemaining",
                                  style: GoogleFonts.aBeeZee(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: width > 700 ? 90 : 40,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          const Spacer(),

                          buildScoreCard(widget.team2, team2Score, width, 2),
                        ],
                      ),
                  SizedBox(height: width > 700 ? height * 0.1 : height * 0.05),
                ],
              ),
            ),
          ),

          // the go back bottom on the corner
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Leaderboardscreen(teams: teams),
                      ),
                    );
                  },
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                ),
              ),
            ],
          ),

          //option1
          // the tools on the bottom
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: height,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Add this after the refresh button or before the skip button
                  Container(
                    decoration: BoxDecoration(
                      color: ContainerColor,
                      borderRadius: BorderRadius.circular(60),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.skip_previous,
                        size: 80,
                        color: Colors.white,
                      ), // or Icons.arrow_back
                      onPressed: goToPreviousQuestion, // Create this method
                    ),
                  ),

                  SizedBox(width: 50),
                  Container(
                    decoration: BoxDecoration(
                      color: ContainerColor,
                      borderRadius: BorderRadius.circular(60),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: IconButton(
                      icon: Icon(
                        _isTimerPaused ? Icons.play_arrow : Icons.pause,
                        color: Colors.white,
                        size: 80,
                      ),
                      onPressed: () {
                        setState(() {
                          _isTimerPaused = !_isTimerPaused;
                          if (_isTimerPaused) {
                            _timer?.cancel();
                          } else {
                            startTimer();
                          }
                        });
                      },
                    ),
                  ),
                  // Container(
                  //   decoration: BoxDecoration(
                  //     color: ContainerColor,
                  //     borderRadius: BorderRadius.circular(50),
                  //     border: Border.all(
                  //       color: Colors.white.withOpacity(0.3),
                  //       width: 1,
                  //     ),
                  //   ),
                  //   child: MouseRegion(
                  //     onEnter: (_) {
                  //       setState(() {
                  //         _isHoveringOnTimer = true;
                  //       });
                  //     },
                  //     onExit: (_) {
                  //       setState(() {
                  //         _isHoveringOnTimer = false;
                  //       });
                  //     },
                  //     child: Stack(
                  //       alignment: Alignment.center,
                  //       children: [
                  //         if (_isHoveringOnTimer &&
                  //             !NextQuestion)

                  //         else
                  //           Text(
                  //             "$_secondsRemaining",
                  //             style: GoogleFonts.aBeeZee(
                  //               color: Colors.white,
                  //               fontWeight: FontWeight.bold,
                  //               fontSize: width > 700 ? 90 : 40,
                  //             ),
                  //           ),
                  //         // Hover Controls
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  SizedBox(width: 50),
                  Container(
                    decoration: BoxDecoration(
                      color: ContainerColor,
                      borderRadius: BorderRadius.circular(60),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.skip_next,
                        size: 80,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        index++;

                        if (index >= shownQuestionTexts.length) {
                          navigateToResults();
                          return;
                        }

                        // IMPORTANT FIX
                        lastTeamAttempted = null;

                        NextQuestion = false;
                        loadNextQuestion();
                        startTimer(reset: true);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ----------------------------------------------------------
  // HELPERS
  // ----------------------------------------------------------
  Widget buildScoreCard(Team team, int score, double width, int number) {
    return width > 700
        ? Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: ContainerColor,
              borderRadius: BorderRadius.circular(25),
              border: Border.all(
                color: number == 1 ? team1Color : team2Color,
                width: 10,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: FittedBox(
                    child: Text(
                      team.TeamName,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.aBeeZee(
                        color: Colors.white,
                        fontSize: 35,
                      ),
                    ),
                  ),
                ),
                Divider(),
                AnimatedSwitcher(
                  duration: Duration(milliseconds: 300),
                  transitionBuilder:
                      (child, animation) =>
                          ScaleTransition(scale: animation, child: child),
                  child: Text(
                    "$score",
                    key: ValueKey(score),
                    style: GoogleFonts.aBeeZee(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 75,
                    ),
                  ),
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: buildToolIcon(
                        icon: Icons.people,
                        used: team.helpingTools[0],
                        onTap:
                            !team.helpingTools[0]
                                ? () {
                                  setState(() {
                                    team.useHelpingTool(0);
                                  });

                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                        ),
                                        backgroundColor: const Color.fromARGB(
                                          154,
                                          0,
                                          0,
                                          0,
                                        ),
                                        content: Padding(
                                          padding: const EdgeInsets.all(20),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              CircleAvatar(
                                                radius: 100,
                                                backgroundColor: Color(
                                                  0xFF4FC3F7,
                                                ),
                                                child: Icon(
                                                  Icons.people,
                                                  size: 105,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              SizedBox(height: 35),
                                              Text(
                                                "Ask The Audience",
                                                style: TextStyle(
                                                  fontSize: 50,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                              SizedBox(height: 20, width: 130),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                }
                                : null,
                        color: Color(0xFF4FC3F7), // Light Blue
                      ),
                    ),

                    buildToolIcon(
                      icon: Icons.refresh,
                      used: team.helpingTools[1],
                      onTap:
                          !team.helpingTools[1]
                              ? () {
                                setState(() {
                                  resetQuestion();
                                  team.useHelpingTool(1);
                                });
                              }
                              : null,
                      color: Color(0xFFFFB74D),
                    ),
                    buildToolIcon(
                      icon: Icons.person,
                      used: team.helpingTools[2],
                      onTap:
                          !team.helpingTools[2]
                              ? () {
                                setState(() {
                                  team.useHelpingTool(2);
                                });
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      backgroundColor: const Color.fromARGB(
                                        154,
                                        0,
                                        0,
                                        0,
                                      ),
                                      content: Padding(
                                        padding: const EdgeInsets.all(20),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            CircleAvatar(
                                              radius: 100,
                                              backgroundColor: Color(
                                                0xFFFF6F61,
                                              ),
                                              child: Icon(
                                                Icons.person,
                                                size: 105,
                                                color: Colors.black,
                                              ),
                                            ),
                                            SizedBox(height: 35),
                                            Text(
                                              "Ask A Doctor",
                                              style: TextStyle(
                                                fontSize: 50,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              }
                              : null,
                      color: Color(0xFFFF6F61),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
        : Container(
          width: 100,
          decoration: BoxDecoration(
            color: ContainerColor,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Text(
                  team.TeamName,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.aBeeZee(
                    color: Colors.white,
                    fontSize: width > 700 ? 35 : 20,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Text(
                "$score",
                textAlign: TextAlign.center,
                style: GoogleFonts.aBeeZee(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: width > 700 ? 80 : 40,
                ),
              ),
            ],
          ),
        );
  }

  Widget buildToolIcon({
    required IconData icon,
    required bool used,
    required VoidCallback? onTap,
    required Color color,
  }) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: used ? null : onTap,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          margin: EdgeInsets.symmetric(horizontal: 8),
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: used ? Colors.white24 : color,
            boxShadow:
                used
                    ? []
                    : [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
          ),
          child: Icon(
            icon,
            color: used ? Colors.white54 : Colors.black87,
            size: 40,
          ),
        ),
      ),
    );
  }

  // Widget buildScoreCardThereTurn(
  //   String team,
  //   int score,
  //   Color color,
  //   double width,
  // ) {
  //   return width > 700
  //       ? Expanded(
  //         child: Container(
  //           decoration: BoxDecoration(
  //             border: Border.all(color: color, width: 10),
  //             color: ContainerColor,
  //             borderRadius: BorderRadius.circular(25),
  //           ),
  //           child: Column(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               Padding(
  //                 padding: const EdgeInsets.symmetric(horizontal: 18),
  //                 child: FittedBox(
  //                   child: Text(
  //                     team,
  //                     textAlign: TextAlign.center,
  //                     style: GoogleFonts.aBeeZee(
  //                       color: Colors.white,
  //                       fontSize: 35,
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //               const SizedBox(height: 5),
  //               Text(
  //                 "$score",
  //                 textAlign: TextAlign.center,
  //                 style: GoogleFonts.aBeeZee(
  //                   color: Colors.white,
  //                   fontWeight: FontWeight.bold,
  //                   fontSize: 80,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       )
  //       : Container(
  //         width: 100,
  //         decoration: BoxDecoration(
  //           border: Border.all(color: color, width: 6),
  //           color: ContainerColor,
  //           borderRadius: BorderRadius.circular(25),
  //         ),
  //         child: Column(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             Text(
  //               team,
  //               textAlign: TextAlign.center,
  //               style: GoogleFonts.aBeeZee(
  //                 color: Colors.white,
  //                 fontSize: width > 700 ? 35 : 20,
  //               ),
  //             ),
  //             const SizedBox(height: 5),
  //             Text(
  //               "$score",
  //               style: GoogleFonts.aBeeZee(
  //                 color: Colors.white,
  //                 fontWeight: FontWeight.bold,
  //                 fontSize: width > 700 ? 80 : 40,
  //               ),
  //             ),
  //           ],
  //         ),
  //       );
  // }
}
