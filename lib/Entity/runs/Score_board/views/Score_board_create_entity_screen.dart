import 'package:cricyard/Entity/runs/Score_board/viewmodel/Score_board_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cricyard/Entity/team/viewmodels/Teams_api_service.dart';
import 'package:provider/provider.dart';
import '../repository/Score_board_api_service.dart';
import '/providers/token_manager.dart';

class ScoreBoardCreateEntityScreen extends StatefulWidget {
  final matchId;
  final tourId;
  final int overs;

  const ScoreBoardCreateEntityScreen(
      {required this.matchId,
      required this.tourId,
      super.key,
      required this.overs});

  @override
  _ScoreBoardCreateEntityScreenState createState() =>
      _ScoreBoardCreateEntityScreenState();
}

class _ScoreBoardCreateEntityScreenState
    extends State<ScoreBoardCreateEntityScreen> {
  final score_boardApiService apiService = score_boardApiService();
  final teamsApiService teamApi = teamsApiService();
  final Map<String, dynamic> formData = {};
  final _formKey = GlobalKey<FormState>();

  var selectedTossWinner = '';
  var selectedOptedOption = 'Bat';

  List<Map<String, dynamic>> teamItems = [];
  var selectedbatting_teamValue = '';
  var selectedChasingTeamValue = '';

  List<Map<String, dynamic>> teamMembersBatting = [];
  List<Map<String, dynamic>> teamMembersBalling = [];

  TextEditingController overController = TextEditingController();

  var selectedstrikerValue = '';
  var selectednon_strikerValue = '';
  var selectedballerValue = '';
  var selectedOversValue = '0';

  bool isvalid_ball_delivery = false;
  bool isno_ball = false;
  bool isdeclared_2 = false;
  bool isdeclared_4 = false;
  bool isdeclared_6 = false;
  bool iswide_ball = false;
  bool isdead_ball = false;
  bool isfree_hit = false;
  bool isleg_by = false;
  bool isover_throw = false;

  bool isLoading = false;
  bool isTeamLoading = false;

  // Future<void> _loadTeams() async {
  //   setState(() {
  //     isTeamLoading = true;
  //     selectedOversValue = widget.overs.toString();
  //   });
  //   try {
  //     final data = await apiService.getAllTeam(widget.matchId);
  //     if (data.isNotEmpty) {
  //       setState(() {
  //         teamItems = data;
  //         isTeamLoading = false;
  //       });
  //     } else {
  //       print('Team data is null or empty');
  //     }
  //   } catch (e) {
  //     print('Failed to load Team items: $e');
  //   } finally {
  //     setState(() {
  //       isTeamLoading = false;
  //     });
  //   }
  // }

  // Future<void> getAllBattingMember(int teamId) async {
  //   try {
  //     final data = await teamApi.getAllMembers(teamId);
  //     teamMembersBatting.clear();
  //     setState(() {
  //       teamMembersBatting = data;
  //     });
  //   } catch (e) {
  //     print("Error fetching Batting Members: $e");
  //   }
  // }

  // Future<void> getAllBallingMember(int teamId) async {
  //   try {
  //     final data = await teamApi.getAllMembers(teamId);
  //     teamMembersBalling.clear();
  //     setState(() {
  //       teamMembersBalling = data;
  //     });
  //   } catch (e) {
  //     print("Error fetching Balling Members: $e");
  //   }
  // }

  // void updateTeamsBasedOnToss() {
  //   final provider = Provider.of<ScoreBoardProvider>(context, listen: false);
  //   if (selectedTossWinner.isNotEmpty && selectedOptedOption.isNotEmpty) {
  //     var tossWinnerTeam = teamItems
  //         .firstWhere((team) => team['team_name'] == selectedTossWinner);

  //     setState(() {
  //       if (selectedOptedOption == 'Bat') {
  //         selectedbatting_teamValue = tossWinnerTeam['id'].toString();
  //         selectedChasingTeamValue = teamItems
  //             .firstWhere((team) =>
  //                 team['id'].toString() != selectedbatting_teamValue)['id']
  //             .toString();
  //         selectedstrikerValue = '';
  //         selectednon_strikerValue = '';
  //         selectedballerValue = '';
  //         teamMembersBatting.clear();
  //         teamMembersBalling.clear();
  //         provider.getAllBattingMembers(int.parse(selectedbatting_teamValue));
  //         provider.getAllBallingMembers(int.parse(selectedChasingTeamValue));
  //       } else {
  //         selectedChasingTeamValue = tossWinnerTeam['id'].toString();
  //         selectedbatting_teamValue = teamItems
  //             .firstWhere((team) =>
  //                 team['id'].toString() != selectedChasingTeamValue)['id']
  //             .toString();
  //         selectedstrikerValue = '';
  //         selectednon_strikerValue = '';
  //         selectedballerValue = '';
  //         teamMembersBatting.clear();
  //         teamMembersBalling.clear();
  //         provider.getAllBattingMembers(int.parse(selectedbatting_teamValue));
  //         provider.getAllBattingMembers(int.parse(selectedChasingTeamValue));
  //       }
  //     });

  //     // getAllBattingMember(int.parse(selectedbatting_teamValue));
  //     // getAllBallingMember(int.parse(selectedChasingTeamValue));
  //   }
  // }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<ScoreBoardProvider>(context, listen: false);
      super.initState();
      print("Overs--${widget.overs}");
      provider.loadTeams(widget.matchId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ScoreBoardProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text("Start scoring",
            style: GoogleFonts.getFont('Poppins',
                fontSize: 20, color: Colors.black)),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: const Color(0xFF219ebc),
                  borderRadius: BorderRadius.circular(12)),
              child: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Text('Toss Won By:',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                ),
                if (isTeamLoading)
                  const Center(child: CircularProgressIndicator())
                else
                  ...teamItems.map((team) => RadioListTile<String>(
                        title: Text(team['team_name']),
                        value: team['team_name'],
                        groupValue: selectedTossWinner,
                        onChanged: (value) {
                          setState(() {
                            selectedTossWinner = value!;
                          });
                          provider.updateTeamsBasedOnToss(
                            selectedTossWinner: selectedTossWinner,
                            selectedOptedOption: selectedOptedOption,
                          );
                        },
                      )),
                const SizedBox(height: 20),
                Text(
                  "Opted to ?",
                  style: GoogleFonts.getFont('Poppins',
                      color: Colors.black, fontSize: 14),
                ),
                const SizedBox(height: 10),
                _buildOptedRadio('Bat'),
                _buildOptedRadio('Ball'),
                const SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  decoration: customInputDecoration('Batting Team'),
                  value: selectedbatting_teamValue,
                  items: [
                    const DropdownMenuItem<String>(
                      value: '',
                      child: Text('Select option',
                          style: TextStyle(color: Colors.grey)),
                    ),
                    ...teamItems
                        .where((item) =>
                            item['id'].toString() == selectedbatting_teamValue)
                        .map<DropdownMenuItem<String>>((item) {
                      return DropdownMenuItem<String>(
                        value: item['id'].toString(),
                        child: Text(item['team_name'].toString()),
                      );
                    }).toList(),
                  ],
                  onChanged: null,
                  onSaved: (value) {
                    formData['batting_team_id'] = selectedbatting_teamValue;
                  },
                  icon: const Icon(
                    Icons.arrow_drop_down,
                    color: Colors.blue,
                  ),
                  dropdownColor: Colors.white,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                  iconEnabledColor: Colors.blue,
                ),
                const SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  decoration: customInputDecoration('Chasing Team'),
                  value: selectedChasingTeamValue,
                  items: [
                    const DropdownMenuItem<String>(
                      value: '',
                      child: Text('Select option'),
                    ),
                    ...teamItems
                        .where((item) =>
                            item['id'].toString() == selectedChasingTeamValue)
                        .map<DropdownMenuItem<String>>((item) {
                      return DropdownMenuItem<String>(
                        value: item['id'].toString(),
                        child: Text(item['team_name'].toString()),
                      );
                    }).toList(),
                  ],
                  onChanged: null,
                  onSaved: (value) {
                    formData['bowling_team_id'] = selectedChasingTeamValue;
                  },
                  icon: const Icon(
                    Icons.arrow_drop_down,
                    color: Colors.blue,
                  ),
                  dropdownColor: Colors.white,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                  iconEnabledColor: Colors.blue,
                ),
                const SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  decoration: customInputDecoration('Striker'),
                  value: selectedstrikerValue,
                  items: [
                    const DropdownMenuItem<String>(
                      value: '',
                      child: Text('Select option'),
                    ),
                    ...teamMembersBatting
                        .where((item) =>
                            item['user_id'].toString() !=
                            selectednon_strikerValue)
                        .map<DropdownMenuItem<String>>((item) {
                      return DropdownMenuItem<String>(
                        value: item['user_id'].toString(),
                        child: Text(item['player_name'].toString()),
                      );
                    }).toList(),
                  ],
                  onChanged: (value) {
                    setState(() {
                      selectedstrikerValue = value!;
                    });
                  },
                  onSaved: (value) {
                    formData['striker'] = selectedstrikerValue;
                  },
                  icon: const Icon(
                    Icons.arrow_drop_down,
                    color: Colors.blue,
                  ),
                  dropdownColor: Colors.white,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                  iconEnabledColor: Colors.blue,
                ),
                const SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  decoration: customInputDecoration('Non-Striker'),
                  value: selectednon_strikerValue,
                  items: [
                    const DropdownMenuItem<String>(
                      value: '',
                      child: Text('Select option'),
                    ),
                    ...teamMembersBatting
                        .where((item) =>
                            item['user_id'].toString() != selectedstrikerValue)
                        .map<DropdownMenuItem<String>>((item) {
                      return DropdownMenuItem<String>(
                        value: item['user_id'].toString(),
                        child: Text(item['player_name'].toString()),
                      );
                    }).toList(),
                  ],
                  onChanged: (value) {
                    setState(() {
                      selectednon_strikerValue = value!;
                    });
                  },
                  onSaved: (value) {
                    formData['non_striker'] = selectednon_strikerValue;
                  },
                  icon: const Icon(
                    Icons.arrow_drop_down,
                    color: Colors.blue,
                  ),
                  dropdownColor: Colors.white,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                  iconEnabledColor: Colors.blue,
                ),
                const SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  decoration: customInputDecoration('Bowler'),
                  value: selectedballerValue,
                  items: [
                    const DropdownMenuItem<String>(
                      value: '',
                      child: Text('Select option'),
                    ),
                    ...teamMembersBalling.map<DropdownMenuItem<String>>((item) {
                      return DropdownMenuItem<String>(
                        value: item['user_id'].toString(),
                        child: Text(item['player_name'].toString()),
                      );
                    }).toList(),
                  ],
                  onChanged: (value) {
                    setState(() {
                      selectedballerValue = value!;
                    });
                  },
                  onSaved: (value) {
                    formData['baller'] = selectedballerValue;
                  },
                  icon: const Icon(
                    Icons.arrow_drop_down,
                    color: Colors.blue,
                  ),
                  dropdownColor: Colors.white,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                  iconEnabledColor: Colors.blue,
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: overController,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  decoration: InputDecoration(
                    hintText: 'Enter Overs',
                    border: OutlineInputBorder(),
                  ),
                ),
                const Divider(thickness: 1.0),
                const SizedBox(height: 20),
                Text('Ball Analysis:',
                    style: GoogleFonts.getFont('Poppins',
                        color: Colors.black, fontSize: 16)),
                const SizedBox(height: 10),
                buildBallAnalysisRow(
                    'Valid ball delivery', isvalid_ball_delivery),
                buildBallAnalysisRow('No ball', isno_ball),
                buildBallAnalysisRow('Declared 2 runs', isdeclared_2),
                buildBallAnalysisRow('Declared 4 runs', isdeclared_4),
                buildBallAnalysisRow('Declared 6 runs', isdeclared_6),
                buildBallAnalysisRow('Wide ball', iswide_ball),
                buildBallAnalysisRow('Dead ball', isdead_ball),
                buildBallAnalysisRow('Free hit', isfree_hit),
                buildBallAnalysisRow('Leg by', isleg_by),
                buildBallAnalysisRow('Over throw', isover_throw),
                const SizedBox(height: 20),
                Center(
                  child: SizedBox(
                    height: 50,
                    child: isLoading
                        ? const CircularProgressIndicator()
                        : ElevatedButton(
                            onPressed: () {
                              submitForm();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: Text(
                              'Submit',
                              style: GoogleFonts.getFont('Poppins',
                                  color: Colors.white, fontSize: 16),
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration customInputDecoration(String labelText) {
    return InputDecoration(
      labelText: labelText,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  Widget _buildOptedRadio(String title) {
    final provider = Provider.of<ScoreBoardProvider>(context, listen: false);
    return RadioListTile<String>(
      title: Text(title),
      value: title,
      groupValue: selectedOptedOption,
      onChanged: (value) {
        setState(() {
          selectedOptedOption = value!;
        });
        provider.updateTeamsBasedOnToss(selectedTossWinner: selectedTossWinner,
    selectedOptedOption: selectedOptedOption,);
      },
    );
  }

  Widget buildBallAnalysisRow(String label, bool value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: GoogleFonts.getFont('Poppins', color: Colors.black)),
        Switch(
          value: value,
          onChanged: (newValue) {
            setState(() {
              switch (label) {
                case 'Valid ball delivery':
                  isvalid_ball_delivery = newValue;
                  break;
                case 'No ball':
                  isno_ball = newValue;
                  break;
                case 'Declared 2 runs':
                  isdeclared_2 = newValue;
                  break;
                case 'Declared 4 runs':
                  isdeclared_4 = newValue;
                  break;
                case 'Declared 6 runs':
                  isdeclared_6 = newValue;
                  break;
                case 'Wide ball':
                  iswide_ball = newValue;
                  break;
                case 'Dead ball':
                  isdead_ball = newValue;
                  break;
                case 'Free hit':
                  isfree_hit = newValue;
                  break;
                case 'Leg by':
                  isleg_by = newValue;
                  break;
                case 'Over throw':
                  isover_throw = newValue;
                  break;
              }
            });
          },
          activeColor: Colors.blue,
        ),
      ],
    );
  }

  Future<void> submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      _formKey.currentState!.save();
      final formDataJson = formData;
      formData['tournament'] = widget.tourId;
      formData['match_id'] = widget.matchId;
      formData['match_overs'] = overController.text;
      try {
        final res = await apiService.createEntity(formData);
        Navigator.pop(context);
        print("res--$res");
        print(formDataJson);
      } catch (error) {
        print("Error: $error");
        setState(() {
          isLoading = false;
        });
      }
    } else {
      print('Form validation failed');
    }
  }
}
