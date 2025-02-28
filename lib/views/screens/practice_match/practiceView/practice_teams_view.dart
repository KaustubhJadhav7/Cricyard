import 'package:cricyard/views/screens/practice_match/practiceView/team_players_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:cricyard/views/screens/practice_match/practiceRepository/PracticeMatchService.dart';

import '../practiceViewmodel/PracticeMatchViewmodel.dart';

class PracticeTeamsView extends StatefulWidget {
  const PracticeTeamsView({super.key});

  @override
  State<PracticeTeamsView> createState() => _PracticeTeamsViewState();
}

class _PracticeTeamsViewState extends State<PracticeTeamsView> {
  final PracticeMatchService scoreservice = PracticeMatchService();

  TextEditingController _newTeamController = TextEditingController();

  List<Map<String, dynamic>> teams = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getAllTeams();
  }

  Future<void> getAllTeams() async {
    setState(() {
      isLoading = true;
    });
    try {
      final fetchedEntities = await scoreservice.getAllTeam();
      print("last rec for teams --$fetchedEntities");
      if (fetchedEntities != null && fetchedEntities.isNotEmpty) {
        setState(() {
          teams = fetchedEntities;
        });
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text(
              'Failed to fetch : $e',
              style: const TextStyle(color: Colors.black),
            ),
            actions: [
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PracticeMatchviewModel>(builder: (context, value, child) {
      return Scaffold(
        backgroundColor: Colors.grey[200],
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xFF219ebc),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text(
                    "Create Team",
                    style: GoogleFonts.getFont('Poppins', color: Colors.black),
                  ),
                  content: TextField(
                    controller: _newTeamController,
                    decoration: const InputDecoration(
                      labelText: 'Create Team',
                      border: UnderlineInputBorder(),
                      focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xFF219ebc), width: 2),
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    ),
                  ),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("cancel")),
                    TextButton(
                        onPressed: () {
                          value.createNewTeam(
                              _newTeamController.text.toString());
                          // scoreservice.createNewTeam(
                          //     _newTeamController.text.toString());

                          Future.delayed(const Duration(seconds: 3)).then(
                            (value) => getAllTeams(),
                          );
                          Navigator.pop(context);
                        },
                        child: const Text("create")),
                  ],
                );
              },
            );
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : teams.isEmpty
                ? Center(
                    child: Text(
                    "No teams yet !!!",
                    style: GoogleFonts.getFont('Poppins',
                        fontSize: 20, color: Colors.black),
                  ))
                : ListView.builder(
                    itemCount: teams.length,
                    itemBuilder: (context, index) {
                      final data = teams[index];
                      print("data for teams: $data");
                      return _myContainer(
                          teamName: data['team_name']?? "Unknown Team",
                          matchesPlayed: data['matchesPlayed'] ?? '0',
                          matchesWon: data['matchesWon'] ?? '0',
                          matchesLost: data['matchesLost'] ?? '0',
                          id: data['id']);
                    },
                  ),
      );
    });
  }

  Widget _myContainer(
      {required String teamName,
      required matchesPlayed,
      required matchesWon,
      required matchesLost,
      required id}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TeamPlayersScreen(
                  teamId: id,
                ),
              ));
        },
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  offset: const Offset(0, 5),
                  blurRadius: 10,
                  spreadRadius: 1,
                )
              ],
              borderRadius: BorderRadius.circular(12)),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.grey[400],
              // backgroundImage: AssetImage(ImageConstant.imageTeams),
            ),
            title: Text(
              teamName,
              style: GoogleFonts.getFont('Poppins', color: Colors.black),
            ),
            subtitle: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Matches:",
                  style: GoogleFonts.getFont('Poppins', color: Colors.black),
                ),
                const SizedBox(
                  width: 4,
                ),
                Text(
                  matchesPlayed,
                  style: GoogleFonts.getFont('Poppins', color: Colors.black),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "Won:",
                  style: GoogleFonts.getFont('Poppins', color: Colors.black),
                ),
                const SizedBox(
                  width: 4,
                ),
                Text(
                  matchesWon,
                  style: GoogleFonts.getFont('Poppins', color: Colors.black),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "Lost:",
                  style: GoogleFonts.getFont('Poppins', color: Colors.black),
                ),
                const SizedBox(
                  width: 4,
                ),
                Text(
                  matchesLost,
                  style: GoogleFonts.getFont('Poppins', color: Colors.black),
                )
              ],
            ),
            trailing: SizedBox(
              width: 100,
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            TextEditingController teamNameController =
                                TextEditingController();
                            return AlertDialog(
                              title: const Text('Update Team Name'),
                              content: TextField(
                                controller: teamNameController,
                                decoration: const InputDecoration(
                                  hintText: 'Enter new team name',
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
                                    String newTeamName =
                                        teamNameController.text;
                                    // Ensure the team name is not empty
                                    if (newTeamName.isNotEmpty) {
                                      updateTeam(newTeamName,
                                          id); // Call the update function with new team name and id
                                      Navigator.of(context)
                                          .pop(); // Close the dialog
                                    } else {
                                      // Optionally show a message if the team name is empty
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text('Error'),
                                            content: const Text(
                                              'Team name cannot be empty',
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                            actions: [
                                              TextButton(
                                                child: const Text('OK'),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    }
                                  },
                                ),
                              ],
                            );
                          },
                        );
                        // scoreservice.deleteTeam(id).then((value) => getAllTeams(),);
                      },
                      icon: const Icon(
                        Icons.edit,
                        size: 22,
                      )),
                  IconButton(
                      onPressed: () {
                        deleteTeam(id);
                      },
                      icon: const Icon(
                        Icons.delete,
                        size: 22,
                        color: Colors.red,
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> deleteTeam(int id) async {
    try {
      await scoreservice.deleteTeam(id);
      setState(() {
        // Remove the team from the list based on the id
        print("Id--$id");
        teams.removeWhere((team) => team['id'] == id);
      });
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text('Failed to delete Team: $e'),
            actions: [
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }
  // Future<void> addTeam(String teamName) async {
  //   try {
  //     scoreservice.createNewTeam(teamName);
  //     setState(() {
  //       teams.add(teamName as Map<String, dynamic>);
  //     });
  //   } catch (e) {
  //     showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           title: const Text('Error'),
  //           content: Text('Failed to delete Team: $e'),
  //           actions: [
  //             TextButton(
  //               child: const Text('OK'),
  //               onPressed: () {
  //                 Navigator.of(context).pop();
  //               },
  //             ),
  //           ],
  //         );
  //       },
  //     );
  //   }
  // }

  Future<void> updateTeam(String teamName, int id) async {
    try {
      await scoreservice.editTeamName(teamName, id);
      setState(() {
        // Find and update the team in the list based on the id
        int index = teams.indexWhere((team) => team['id'] == id);
        if (index != -1) {
          teams[index]['team_name'] = teamName;
        }
      });
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text(
              'Failed to update Team: $e',
              style: TextStyle(color: Colors.black),
            ),
            actions: [
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }
}
