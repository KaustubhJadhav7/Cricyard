// ignore_for_file: use_build_context_synchronously

import 'package:cricyard/views/screens/MenuScreen/Football/Scorecard/footballMatchScore.dart';
import 'package:cricyard/views/screens/MenuScreen/new_dash/Newdashboard.dart';
import 'package:cricyard/views/screens/practice_match/view/create_practice_match_view.dart';
import 'package:cricyard/views/screens/practice_match/view/practice_history_view.dart';
import 'package:cricyard/views/screens/practice_match/view/practice_teams_view.dart';
import 'package:cricyard/views/screens/practice_match/viewmodel/practice_matchview_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../practice_match/PracticeMatchScoreScreen.dart';

class CreateFootballPracticeMatch extends StatefulWidget {
  const CreateFootballPracticeMatch({super.key});

  @override
  State<CreateFootballPracticeMatch> createState() =>
      _CreateFootballPracticeMatchState();
}

class _CreateFootballPracticeMatchState extends State<CreateFootballPracticeMatch> {
  TextEditingController _hostTeamController = TextEditingController();
  TextEditingController _awayTeamController = TextEditingController();
  
  

  
  FocusNode _hostFocusNode = FocusNode();
  FocusNode _awayFocusNode = FocusNode();

  String selectedOption = 'Host';
  String selectedOptedOption = 'Bat';

