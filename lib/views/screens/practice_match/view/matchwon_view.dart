import 'dart:math';
import 'package:confetti/confetti.dart';
import 'package:cricyard/core/app_export.dart';
import 'package:cricyard/views/screens/practice_match/view/practice_match_home_View.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MatchWonView extends StatefulWidget {
  final String winningTeam;
  final String msg;
  const MatchWonView({super.key, required this.winningTeam, required this.msg});

  @override
  State<MatchWonView> createState() => _MatchWonViewState();
}

class _MatchWonViewState extends State<MatchWonView> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 6));
    _confettiController.play();
    Future.delayed(const Duration(seconds: 6)).then(
      (value) => Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => PracticeMatchHomeScreen(),
          )),
    );
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              blastDirection: pi / 2,
              gravity: 0.5,
              shouldLoop: false,
              emissionFrequency: 0.2,
              colors: const [
                Colors.red,
                Colors.blue,
                Colors.green,
                Colors.yellow,
                Colors.orange,
                Colors.purple,
                Colors.orangeAccent,
                Colors.deepPurple,
                Colors.pinkAccent
              ],
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Congratulations",
                  style: GoogleFonts.getFont('Poppins',
                      color: Colors.black,
                      fontSize: 36,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: Image.asset(ImageConstant.imgAward),
                ),
                const SizedBox(height: 10),
                Text(
                  widget.winningTeam,
                  style: GoogleFonts.getFont('Poppins',
                      color: Colors.black,
                      fontSize: 32,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 40),
                Text(
                  widget.msg,
                  style: GoogleFonts.getFont('Poppins',
                      color: Colors.black, fontSize: 22),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
