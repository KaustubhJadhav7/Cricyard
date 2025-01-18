
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../../providers/photo_provider.dart';
import '../../views/inviteTeam_screen.dart';

class ScoreboardcardlistItemWidget extends StatefulWidget {
  final Map<String, dynamic> tournamentData;
  
  final VoidCallback onTap;

   ScoreboardcardlistItemWidget(
      {Key? key,
      required this.tournamentData,
      required this.onTap,
      required String tournamentName})
      : super(key: key);

  @override
  State<ScoreboardcardlistItemWidget> createState() => _ScoreboardcardlistItemWidgetState();
}

class _ScoreboardcardlistItemWidgetState extends State<ScoreboardcardlistItemWidget> {
  void _inviteTeam(BuildContext context) {
    // print("Tournament Data: ${widget.tournamentData}");
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                InviteTeamScreen(widget.tournamentData['id'])) // Corrected screen name
        );
    // print("Invite Team clicked");
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
    String tournamentName = widget.tournamentData['tournament_name']?.toString() ?? 'No Tournament Name';
    return GestureDetector(
      onTap: widget.onTap,
      child:Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: MediaQuery.of(context).size.width*0.7,
          height: 30,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12)
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // tour name and logo  and invite icons here
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                   Row(
                     mainAxisAlignment: MainAxisAlignment.start,
                     children: [
                       imageData !=null ? CircleAvatar(
                         radius: 10,
                         backgroundImage: MemoryImage(imageData!),
                       ):  const CircleAvatar(
                         radius: 20,
                         backgroundColor: Colors.white,
                         backgroundImage:NetworkImage("https://cdn.vectorstock.com/i/500p/53/27/trophy-cup-icon-vector-13465327.jpg"),
                       ),

                       const SizedBox(width: 8,),
                       SizedBox(
                         width: MediaQuery.of(context).size.width*0.4,
                         child: FittedBox(
                             fit: BoxFit.scaleDown,
                             child: Text(tournamentName,style: GoogleFonts.getFont('Poppins',fontWeight: FontWeight.bold,fontSize: 18,color: Colors.black),)),
                       ),
                     ],
                   ),
                   Expanded(
                     child: GestureDetector(
                         onTap: () {
                           _inviteTeam(context);
                         },
                         child: const Icon(Icons.group_add,color: Colors.black,)),
                   )
                  ],
                ),
               Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 mainAxisAlignment: MainAxisAlignment.start,
                 children: [
                   // venue here
                   Text("${widget.tournamentData['venues']}",style: GoogleFonts.getFont('Poppins',color: Colors.blue,fontSize: 14),),
                   // Dates
                   Text("${widget.tournamentData['dates']}",style: GoogleFonts.getFont('Poppins',color: Colors.blue,fontSize: 14),),
                 ],
               )
              ],
            ),
          ),
        ),
      ) ,
    );
  }
}

