import 'package:cricyard/views/screens/MenuScreen/Matches/scoring/scoreboard_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../Entity/runs/Score_board/repository/Score_board_api_service.dart';

class ShowRetireAndMoreFrag {
  final score_boardApiService scoreservice = score_boardApiService();
  FocusNode _strikerFocusNode = FocusNode();
  FocusNode _nonStrikerFocusNode = FocusNode();
  FocusNode _bowlerFocusNode = FocusNode();

  // Strike Rotation
  Future<void> strikeRotation(int tourId, scoreboard, BuildContext context, matchId, inning, striker, nonStriker, baller) async {
    print("Rotate Strike, called");
    await scoreservice.strikerotation(tourId, scoreboard,).then((value) async {
      print("Striker-- $striker");
      print("nonStriker-- $nonStriker");
      print("baller-- $baller");
      showSnackBar(context, 'Success', Colors.green);

      },
    );
  }

  Future<void> showRetireAndMoreDialog(BuildContext ctx, String type, List<Map<String, dynamic>> bowlingTeamPlayers, List<Map<String, dynamic>> battingTeamPlayers, String striker, String nonStriker, String baller, lastRecord, tourId, matchId, inning,) async {

    print("Striker-- $striker");
    print("nonStriker-- $nonStriker");
    print("baller-- $baller");

    var option = '';
    String? selectedOption = await showDialog<String>(
      context: ctx,
      builder: (BuildContext context) {
        String? tempSelectedOption;
        bool showNewPlayerOptions = false;
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: Text(
                  type == 'more' ? 'Select option' : 'Select Retire Option'),
              content: IntrinsicHeight(
                child: Column(
                  children: type == 'more' && !showNewPlayerOptions
                      ? [
                          // Rotate strike button
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: SizedBox(
                              height: 35.0,
                              width: 170,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF264653),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                onPressed: () {
                                  strikeRotation(
                                      tourId,
                                      lastRecord,
                                      context,
                                      matchId,
                                      inning,
                                      striker,
                                      nonStriker,
                                      baller);
                                  Navigator.pop(context);
                                },
                                child: Center(
                                  child: Text(
                                    'Rotate Strike',
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // New player entry button
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: SizedBox(
                              height: 35.0,
                              width: 170,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF264653),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                onPressed: () {
                                  setState(() {
                                    showNewPlayerOptions = true;
                                  });
                                },
                                child: Center(
                                  child: Text(
                                    'New player entry',
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ]
                      : [
                          // Radio list tiles for selecting the retiring player
                          RadioListTile<String>(
                            title: Text(
                              striker,
                              style: const TextStyle(color: Colors.black),
                            ),
                            value: striker,
                            groupValue: tempSelectedOption,
                            onChanged: (value) {
                              setState(() {
                                tempSelectedOption = value;
                                option = 'striker';
                              });
                            },
                          ),
                          RadioListTile<String>(
                            title: Text(
                              nonStriker,
                              style: const TextStyle(color: Colors.black),
                            ),
                            value: nonStriker,
                            groupValue: tempSelectedOption,
                            onChanged: (value) {
                              setState(() {
                                tempSelectedOption = value;
                                option = 'nonStriker';
                              });
                            },
                          ),
                          type == 'more'
                              ? RadioListTile<String>(
                                  title: Text(
                                    baller,
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                  value: baller,
                                  groupValue: tempSelectedOption,
                                  onChanged: (value) {
                                    setState(() {
                                      tempSelectedOption = value;
                                      option = 'baller';
                                    });
                                  },
                                )
                              : Container()
                        ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop(tempSelectedOption);
                  },
                ),
              ],
            );
          },
        );
      },
    );

    if (selectedOption != null) {
      showNewBatsmanDialog(ctx, option, bowlingTeamPlayers, battingTeamPlayers, lastRecord, tourId, matchId, inning, striker, nonStriker, baller);
    }
  }

  Future<void> showNewBatsmanDialog(BuildContext context, String tempSelectedOption, List<Map<String, dynamic>> bowlingTeamPlayers, List<Map<String, dynamic>> battingTeamPlayers, lastRecord, tourId, matchId, inning, striker, nonStriker, baller) async {
    TextEditingController dialogController = TextEditingController();
    ValueNotifier<String?> selectedPlayerId = ValueNotifier<String?>(null);
    ValueNotifier<bool> hasError = ValueNotifier<bool>(false);

   await showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return StatefulBuilder(
          builder: (BuildContext ctx, StateSetter setState) {
            return AlertDialog(
              title: Text('Enter new player for $tempSelectedOption'),
              content: tempSelectedOption == 'baller'
                  ? _buildAutocompleteTextField(
                      dialogController,
                      'Select new bowler',
                      _bowlerFocusNode,
                      bowlingTeamPlayers
                          .where((element) => element['name'] != null)
                          .toList(),
                      selectedPlayerId,
                      hasError)
                  : tempSelectedOption == 'striker'
                      ? _buildAutocompleteTextField(
                          dialogController,
                          'Select Striker',
                          _strikerFocusNode,
                          battingTeamPlayers,
                          selectedPlayerId,
                          hasError)
                      : _buildAutocompleteTextField(
                          dialogController,
                          'Select non-striker',
                          _nonStrikerFocusNode,
                          battingTeamPlayers,
                          selectedPlayerId,
                          hasError),
              actions: [
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  onPressed: () async {
                    if (selectedPlayerId.value == null) {
                      setState(() {
                        hasError.value = true;
                      });
                      return;
                    }
                   // Navigator.pop(context);
                    String playerId = selectedPlayerId.value!;
                    String type = '';
                    if (tempSelectedOption == 'baller') {
                      type = 'Baller';
                    } else if (tempSelectedOption == 'striker') {
                      type = 'batsman';
                    } else {
                      type = 'batsman';
                    }

                    print("NewPlayerEntry");
                    print("Type--$type");
                    print("PlayerID--$playerId");
                    print("tempOption--$tempSelectedOption");
                    print("lastRec--$lastRecord");

                    try {
                      await scoreservice.newPlayerEntry(tourId, type, int.parse(playerId), tempSelectedOption, lastRecord).then(
                        (_){
                           ScoreBoardManager(inning, striker, nonStriker, baller, tournamentId: tourId, matchId: matchId).updateAllData(context)
                              .then(
                            (value) {
                              Navigator.pop(context);
                              showSnackBar(context, 'Success', Colors.green);
                            },
                          );
                          //getLastRecord();
                        },
                      );
                    } catch (e) {
                      showSnackBar(context, 'Error $e', Colors.red);
                    }
                  },
                  child: const Text('Confirm'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildAutocompleteTextField(TextEditingController controller, String label, FocusNode focusNode, List<Map<String, dynamic>> data, ValueNotifier<String?> selectedPlayerId, ValueNotifier<bool> hasError) {
    return ValueListenableBuilder<bool>(
      valueListenable: hasError,
      builder: (context, error, child) {
        String? errorMessage = error ? 'Please select a valid option.' : null;
        return Autocomplete<String>(
          optionsBuilder: (TextEditingValue textEditingValue) {
            if (textEditingValue.text.isEmpty) {
              return data.map((player) => player['player_name'] as String);
            }
            return data
                .where((player) => player['player_name']
                    .toLowerCase()
                    .contains(textEditingValue.text.toLowerCase()))
                .map((player) => player['player_name'] as String);
          },
          onSelected: (String selection) {
            controller.text = selection;
            final player =
                data.firstWhere((player) => player['player_name'] == selection);
            print(
                "Selected player: ${player['player_name']}, ID: ${player['id']}"); // Debug line
            selectedPlayerId.value =
                player['id'].toString(); // Ensure this is a string
            hasError.value = false;
          },
          fieldViewBuilder: (BuildContext context,
              TextEditingController textEditingController,
              FocusNode fieldFocusNode,
              VoidCallback onFieldSubmitted) {
            textEditingController.text = controller.text;
            textEditingController.addListener(() {
              controller.text = textEditingController.text;
            });
            return TextField(
              controller: textEditingController,
              focusNode: fieldFocusNode,
              decoration: InputDecoration(
                labelText: label,
                errorText: errorMessage,
                errorStyle: const TextStyle(
                  color: Colors.red,
                  fontSize: 12,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: error ? Colors.red : Colors.blue,
                    width: 2,
                  ),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 2),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
              style: const TextStyle(color: Colors.black),
            );
          },
          optionsViewBuilder: (BuildContext context,
              AutocompleteOnSelected<String> onSelected,
              Iterable<String> options) {
            return Align(
              alignment: Alignment.topLeft,
              child: Material(
                elevation: 4.0,
                child: Container(
                  height: 160,
                  color: Colors.white,
                  width: 300.0,
                  child: ListView.builder(
                    padding: const EdgeInsets.all(0.0),
                    itemCount: options.length,
                    itemBuilder: (BuildContext context, int index) {
                      final String option = options.elementAt(index);
                      return ListTile(
                        title: Text(
                          option,
                          style: const TextStyle(color: Colors.black),
                        ),
                        onTap: () {
                          onSelected(option);
                          final player = data.firstWhere(
                              (player) => player['player_name'] == option);
                          print(
                              "Tapped player: ${player['player_name']}, ID: ${player['id']}"); // Debug line
                          selectedPlayerId.value = player['id']
                              .toString(); // Ensure this is a string
                          hasError.value = false;
                        },
                      );
                    },
                  ),
                ),
              ),
            );
          },
        );
      },
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
