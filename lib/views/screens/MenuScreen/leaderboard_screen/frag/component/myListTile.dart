import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyLeaderboardListTile extends StatelessWidget {
  final String type;
  final String title;
  final String subTitle1;
  final String subTitle2;
  final String subTitle3;
  final String subTitle4;
  final String rank;
  final String img;

  const MyLeaderboardListTile({super.key, required this.type, required this.title, required this.subTitle1, required this.subTitle2, required this.subTitle3, required this.subTitle4, required this.rank, required this.img});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.transparent,
              backgroundImage: _buildImageProvider(),
            ),
            title:  Text(title,style: GoogleFonts.getFont('Poppins',color: Colors.black),),
            subtitle:_subtitleRow(),
            trailing: Text(rank,style: GoogleFonts.getFont('Poppins',color: const Color(0xFF219ebc),fontSize: 22),),

          ),
          Divider(color: Colors.grey,thickness: 1,)
        ],
      ),
    );
  }

  Widget _verticalDivider(){
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        height: 12,
        width: 0.5,
        color: Colors.grey,
      ),
    );
  }

  Widget _subtitleRow(){
    return type == 'Bowling' ?
    Row(
      children: [
        Text("Inn: $subTitle1",style: GoogleFonts.getFont('Poppins',color: Colors.black,fontSize: 12,fontWeight: FontWeight.w300),),
        _verticalDivider(),
        Text("W: $subTitle2",style: GoogleFonts.getFont('Poppins',color: Colors.black,fontSize: 12,fontWeight: FontWeight.w500),),
        _verticalDivider(),
        Text("Eco: $subTitle3",style: GoogleFonts.getFont('Poppins',color: Colors.black,fontSize: 12,fontWeight: FontWeight.w300),),
        _verticalDivider(),
        Text("SR: $subTitle4",style: GoogleFonts.getFont('Poppins',color: Colors.black,fontSize: 12,fontWeight: FontWeight.w300),),
      ],
    ) : type == 'Fielding' ? Row(
      children: [
        Text("Mat: $subTitle1",style: GoogleFonts.getFont('Poppins',color: Colors.black,fontSize: 12,fontWeight: FontWeight.w300),),
        _verticalDivider(),
        Text("Dismissals:  $subTitle2",style: GoogleFonts.getFont('Poppins',color: Colors.black,fontSize: 12,fontWeight: FontWeight.w500),),
        _verticalDivider(),
        Text("Catches: $subTitle3",style: GoogleFonts.getFont('Poppins',color: Colors.black,fontSize: 12,fontWeight: FontWeight.w300),),
        _verticalDivider(),
        Text("St: $subTitle4",style: GoogleFonts.getFont('Poppins',color: Colors.black,fontSize: 12,fontWeight: FontWeight.w300),),
      ],
    ) : Row(
      children: [
        Text("Inn: $subTitle1",style: GoogleFonts.getFont('Poppins',color: Colors.black,fontSize: 12,fontWeight: FontWeight.w300),),
        _verticalDivider(),
        Text("Runs:  $subTitle2",style: GoogleFonts.getFont('Poppins',color: Colors.black,fontSize: 12,fontWeight: FontWeight.w500),),
        _verticalDivider(),
        Text("Avg:  $subTitle3",style: GoogleFonts.getFont('Poppins',color: Colors.black,fontSize: 12,fontWeight: FontWeight.w300),),
        _verticalDivider(),
        Text("SR:  $subTitle4",style: GoogleFonts.getFont('Poppins',color: Colors.black,fontSize: 12,fontWeight: FontWeight.w300),),
      ],
    );
  }
  ImageProvider<Object>? _buildImageProvider() {
    if (img=='') {
      // Test URL with placeholder (replace with actual URL once confirmed)
      String testImageUrl = 'https://www.hindustantimes.com/static-content/1y/cricket-logos/players/virat-kohli.png';

      // Return NetworkImage with placeholder URL
      return NetworkImage(testImageUrl);
    } else if (img is Uint8List) {
      // Return MemoryImage with img as Uint8List
      return MemoryImage(img as Uint8List);
    }
    return null;
  }

}
