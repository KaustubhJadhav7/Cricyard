import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../practiceRepository/PracticeMatchService.dart';

class TeamPlayersScreen extends StatefulWidget {
  final int teamId;
  TeamPlayersScreen({super.key, required this.teamId});

  @override
  _TeamPlayersScreenState createState() => _TeamPlayersScreenState();
}

class _TeamPlayersScreenState extends State<TeamPlayersScreen> {
  final PracticeMatchService scoreservice = PracticeMatchService();
  final TextEditingController newPlayerController = TextEditingController();

  List<Map<String,dynamic>> playerDataList = [];
   bool _isLoading = false;

  void fetchPlayers()async{
    _isLoading = true;
    print('Fetching');
   final res = await scoreservice.getAllPlayersInTeam(widget.teamId);
   setState(() {
     playerDataList = res;
     print("Data fetched");
   });
    _isLoading = false;
  }
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.teamId);
    fetchPlayers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: _isLoading ? const Center(child: CircularProgressIndicator()) : playerDataList.isEmpty ? const Center(child: Text("No players in team",style: TextStyle(color: Colors.black,fontSize: 20),)) :  ListView.builder(
        itemCount: playerDataList.length,
        itemBuilder: (context, index) {
          final data = playerDataList[index];
          return _buildListTile(data['player_name'],data['id'],data['team_id']);
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor:const Color(0xFF219ebc),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text(
                  "Add new player",
                  style: GoogleFonts.getFont('Poppins', color: Colors.black),
                ),
                content: TextField(
                  controller: newPlayerController,
                  decoration: const InputDecoration(
                    labelText: 'Player name',
                    border: UnderlineInputBorder(),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF219ebc), width: 2),
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Cancel")),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        scoreservice.addNewPlayer(newPlayerController.text.toString(),widget.teamId);
                        fetchPlayers();
                      },
                      child: const Text("Add")),
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
    );
  }

  Widget _buildListTile(String pName,int pId,int teamId) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 6),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              offset: const Offset(0, 5),
              blurRadius: 10,
              spreadRadius: 1,
            )
          ]
        ),
        child: ListTile(
          leading: const CircleAvatar(
            radius: 14,
            backgroundColor:  Color(0xFF219ebc),
            child: Icon(
              Icons.person,
              color: Colors.white,
            ),
          ),
          title:  Text(pName),
          trailing: SizedBox(
            width: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // update
                IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          TextEditingController teamNameController = TextEditingController();
                          return AlertDialog(
                            title: const Text('Update Player Name'),
                            content: TextField(
                              controller: teamNameController,
                              decoration: const InputDecoration(
                                hintText: 'Enter new player name',
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
                                  String newPlayerName = teamNameController.text;
                                  // Ensure the team name is not empty
                                  if (newPlayerName.isNotEmpty) {
                                    updatePlayerName(newPlayerName,pId,teamId);
                                    Navigator.of(context).pop(); // Close the dialog
                                  } else {
                                    // Optionally show a message if the team name is empty
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text('Error'),
                                          content: const Text('Team name cannot be empty',style: TextStyle(color: Colors.black),),
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
                    }, icon: const Icon(Icons.edit)),
                // delete
                IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Confirm Deletion'),
                    content: const Text('Are you sure you want to delete this player?'),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('Cancel'),
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the dialog
                        },
                      ),
                      TextButton(
                        child: const Text('Delete'),
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the dialog
                          deletePlayer(pId); // Call the delete function
                        },
                      ),
                    ],
                  );
                },
              );
            },
            icon: const Icon(Icons.delete),
          )

          ],
            ),
          ),
        ),
      ),
    );
  }
  Future<void> deletePlayer(int id) async {
    try {
      await scoreservice.deleteTeam(id);
      setState(() {
        // Remove the team from the list based on the id
        print("Id--$id");
        playerDataList.removeWhere((player) => player['id'] == id);
      });
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text('Failed to delete Player: $e',style: TextStyle(color: Colors.black),),
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

  Future<void> updatePlayerName(String playerName, int id,int teamId) async {
    try {
      await scoreservice.editPlayerName(playerName,id,teamId);
      setState(() {
        // Find and update the team in the list based on the id
        int index = playerDataList.indexWhere((player) => player['id'] == id);
        if (index != -1) {
          playerDataList[index]['player_name'] = playerName;
        }
      });
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text('Failed to update Player: $e',style: TextStyle(color: Colors.black),),
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
