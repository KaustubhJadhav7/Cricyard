import 'package:cricyard/Entity/runs/Score_board/repository/Score_board_api_service.dart';
import 'package:cricyard/views/screens/MenuScreen/Matches/scoring/scoreboard_manager.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ShowWideDetailsFrag {
  score_boardApiService scoreservice = score_boardApiService();

  Future<void> showWideDialog(BuildContext ctx, type, matchId, inning, lastRec,
      tourId, striker, nonStriker, baller) async {
    print("showWide details function called");
    // Show dialog with options
    String? selectedOption = await showDialog<String>(
      context: ctx,
      builder: (_) {
        if (type == 'wide') {
          return AlertDialog(
            title: const Text('Select Wide Option'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildOptionButton(ctx, 'WD+0', '0'),
                _buildOptionButton(ctx, 'WD+1', '1'),
                _buildOptionButton(ctx, 'WD+2', '2'),
                _buildOptionButton(ctx, 'WD+3', '3'),
                _buildOptionButton(ctx, 'WD+4', '4'),
                _buildOptionButton(ctx, 'WD+6', '6'),

                // Add more option buttons as needed
              ],
            ),
          );
        }
        if (type == 'NoBall') {
          return AlertDialog(
            title: const Text('Select No Ball Option'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildOptionButton(ctx, 'NB+0', '0'),
                _buildOptionButton(ctx, 'NB+1', '1'),
                _buildOptionButton(ctx, 'NB+2', '2'),
                _buildOptionButton(ctx, 'NB+3', '3'),
                _buildOptionButton(ctx, 'NB+4', '4'),
                _buildOptionButton(ctx, 'NB+6', '6'),

                // Add more option buttons as needed
              ],
            ),
          );
        }
        if (type == 'LegBy') {
          return AlertDialog(
            title: const Text('Select LegBy Option'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildOptionButton(ctx, 'LB+0', '0'),
                _buildOptionButton(ctx, 'LB+1', '1'),
                _buildOptionButton(ctx, 'LB+2', '2'),
                _buildOptionButton(ctx, 'LB+3', '3'),
                _buildOptionButton(ctx, 'LB+4', '4'),
                _buildOptionButton(ctx, 'LB+5', '5'),
                _buildOptionButton(ctx, 'LB+6', '6'),

                // Add more option buttons as needed
              ],
            ),
          );
        }
        return AlertDialog(
          title: const Text('Select Bye Option'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildOptionButton(ctx, 'BYE+0', '0'),
              _buildOptionButton(ctx, 'BYE+1', '1'),
              _buildOptionButton(ctx, 'BYE+2', '2'),
              _buildOptionButton(ctx, 'BYE+3', '3'),
              _buildOptionButton(ctx, 'BYE+4', '4'),
              _buildOptionButton(ctx, 'BYE+5', '5'),
              _buildOptionButton(ctx, 'BYE+6', '6'),

              // Add more option buttons as needed
            ],
          ),
        );
      },
    );
    if (selectedOption != null) {
      await _handleSelectedOption(selectedOption, type, ctx, matchId, inning,
          lastRec, tourId, striker, nonStriker, baller);
    }
  }

  Future<void> _handleSelectedOption(
      String option,
      String type,
      BuildContext context,
      int matchId,
      int inning,
      Map<String, dynamic> lastRecord,
      tourId,
      striker,
      nonStriker,
      baller) async {
    print("handel option called");
    print(
        'Details---$type \n Runs- $option\n matchid- $matchId\n innings-$inning');
    try {
      await scoreservice
          .postWideExtra(type, int.parse(option), matchId, inning, lastRecord)
          .then((_) async {
        await ScoreBoardManager(inning, striker, nonStriker, baller,
                tournamentId: tourId, matchId: matchId)
            .updateAllData(context)
            .then(
          (value) {
            showSnackBar(context, 'Success updated $type with $option runs',
                Colors.green);
          },
        );
      }); // type == wide , nb,lb etc // option will be runs
    } catch (error) {
      showSnackBar(
          context, 'Error!! updating $type with $option runs', Colors.red);
      // Handle error (e.g., show an error message, log the error, etc.)
    }
  }

  Widget _buildOptionButton(BuildContext context, String text, String option) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SizedBox(
        height: 35.0,
        width: 170, // Set a fixed height for the buttons
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF264653),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          onPressed: () => Navigator.of(context).pop(option),
          child: Center(
            child: Text(
              text,
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showSnackBar(BuildContext context, String msg, Color color) {
    final mediaQuery = MediaQuery.of(context);
    final topPadding = mediaQuery.viewPadding.bottom;
    const snackBarHeight = 50.0; // Approximate height of SnackBar

    final topMargin = topPadding + snackBarHeight + 700; // Add some padding

    SnackBar snackBar = SnackBar(
      margin: EdgeInsets.only(bottom: topMargin, left: 16.0, right: 16.0),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors
          .transparent, // Make background transparent to show custom design
      elevation: 0, // Remove default elevation to apply custom shadow
      content: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [color.withOpacity(0.8), color],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  offset: Offset(0, 4),
                  blurRadius: 10.0,
                ),
              ],
            ),
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                const Icon(
                  Icons.info_rounded,
                  color: Colors.white,
                  size: 28.0, // Slightly larger icon
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    msg,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 16.0, // Slightly larger text
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  },
                ),
              ],
            ),
          ),
          Positioned(
            left: -15,
            top: -15,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: color.withOpacity(0.5),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            right: -10,
            bottom: -10,
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: color.withOpacity(0.5),
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