  List<String> dummyPlayers = ['Team1', 'Team2', 'Team3'];

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    Provider.of<PracticeMatchviewModel>(context, listen: false).getAllTeam();
    _hostTeamController.addListener(_updateHostRadio);
    _awayTeamController.addListener(_updateAwayRadio);
  }

  @override
  void dispose() {
    _hostTeamController.dispose();
    _awayTeamController.dispose();
    _hostFocusNode.dispose();
    _awayFocusNode.dispose();
    super.dispose();
  }

  void _updateHostRadio() {
    setState(() {
      selectedOption = _hostTeamController
          .text; // Whenever host team text changes, select the host radio
    });
  }

  void _updateAwayRadio() {
    setState(() {
      selectedOption = _awayTeamController
          .text; // Whenever visitor team text changes, select the visitor radio
    });
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

  void _submitForm(PracticeMatchviewModel model) async {
    if (_hostTeamController.text.isEmpty ||
        _awayTeamController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Error!! All fields are required.',
            style: TextStyle(color: Colors.white,fontSize: 14), // Text color
          ),
          backgroundColor: Colors.red, // Background color
          duration: Duration(seconds: 3), // Optional: Adjust the duration
        ),
      );

      return;
    }
    
    setState(() {
      _isLoading = true;
    });

    String hostTeam = _hostTeamController.text;
    String awayTeam = _awayTeamController.text;
    String tossWinner = selectedOption;
    String optedTo = selectedOptedOption;

    Map<String, String> formData = {
      'hostTeam': hostTeam,
      'awayTeam': awayTeam,
      'tossWinner': tossWinner,
      'opted_to': optedTo,
    };
    print(formData);

    try {
      // Map<String, dynamic> match = await model.createPracticeMatch(formData);
      // print(" Football Practice match created successfully: $match");
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => PracticeMatchScoreScreen(entity: match),
      //   ),
      // );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FootballScoreboardScreen(entity: formData),
        ),
      );
    } catch (e) {
      // Show an error message if the API call fails
      print("Error occurred: $e");
     ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Failed to create practice match. Please try again.',
            style: TextStyle(color: Colors.white), // Text color
          ),
          backgroundColor: Colors.red, // Background color
          duration: Duration(seconds: 3), // Optional: Adjust the duration
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }

    // You can now send `formData` to the backend
  }

  



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Teams",
                style: GoogleFonts.getFont('Poppins', color: Colors.blue, fontSize: 16),
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0, 1),
                      blurRadius: 0.5,
                    )
                  ],
                ),
                child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Consumer<PracticeMatchviewModel>(
                        builder: (context, value, child) {
                      return Column(
                        children: [
                          // _buildTextField(
                          //     _hostTeamController, 'Host Team', _hostFocusNode),
                          _buildAutocompleteTextField(_hostTeamController,
                              'Host Team', _hostFocusNode, value.createdTeams),
                          _buildAutocompleteTextField(
                              _awayTeamController,
                              'Visitor Team',
                              _awayFocusNode,
                              value.createdTeams),
                        ],
                      );
                    })),
              ),
              const SizedBox(height: 16),
              Text(
                "Toss Won by?",
                style: GoogleFonts.getFont('Poppins', color: Colors.blue,fontSize: 16),
              ),
              const SizedBox(height: 8),
              Container(
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0, 1),
                      blurRadius: 0.5,
                    )
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _buildRadio(
                        _hostTeamController.text.isEmpty
                            ? 'Host'
                            : _hostTeamController.text,
                        _hostTeamController),
                    _buildRadio(
                        _awayTeamController.text.isEmpty
                            ? 'Visitor'
                            : _awayTeamController.text,
                        _awayTeamController),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Text(
                "Opted For ?",
                style: GoogleFonts.getFont('Poppins', color: Colors.blue,fontSize: 16),
              ),
              const SizedBox(height: 8),
              Container(
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0, 1),
                      blurRadius: 0.5,
                    )
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _buildOptedRadio('Start - Kickoff'),
                    _buildOptedRadio('Sides'),
                  ],
                ),
              ),
              const SizedBox(height: 30),
            
              Consumer<PracticeMatchviewModel>(
                builder: (context, value, child) {
                  return SizedBox(
                    height: 50,
                    width: 110,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.all<Color>(Colors.blue),
                      ),
                      onPressed: () {
                        _submitForm(value);
                      },
                      child: _isLoading
                          ? CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : Text(
                              "Kick Off",
                              style: GoogleFonts.getFont('Poppins',
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String hint,
    FocusNode focusNode, [
    TextInputType keyboardType = TextInputType.text,
    TextInputFormatter? inputFormatter,
  ]) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      keyboardType: keyboardType,
      inputFormatters: inputFormatter != null ? [inputFormatter] : [],
      decoration: InputDecoration(
        hintText: hint,
        border: InputBorder.none,
      ),
    );
  }

  Widget _buildAutocompleteTextField(TextEditingController controller,
      String label, FocusNode focusNode, List<String> data) {
    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return const Iterable<String>.empty();
        }
        return data.where((String option) {
          return option.contains(textEditingValue.text);
        });
      },
      onSelected: (String selection) {
        controller.text = selection;
        setState(() {});
      },
      fieldViewBuilder: (BuildContext context,
          TextEditingController textEditingController,
          FocusNode focusNode,
          VoidCallback onFieldSubmitted) {
        textEditingController.text = controller.text;
        return TextField(
          controller: controller,
          focusNode: focusNode,
          decoration: InputDecoration(
            labelText: label,
            border: const UnderlineInputBorder(),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.blue, width: 2),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
          style: const TextStyle(
              color: Colors.black), // Change input text color here
        );
      },
      optionsViewBuilder: (BuildContext context,
          AutocompleteOnSelected<String> onSelected, Iterable<String> options) {
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
                      style: const TextStyle(
                          color:
                              Colors.black), // Change dropdown text color here
                    ),
                    onTap: () {
                      onSelected(option);
                    },
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildRadio(String value, TextEditingController controller) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Radio(
          value: value,
          groupValue: selectedOption,
          activeColor: Colors.blue,
          onChanged: (val) {
            setState(() {
              selectedOption = val.toString();
            });
          },
        ),
        Text(
          controller.text.isEmpty ? '$value Team' : controller.text.toString(),
          style: GoogleFonts.getFont('Poppins', color: Colors.black,fontSize: 15),
        ),
      ],
    );
  }

  Widget _buildOptedRadio(String value) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Radio(
          value: value,
          groupValue: selectedOptedOption,
          activeColor: Colors.blue,
          onChanged: (val) {
            setState(() {
              selectedOptedOption = val.toString();
            });
          },
        ),
        Text(
          value,
          style: GoogleFonts.getFont('Poppins', color: Colors.black, fontSize: 15),
        ),
      ],
    );
  }
}
