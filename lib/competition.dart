import 'package:codit_competition/screens/start_screen.dart';
import 'package:flutter/material.dart';

class Competition extends StatefulWidget {
  const Competition({super.key});

  @override
  State<Competition> createState() => _CompetitionState();
}

class _CompetitionState extends State<Competition> {
  late Widget activeScreen;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    activeScreen = StartScreen();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

enum Screens { StartScreen, CompetitionScreen, ResultsScreen, LoadScreen }
