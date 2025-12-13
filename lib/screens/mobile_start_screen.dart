import 'package:codit_competition/Trivia/teams.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import 'InitialiseUsers.dart';

class MobileStartScreen extends StatefulWidget {
  const MobileStartScreen({super.key});

  @override
  State<MobileStartScreen> createState() => _MobileStartScreenState();
}

class _MobileStartScreenState extends State<MobileStartScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation1;
  late Animation<Color?> _colorAnimation2;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat(reverse: true);

    // Dark-themed colors
    _colorAnimation1 = ColorTween(
      begin: Colors.black,
      end: Colors.deepPurple.shade900,
    ).animate(_controller);
    _colorAnimation2 = ColorTween(
      begin: Colors.indigo.shade900,
      end: Colors.black87,
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Scaffold(
          body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [_colorAnimation1.value!, _colorAnimation2.value!],
              ),
            ),
            child: child,
          ),
          backgroundColor: Colors.transparent,
        );
      },
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // spacing: 20,
          children: [
            Text(
              "Competition Start Screen",
              textAlign: TextAlign.center,
              style: GoogleFonts.aBeeZee(
                fontSize: width > 700 ? 70 : 35,
                color: Colors.white,
              ),
            ),
            SizedBox(height: width > 700 ? height * 0.2 : height * 0.08),
            SizedBox(
              width: 1000,
              child:
                  width > 800
                      ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          teamButton(
                            context,
                            Club.Code_it,
                            Lottie.asset("assets/ComputerScience2.json"),
                            TeamInputScreen(competition: Club.Code_it),

                            width,
                          ),
                          const Spacer(),
                          teamButton(
                            context,
                            Club.MUBC,
                            Lottie.asset("assets/ComputerScience2.json"),
                            TeamInputScreen(competition: Club.MUBC),
                            width,
                          ),
                        ],
                      )
                      : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 40,
                        children: [
                          teamButton(
                            context,
                            Club.Code_it,
                            Lottie.asset("assets/ComputerScience2.json"),
                            TeamInputScreen(competition: Club.Code_it),
                            width,
                          ),

                          teamButton(
                            context,
                            Club.MUBC,
                            Lottie.asset("assets/Business.json"),
                            TeamInputScreen(competition: Club.MUBC),
                            width,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            spacing: 9,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    width > 700 ? 150 : 60,
                                  ),
                                ),
                                width: width > 700 ? 300 : 120,
                                height: width > 700 ? 300 : 120,
                                child: IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return TeamInputScreen(
                                            competition: Club.Mix,
                                          );
                                        },
                                      ),
                                    );
                                  },
                                  icon: ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                      10,
                                    ), // optional: rounded corners
                                    child: Image.asset(
                                      "assets/CSvsBusiness.png",
                                      fit: BoxFit.fitHeight,
                                      height:
                                          200, // fills the square and crops if necessary
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                clubName[Club.Mix]!,
                                style: GoogleFonts.aBeeZee(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: width > 700 ? 30 : 20,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
            ),
          ],
        ),
      ),
    );
  }

  Column teamButton(
    BuildContext context,
    Club title,
    Widget image,
    Widget target,
    double width,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 10,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(width > 700 ? 150 : 60),
            border: Border.all(color: Colors.white, width: width > 700 ? 5 : 2),
          ),
          width: width > 700 ? 300 : 120,
          height: width > 700 ? 300 : 120,
          child: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return target;
                  },
                ),
              );
            },
            icon: image,
          ),
        ),
        Text(
          clubName[title]!,
          style: GoogleFonts.aBeeZee(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: width > 700 ? 30 : 20,
          ),
        ),
      ],
    );
  }
}

Map<Club, String> clubName = {
  Club.Code_it: "Code_it;",
  Club.MUBC: "MUBC",
  Club.Mix: "General Questions",
};
