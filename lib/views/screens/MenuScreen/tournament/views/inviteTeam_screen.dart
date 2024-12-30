import 'package:cricyard/core/app_export.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../Entity/team/viewmodels/Teams_api_service.dart';

class InviteTeamScreen extends StatefulWidget {
  InviteTeamScreen(this.tourId, {super.key});
  var tourId;
  @override
  _InviteTeamScreenState createState() => _InviteTeamScreenState();
}

class _InviteTeamScreenState extends State<InviteTeamScreen> {
  final teamsApiService teamapiService = teamsApiService();
  String? token;

  List<Map<String, dynamic>> teams = []; // Store tournament data here
  bool isteamLoading = false;

  bool _isInviting = false;
  List<bool> _isReInvitingList = [];
  bool _isInvited = false;

  @override
  void initState() {
    super.initState();
    fetchMyTeamsbyTournamentId();
  }
  Future<void> fetchMyTeamsbyTournamentId() async {
    try {
      setState(() {
        isteamLoading = true;
      });
      final List<Map<String, dynamic>> myteam =
          await teamapiService.getEntities();
      setState(() {
        teams = myteam.map((team) {
          return {
            ...team,
            'invited':
                false, // Add the 'invited' property to track invitation status
          };
        }).toList();
        _isReInvitingList = List<bool>.filled(teams.length, false);
      });
      print("Response: $myteam");

      for (int i = 0; i < myteam.length; i++) {
        print("Team $i: ${myteam[i]}");
      }
    } catch (e) {
      print("Error fetching myteam: $e");
    } finally {
      setState(() {
        isteamLoading = false;
      });
    }
  }

  Future<void> _sendInvite(int tournamentId, int teamId) async {
    final response = await teamapiService.inviteTeam(widget.tourId, teamId);
    print("Raw response: $response");
    // Convert the response to a string and trim any whitespace
    // final trimmedResponse = response.toString().trim();
    // print("Trimmed Response is: '$trimmedResponse'");

    if (response == 'Invitation Already Sent') {
      // Handle successful invite
      _showCustomSnackBar(context, 'Invitation Already Sent');
      setState(() {
        // Update the invitation status of the team
        print("setstates for teams started ");
        teams = teams.map((team) {
          if (team['id'] == teamId) {
            return {
              ...team,
              'invited': true, // Mark the team as invited
            };
          }
          return team;
        }).toList();
      });
      print("updated teams list:$teams");
    }
    //  else if (response == ' Invitation  Sent') {
    //   // Handle successful invite
    //   _showCustomSnackBar(context, 'Invitation sent successfully!');
    //   setState(() {
    //     // Update the invitation status of the team
    //     print("setstates for teams started ");
    //     teams = teams.map((team) {
    //       if (team['id'] == teamId) {
    //         return {
    //           ...team,
    //           'invited': true, // Mark the team as invited
    //         };
    //       }
    //       return team;
    //     }).toList();
    //   });
    //   print("updated teams list:$teams");
    // }

    //HERE WE CAN PUT ELSE IF CONDITION FOR SUCCESSFULL INVITATION BCOZ IF API FAILS BELOW CONDITION MAKES CONFLICTS

    else {
      // _showCustomSnackBar(context, 'Something went wrong');
      // Handle successful invite
      _showCustomSnackBar(context, 'Invitation sent successfully!');
      setState(() {
        // Update the invitation status of the team
        print("setstates for teams started ");
        teams = teams.map((team) {
          if (team['id'] == teamId) {
            return {
              ...team,
              'invited': true, // Mark the team as invited
            };
          }
          return team;
        }).toList();
      });
      print("updated teams list:$teams");
    }
  }

