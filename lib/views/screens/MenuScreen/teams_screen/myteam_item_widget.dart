import 'dart:typed_data';

import 'package:cricyard/core/app_export.dart';
import 'package:cricyard/core/utils/image_constant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../theme/app_decoration.dart';
import '../../../../providers/photo_provider.dart';
import 'teamView/InvitePlayer_view.dart';

class myteam_item_widget extends StatefulWidget {
  final Map<String, dynamic> teamData;
  final int players;
  final VoidCallback onTap;
  final bool isEnrolled;

  myteam_item_widget(
      {Key? key,
      required this.teamData,
      required this.onTap,
      required this.isEnrolled,
      required this.players})
      : super(key: key);

  @override
  State<myteam_item_widget> createState() => _myteam_item_widgetState();
}

class _myteam_item_widgetState extends State<myteam_item_widget> {
  void _invitePlayer(BuildContext context) {
    print('invite team screen:::  ${widget.teamData['id']}');
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => InvitePlayerView(
                int.tryParse(widget.teamData['id'].toString()) ?? 0)) // Corrected screen name
        );
    print("Invite Player clicked");
  }

  final PhotoProvider _photoProvider = PhotoProvider();

  Uint8List? imageData;

  Future<void> fetchImage() async {
    Uint8List? imageBytes = await _photoProvider.fetchPhoto();
    if (imageBytes != null) {
      setState(() {
        imageData = imageBytes;
      });
    }
  }

  @override
  void initState() {
    fetchImage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.7,
        height: MediaQuery.of(context).size.height * 0.1,
        padding: EdgeInsets.all(14.h),
        decoration: AppDecoration.outlineGray.copyWith(
          borderRadius: BorderRadiusStyle.roundedBorder16,
        ),
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    imageData != null
                        ? CircleAvatar(
                            radius: 10,
                            backgroundImage: MemoryImage(imageData!),
                          )
                        : CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.white,
                            backgroundImage:
                                AssetImage(ImageConstant.imageTeams),
                          ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      widget.teamData['team_name'].toUpperCase(),
                      style: GoogleFonts.getFont('Poppins',
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: 10.v),
                Padding(
                  padding: const EdgeInsets.only(left: 50.0),
                  child: Text(
                    "Players :- ${widget.players}",
                    style: GoogleFonts.getFont(
                      'Poppins',
                      color: theme.colorScheme.primary,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
            widget.isEnrolled
                ? Container()
                : Positioned(
                    right: 0,
                    child: SizedBox(
                        height: 20,
                        child: InkWell(
                            onTap: () {
                              _invitePlayer(context);
                            },
                            child: Image.asset(
                              ImageConstant.imgAddPlayer,
                              color: Colors.black,
                            ))),
                  ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Text(
                widget.teamData.containsKey('team_owner_id')
                    ? widget.teamData['team_owner_id'] == ''
                        ? "Member"
                        : "Owner"
                    : 'Member',
                style: GoogleFonts.getFont('Poppins', color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
