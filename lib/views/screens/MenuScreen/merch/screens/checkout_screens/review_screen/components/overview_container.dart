import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OverviewContainer extends StatelessWidget {
  final String ? title;
  final String ? contentTitle;
  final String ? contentDesc1;
  final String ? contentDesc2;
  const OverviewContainer({super.key, this.title, this.contentTitle, this.contentDesc1, this.contentDesc2,});

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      height: MediaQuery.of(context).size.height*0.1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(child: Text("$title",style: GoogleFonts.getFont('Poppins',color: Colors.black,fontSize: 19,fontWeight: FontWeight.w500),)),
                Expanded(
                  flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("$contentTitle",style: GoogleFonts.getFont('Poppins',color: Colors.black,fontSize: 17,fontWeight: FontWeight.w500),),
                        Text("$contentDesc1,",style: GoogleFonts.getFont('Poppins',color: Colors.grey[700],fontSize: 13,fontWeight: FontWeight.w300),),
                        Text("$contentDesc2",style: GoogleFonts.getFont('Poppins',color: Colors.grey[700],fontSize: 13,fontWeight: FontWeight.w300),)
                      ],
                    )),


              ],
            ),
          ),
          SizedBox(height: 20,),
          Divider(color: Colors.grey,)
        ],
      ),
    );
  }
}
