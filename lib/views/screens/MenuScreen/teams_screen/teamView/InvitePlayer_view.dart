// ignore_for_file: use_build_context_synchronously

import 'package:confetti/confetti.dart';
import 'package:cricyard/core/app_export.dart';
import 'package:cricyard/views/screens/MenuScreen/teams_screen/teamViewModel/team_view_model.dart';
import 'package:cricyard/theme/custom_text_style.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../ReuseableWidgets/BottomAppBarWidget.dart';
import '../../../sign_up_screen/SignUpService.dart';
import 'package:cricyard/Entity/team/viewmodels/Teams_api_service.dart';

class InvitePlayerView extends StatefulWidget {
  InvitePlayerView(this.teamId, {super.key});
  final int teamId;

  @override
  _InvitePlayerViewState createState() => _InvitePlayerViewState();
}

class _InvitePlayerViewState extends State<InvitePlayerView> {
  final teamsApiService teamapiService = teamsApiService();
  final SignUpApiService signService = SignUpApiService();

  String? token;
  List<Map<String, dynamic>> invitedPlayers = [];
  Map<String, dynamic> user = {}; // Store user data here
  bool isteamLoading = false;
  bool _isLoading = true;
  bool isInvited = false; // Track invite status
  bool _isInvited = true; // Track invite status
  final TextEditingController _controller = TextEditingController();
  Future<Map<String, dynamic>>? _futureUser;

  @override
  void initState() {
    Provider.of<TeamViewModel>(context, listen: false)
        .getAllInvitedPlayers(widget.teamId.toString())
        // fetchInvitedUsers()
        .then(
      (value) {
        _isReInvitingList = List<bool>.filled(invitedPlayers.length, false);
      },
    );
    super.initState();
  }

  Future<void> fetchInvitedUsers() async {
    try {
      _isLoading = true;
      final data = await teamapiService.getAllInvitedPlayers(
          teamId: widget.teamId.toString());
      if (data != null) {
        setState(() {
          invitedPlayers = data;
          _isLoading = false;
        });
        print("Invited- User-$invitedPlayers");
      } else {
        // Handle the case when data is null (e.g., show an error message)
        print("No invited players found.");
      }
    } catch (e) {
      // Handle any exceptions that might occur during the data fetching
      print("Error fetching invited players: $e");
    }
  }

  Future<Map<String, dynamic>> _searchUser(String mobileNumber) async {
    try {
      setState(() {
        isteamLoading = true;
      });

      final Map<String, dynamic> data =
          await signService.getByMobNumber(mobileNumber);
      setState(() {
        user = data; // Store the fetched data
      });
      print("Response: $data");
    } catch (e) {
      print("Error fetching Users: $e");
    } finally {
      setState(() {
        isteamLoading = false;
      });
    }
    return {'found': true, 'name': user['fullName']};
  }

  Future<void> _sendInvite(String mobileNumber, int teamId) async {
    final response = await teamapiService.invitePlayer(mobileNumber, teamId);
    print('response is: $response');

    if (response == 'Invitation  Sent') {
      // Update invite status and show snack bar
      setState(() {
        isInvited = true;
      });
      _showCustomSnackBar2(context, 'Invitation sent successfully!', true);
    } else if (response == 'Invitation Already Sent') {
      // Update invite status and show snack bar
      setState(() {
        isInvited = true;
      });
      _showCustomSnackBar2(context, 'Invitation Already Sent!', false);
    } else {
      // Handle failed invite
      _showCustomSnackBar2(context, 'Failed to send invite.', false);
    }
  }

