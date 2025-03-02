import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class OversContainer extends StatelessWidget {
  final dynamic overNumber; // It can be a number or a string, depending on your data
  final Map<String, dynamic> data;

  OversContainer({super.key, required this.overNumber, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10),
        const Divider(color: Colors.grey,),
        Row(
          children: [
            Expanded(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.2,
                color: Colors.grey[300],
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Over $overNumber", style: GoogleFonts.getFont('Poppins', color: Colors.black, fontSize: 14),),
                      Text("${data['totalRun']} Runs", style: GoogleFonts.getFont('Poppins', color: Colors.grey, fontSize: 14),),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.2,
                color: Colors.grey[300],
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("${data['msg']}", style: GoogleFonts.getFont('Poppins', color: Colors.black, fontSize: 14),),
                      SizedBox(
                        width: double.infinity,
                        height: 40,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: data['overballs'].length,
                          itemBuilder: (context, index) {
                            final balls = data['overballs'][index];
                            return _buildCurrentBallStatusContainer(runsInBall: balls);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget _buildCurrentBallStatusContainer({required String runsInBall}) {
    Color color;
    switch (runsInBall) {
      case '4':
      case '5':
        color = Colors.orange;
        break;
      case '6':
        color = Colors.green;
        break;
      case 'Wk':
        color = Colors.red;
        break;
      default:
        color = Colors.white;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3.0),
      child: Container(
        height: 25,
        width: 25,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            runsInBall,
            style: GoogleFonts.getFont('Poppins', color: color == Colors.white ? Colors.black : Colors.white, fontSize: 12),
          ),
        ),
      ),
    );
  }
}