  void _showCustomSnackBar(BuildContext context, String message) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 40.0,
        right: 20.0,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.8),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              message,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );

    overlay?.insert(overlayEntry);
    Future.delayed(const Duration(seconds: 3), () {
      overlayEntry.remove();
    });
  }

  onTapBtnArrowleftone(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Invite Team",
          style: theme.textTheme.headlineLarge,
        ),
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
      body: isteamLoading ? const Center(child: CircularProgressIndicator()):  _buildTeamMembersTable(),
    );
  }


  // Widget _buildTeamMembersTable() {
  //   return Column(
  //     children: [
  //       Padding(
  //         padding: EdgeInsets.all(8.h),
  //         child: Container(
  //           color: Colors.white,
  //           child: SingleChildScrollView(
  //             scrollDirection: Axis.horizontal,
  //             child: isteamLoading
  //                 ? const Center(child: CircularProgressIndicator())
  //                 : teams.isEmpty
  //                     ? const Padding(
  //                         padding: EdgeInsets.all(16.0),
  //                         child: Text(
  //                           'No Team found',
  //                           style: TextStyle(
  //                             fontSize: 16,
  //                             fontWeight: FontWeight.bold,
  //                           ),
  //                         ),
  //                       )
  //                     : DataTable(
  //                         columns: const [
  //                           DataColumn(label: Text('Sr')),
  //                           DataColumn(label: Text('Image')),
  //                           DataColumn(label: Text('Team Name')),
  //                           DataColumn(label: Text('Invitation')),
  //                         ],
  //                         rows: teams.map((member) {
  //                           // Print the team data to the console
  //                           print("Team Data: $member");
  //                           return DataRow(
  //                             cells: [
  //                               DataCell(
  //                                 Padding(
  //                                   padding: const EdgeInsets.all(5),
  //                                   child: Text(
  //                                     (teams.indexOf(member) + 1).toString(),
  //                                     style:
  //                                         const TextStyle(color: Colors.black),
  //                                   ),
  //                                 ),
  //                               ),
  //                               DataCell(
  //                                 Padding(
  //                                   padding: const EdgeInsets.all(5),
  //                                   child: Container(
  //                                     width: 32, // Specify the size
  //                                     height: 32, // Specify the size
  //                                     decoration: BoxDecoration(
  //                                       shape: BoxShape.circle,
  //                                       image: DecorationImage(
  //                                         image: AssetImage(member['image'] ??
  //                                             'assets/images/download.jpeg'),
  //                                         fit: BoxFit.cover,
  //                                       ),
  //                                     ),
  //                                   ),
  //                                 ),
  //                               ),
  //                               DataCell(
  //                                 Padding(
  //                                   padding: const EdgeInsets.all(5),
  //                                   child: Text(
  //                                     member['team_name'] ?? 'team_name Name',
  //                                     style:
  //                                         const TextStyle(color: Colors.black),
  //                                   ),
  //                                 ),
  //                               ),
  //                               DataCell(
  //                                 Padding(
  //                                   padding: const EdgeInsets.all(5),
  //                                   child: SizedBox(
  //                                     width: 100,
  //                                     height: 40,
  //                                     child: ElevatedButton.icon(
  //                                       onPressed: () {
  //                                         _sendInvite(
  //                                             widget.tourId, member['id']);
  //                                       },
  //                                       icon: AnimatedContainer(
  //                                         duration: Duration(milliseconds: 500),
  //                                         curve: Curves.easeInOut,
  //                                         transform: member['invited']
  //                                             ? Matrix4.rotationZ(0.5)
  //                                             : Matrix4.rotationZ(0),
  //                                         child: Icon(
  //                                           member['invited']
  //                                               ? Icons.refresh
  //                                               : Icons.group_add,
  //                                           color: member['invited']
  //                                               ? Colors.blue
  //                                               : Colors.white,
  //                                         ),
  //                                       ),
  //                                       label: Text(
  //                                         member['invited']
  //                                             ? 'Reinvite'
  //                                             : 'Invite',
  //                                         style: TextStyle(
  //                                           color: member['invited']
  //                                               ? Colors.blue
  //                                               : Colors.white,
  //                                         ),
  //                                       ),
  //                                       style: ElevatedButton.styleFrom(
  //                                         backgroundColor: member['invited']
  //                                             ? Colors.white
  //                                             : Colors.green,
  //                                         shape: RoundedRectangleBorder(
  //                                           borderRadius:
  //                                               BorderRadius.circular(20),
  //                                         ),
  //                                       ),
  //                                     ),
  //                                   ),
  //                                 ),
  //                               ),
  //                             ],
  //                           );
  //                         }).toList(),
  //                       ),
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  Widget _buildTeamMembersTable() {
    return ListView.builder(
      itemCount: teams.length,
      itemBuilder: (context, index) {
        final data = teams[index]; // Check if already invited
      return ListTile(
        title: Row(
          children: [
            Text(
              '${index + 1}.',
              style: GoogleFonts.getFont('Poppins',
                  color: Colors.black),
            ),
            const SizedBox(width: 10),
            const CircleAvatar(
              // Provide default value for profilePic
              radius: 20,
              child: Icon(Icons.person,color: Colors.white,),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                data['team_name'] ??
                    'Unknown Team', // Provide default value for player_name
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height *
                  0.04,
              width: MediaQuery.of(context).size.width *
                  0.15,
              child: _isReInvitingList[index]
                  ? const Center(
                  child: CircularProgressIndicator())
                  : ElevatedButton(
                style: const ButtonStyle(
                    backgroundColor:
                    MaterialStatePropertyAll(
                        Color(0xFF264653))),
                onPressed: () {
                  setState(() {
                    _isReInvitingList[index] = true;
                  });
                  _sendInvite(widget.tourId,data['id']).then((value) {
                    setState(() {
                      _isReInvitingList[index] =
                      false;
                    });
                  },);
                },
                child: Text(
                  _isInvited
                      ? 'Re invite'
                      : 'Invite',
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },);
  }
}