  void _showCustomSnackBar2(
      BuildContext context, String message, bool isSuccess) {
    final overlay = Overlay.of(context);
    final confettiController =
        ConfettiController(duration: const Duration(seconds: 2));

    final overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          Center(
            child: Material(
              color: Colors.transparent,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                decoration: BoxDecoration(
                  color: isSuccess ? Colors.white : Colors.red.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10.0,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Text(
                  message,
                  style: TextStyle(
                    color: isSuccess ? Colors.black : Colors.white,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
          ),
          if (isSuccess)
            Center(
              child: ConfettiWidget(
                confettiController: confettiController,
                blastDirectionality: BlastDirectionality.explosive,
                shouldLoop: false,
                colors: const [
                  Colors.red,
                  Colors.green,
                  Colors.blue,
                  Colors.yellow,
                  Colors.purple,
                  Colors.orange,
                ],
              ),
            ),
        ],
      ),
    );

    overlay.insert(overlayEntry);

    if (isSuccess) {
      confettiController.play();
    }

    Future.delayed(const Duration(seconds: 3), () {
      overlayEntry.remove();
      confettiController.dispose();
    });
  }

  bool _isInviting = false;
  List<bool> _isReInvitingList = [];

  void onTapBtnArrowleftone(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        elevation: 0,
        forceMaterialTransparency: true,
        backgroundColor: Colors.grey[200],
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
        title: Text(
          "Invite players",
          style: GoogleFonts.getFont('Poppins',
              fontSize: 26, color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // SEARCH BAR START
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: Colors.grey.shade400),
                    ),
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(Icons.search, color: Colors.black),
                        ),
                        Expanded(
                          child: TextField(
                            controller: _controller,
                            decoration: const InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              hintText: 'Enter mobile number',
                              border: InputBorder.none,
                            ),
                            keyboardType: TextInputType.phone,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),

                //search button
                Container(
                  height: 48.0, // Match the height of the search bar
                  width: 100.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Color(0xFF264653) // Set your custom color here
                      ),
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _futureUser = _searchUser(_controller.text);
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: Text(
                      'Search',
                      style: GoogleFonts.getFont('Poppins',
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 14),
                    ),
                  ),
                ),
              ],
            ),
            // SEARCH BAR END
            const SizedBox(height: 16.0),
            FutureBuilder<Map<String, dynamic>>(
              future: _futureUser,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  final user = snapshot.data!;
                  if (user.isNotEmpty && user != null) {
                    final found = user['found'];
                    if (found == null) {
                      return const Center(child: Text("No user found!!"));
                    } else {
                      final name = found ? user['name'] : 'User not found';

                      return Column(
                        children: [
                          Text(
                            found
                                ? ' $name'
                                : 'User not found but you can still send invite',
                            style: CustomTextStyles.titleMediumPoppins,
                          ),
                          const SizedBox(height: 16.0),

                          // Invite button
                          SizedBox(
                            height: 50,
                            width: 70,
                            child: _isInviting
                                ? const Center(
                                    child: CircularProgressIndicator())
                                : ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        _isInviting = true;
                                      });
                                      _sendInvite(
                                              _controller.text, widget.teamId)
                                          .then((_) {
                                        fetchInvitedUsers();
                                        setState(() {
                                          _isInviting = false;
                                        });
                                      });
                                    },
                                    style: const ButtonStyle(
                                        elevation: MaterialStatePropertyAll(1),
                                        backgroundColor:
                                            MaterialStatePropertyAll(
                                                Color(0xFF264653))),
                                    child: Text(
                                      isInvited
                                          ? 'ReInvite'
                                          : 'Invite', // Update button text based on invite status
                                      style: CustomTextStyles
                                          .titleSmallPoppinsBlack900,
                                    ),
                                  ),
                          ),
                        ],
                      );
                    }
                  } else {
                    return Container();
                  }
                } else {
                  return Container();
                }
              },
            ),
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : invitedPlayers.isEmpty
                    ? Text(
                        "No players Invited yet!! ",
                        style: GoogleFonts.getFont('Poppins',
                            color: Colors.black, fontSize: 20),
                      )
                    : Expanded(
                        child: ListView.builder(
                          itemCount: invitedPlayers.length,
                          itemBuilder: (context, index) {
                            final data = invitedPlayers[
                                index]; // Check if already invited
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
                                    child: Icon(Icons.person),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      data['player_name'] ??
                                          'Unknown Player', // Provide default value for player_name
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
                                        ? Center(
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

                                              Future.delayed(
                                                      Duration(seconds: 2))
                                                  .then(
                                                (value) {
                                                  setState(() {
                                                    _isReInvitingList[index] =
                                                        false;
                                                  });
                                                },
                                              );
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
                          },
                        ),
                      )
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBarWidget(),
    );
  }
}


//EXISTING CODE BACKUP
// import 'package:cricyard/core/app_export.dart';
// import 'package:flutter/material.dart';

// import '../../../Entity/team/Teams/Teams_api_service.dart';
// import '../../../theme/custom_button_style.dart';
// import '../../../widgets/custom_elevated_button.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// import '../../sign_up_screen/SignUpService.dart';
// import 'package:intl_phone_number_input/intl_phone_number_input.dart';

// class InvitePlayerScreen extends StatefulWidget {
//   InvitePlayerScreen(this.teamId, {super.key});
//   var teamId;
//   @override
//   _InvitePlayerScreenState createState() => _InvitePlayerScreenState();
// }

// class _InvitePlayerScreenState extends State<InvitePlayerScreen> {
//   final teamsApiService teamapiService = teamsApiService();
//   final SignUpApiService signService = SignUpApiService();

//   String? token;

//   Map<String, dynamic> user = {}; // Store tournament data here
//   bool isteamLoading = false;

//   @override
//   void initState() {
//     super.initState();
//     // fetchMyTeamsbyTournamentId();
//   }

//   Future<Map<String, dynamic>> _searchUser(String mobileNumber) async {
//     try {
//       setState(() {
//         isteamLoading = true;
//       });

//       final Map<String, dynamic> data =
//           await signService.getByMobNumber(mobileNumber);
//       setState(() {
//         user = data; // Store the fetched data
//       });
//       print("Response: $data");
//     } catch (e) {
//       print("Error fetching Users: $e");
//     } finally {
//       setState(() {
//         isteamLoading = false;
//       });
//     }
//     return {'found': true, 'name': user['fullName']};
//   }

//   final TextEditingController _controller = TextEditingController();
//   Future<Map<String, dynamic>>? _futureUser;

//   Future<void> _sendInvite(String mobileNumber, int teamId) async {
//     final response = await teamapiService.invitePlayer(mobileNumber, teamId);

//     if (response == 'Invitation  Sent') {
//       // Handle successful invite
//       _showCustomSnackBar(context, 'Invite sent successfully!');
//     } else if (response == 'Invitation already sent..') {
//       // Handle successful invite
//       _showCustomSnackBar(context, 'Invitation already sent!');
//     } else {
//       // Handle failed invite
//       _showCustomSnackBar(context, 'Failed to send invite.');
//     }
//   }

//   void _showCustomSnackBar(BuildContext context, String message) {
//     final overlay = Overlay.of(context);
//     final overlayEntry = OverlayEntry(
//       builder: (context) => Positioned(
//         top: 40.0,
//         right: 20.0,
//         child: Material(
//           color: Colors.transparent,
//           child: Container(
//             padding:
//                 const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//             decoration: BoxDecoration(
//               color: Colors.black.withOpacity(0.8),
//               borderRadius: BorderRadius.circular(8.0),
//             ),
//             child: Text(
//               message,
//               style: const TextStyle(color: Colors.white),
//             ),
//           ),
//         ),
//       ),
//     );

//     overlay?.insert(overlayEntry);
//     Future.delayed(const Duration(seconds: 3), () {
//       overlayEntry.remove();
//     });
//   }

// // *****************************************
//   onTapBtnArrowleftone(BuildContext context) {
//     Navigator.pop(context);
//   }

// // exixsting

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Padding(
//           padding: EdgeInsets.only(left: 20.h),
//           child: Text(
//             "Invite Team",
//             style: theme.textTheme.headlineLarge,
//           ),
//         ),
//         leading: Padding(
//           padding: EdgeInsets.only(
//             top: 4.v,
//             bottom: 11.v,
//           ),
//           child: CustomIconButton(
//             height: 32.adaptSize,
//             width: 32.adaptSize,
//             padding_f: EdgeInsets.all(6.h),
//             decoration: IconButtonStyleHelper.outlineIndigo,
//             onTap: () {
//               onTapBtnArrowleftone(context);
//             },
//             child: CustomImageView(
//               svgPath: ImageConstant.imgArrowLeft,
//             ),
//           ),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: _controller,
//                     decoration: const InputDecoration(
//                       labelText: 'Enter mobile number',
//                     ),
//                     keyboardType: TextInputType.phone,
//                   ),
//                 ),
//                 const SizedBox(width: 8.0),
//                 ElevatedButton(
//                   onPressed: () {
//                     setState(() {
//                       _futureUser = _searchUser(_controller.text);
//                     });
//                   },
//                   child: const Text(
//                     'Search',
//                     style: TextStyle(color: Colors.black),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 16.0),
//             FutureBuilder<Map<String, dynamic>>(
//               future: _futureUser,
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return const CircularProgressIndicator();
//                 } else if (snapshot.hasError) {
//                   return Text('Error: ${snapshot.error}');
//                 } else if (snapshot.hasData) {
//                   final user = snapshot.data!;
//                   final found = user['found'];
//                   final name = found ? user['name'] : 'User not found';

//                   return Column(
//                     children: [
//                       Text(
//                         found
//                             ? 'User: $name'
//                             : 'User not found but you can still send invite',
//                         style: TextStyle(color: Colors.black),
//                       ),
//                       const SizedBox(height: 16.0),
//                       ElevatedButton(
//                         onPressed: () {
//                           _sendInvite(_controller.text, widget.teamId);
//                         },
//                         child: const Text(
//                           'Invite',
//                           style: TextStyle(color: Colors.black),
//                         ),
//                       ),
//                     ],
//                   );
//                 } else {
//                   return Container();
//                 }
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Padding(
//             padding: EdgeInsets.only(left: 20.h),
//             child: Text(
//               "Invite Player",
//               style: theme.textTheme.headlineLarge,
//             ),
//           ),
//           leading: Padding(
//             padding: EdgeInsets.only(
//               top: 4.v,
//               bottom: 11.v,
//             ),
//             child: CustomIconButton(
//               height: 32.adaptSize,
//               width: 32.adaptSize,
//               padding_f: EdgeInsets.all(6.h),
//               decoration: IconButtonStyleHelper.outlineIndigo,
//               onTap: () {
//                 onTapBtnArrowleftone(context);
//               },
//               child: CustomImageView(
//                 svgPath: ImageConstant.imgArrowLeft,
//               ),
//             ),
//           ),
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Row(
//             children: [
//               Expanded(
//                 child: TextField(
//                   controller: _controller,
//                   decoration:
//                       const InputDecoration(labelText: 'Enter mobile number'),
//                   keyboardType: TextInputType.phone,
//                 ),
//               ),
//               const SizedBox(width: 8.0),
//               CustomElevatedButton(
//                 height: 0.1 * MediaQuery.of(context).size.height,
//                 width: 0.25 * MediaQuery.of(context).size.width,
//                 text: "Search",
//                 buttonStyle: CustomButtonStyles.none,
//                 decoration: CustomButtonStyles.fullyBlack,
//                 buttonTextStyle: CustomTextStyles.titleMediumGray50,
//                 onPressed: () {
//                   setState(() {
//                     _futureUser = _searchUser(_controller.text);
//                   });
//                 },
//               ),
//               // ElevatedButton(
//               //   onPressed: () {
//               //     setState(() {
//               //       _futureUser = _searchUser(_controller.text);
//               //     });
//               //   },
//               //   child: const Text('Search'),
//               // ),
//               const SizedBox(height: 16.0),
//               FutureBuilder<Map<String, dynamic>>(
//                 future: _futureUser,
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return const CircularProgressIndicator();
//                   } else if (snapshot.hasError) {
//                     return Text('Error: ${snapshot.error}');
//                   } else if (snapshot.hasData) {
//                     final user = snapshot.data!;
//                     final found = user['found'];
//                     final name = found ? user['name'] : 'User not found';

//                     return Column(
//                       children: [
//                         Text(found
//                             ? 'User: $name'
//                             : 'User not found but you can still send invite',
//                           style: TextStyle(color:Colors.black),),
// ),
//                         const SizedBox(height: 16.0),
//                         CustomElevatedButton(
//                           height: 0.1 * MediaQuery.of(context).size.height,
//                           width: 0.25 * MediaQuery.of(context).size.width,
//                           text: "Invite",
//                           buttonStyle: CustomButtonStyles.none,
//                           decoration: CustomButtonStyles.fullyBlack,
//                           buttonTextStyle: CustomTextStyles.titleMediumGray50,
//                           onPressed: () {
//                             _sendInvite(_controller.text, widget.teamId);
//                           },
//                         ),
//                       ],
//                     );
//                   } else {
//                     return Container();
//                   }
//                 },
//               ),
//             ],
//           ),
//         ));
//   }

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
//                 : users.isEmpty
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
//                         rows: users.map((member) {
//                           return DataRow(
//                             cells: [
//                               DataCell(
//                                 Padding(
//                                   padding: const EdgeInsets.all(5),
//                                   child: Text(
//                                     (users.indexOf(member) + 1).toString(),
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
//                                     width: 60,
//                                     height: 30,
//                                     child: Container(
//                                       decoration: BoxDecoration(
//                                         color: getColor(
//                                             member['rating']?.toDouble() ??
//                                                 0.0),
//                                         borderRadius:
//                                             BorderRadius.circular(5),
//                                       ),
//                                       child: const Center(
//                                         child: Text(
//                                           'Invite',
//                                           style:
//                                               TextStyle(color: Colors.black),
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