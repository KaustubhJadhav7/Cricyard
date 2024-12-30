import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:flutter_app/utils.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../ReuseableWidgets/BottomAppBarWidget.dart';

class LiveCricketstInnings extends StatefulWidget {
  @override
  _LiveCricketstInningsState createState() => _LiveCricketstInningsState();
}

class _LiveCricketstInningsState extends State<LiveCricketstInnings> {
  bool _isFixtureSelected = true;
  @override
  Widget build(BuildContext context) {
    // return Container(
    // decoration: BoxDecoration(
    // color: Color(0xFFF0F5F4),
    //   borderRadius: BorderRadius.circular(25),
    // ),
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            // Positioned(
            //   right: 6,
            //   top: 784,
            //   child: SizedBox(
            //     width: 409,
            //     height: 80,
            //     child: SvgPicture.asset(
            //       'assets/vectors/subtract_5_x2.svg',
            //     ),
            //   ),
            // ),
            Container(
              // width: double.infinity, // Full width
              padding: EdgeInsets.fromLTRB(2, 53, 0, 0),

              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  SizedBox(
                    width: 591,
                    // width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(30, 0, 30, 9),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 8, 15.2, 8),
                                  decoration: BoxDecoration(
                                    border:
                                        Border.all(color: Color(0xFFE8ECF4)),
                                    borderRadius: BorderRadius.circular(12),
                                    color: Color(0xFFC0FE53),
                                  ),
                                  child: Container(
                                    width: 32,
                                    height: 32,
                                    padding:
                                        EdgeInsets.fromLTRB(5.9, 8.1, 9.2, 7),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Color(0xFFC0FE53),
                                      ),
                                      child: Container(
                                        width: 16.9,
                                        height: 16.9,
                                        padding: EdgeInsets.fromLTRB(
                                            4.4, 1.8, 4.9, 1.8),
                                        child: SizedBox(
                                          width: 7.6,
                                          height: 13.2,
                                          child: SvgPicture.asset(
                                            'assets/vectors/vector_53_x2.svg',
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  'Live Cricket',
                                  style: GoogleFonts.getFont(
                                    'Poppins',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 32,
                                    color: Color(0xFF000000),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        //BLUE COLOR
                        // Container(
                        //   margin: EdgeInsets.fromLTRB(0, 0, 0, 13),
                        //   child: Align(
                        //     alignment: Alignment.topLeft,
                        //     child: Container(
                        //       decoration: BoxDecoration(
                        //         color: Color(0xFF5285E8),
                        //         borderRadius: BorderRadius.circular(10),
                        //       ),
                        //       child: SizedBox(
                        //         width: 424,
                        //         child: Container(
                        //           padding: EdgeInsets.fromLTRB(0, 16, 0, 13),
                        //           child: Row(
                        //             mainAxisAlignment:
                        //                 MainAxisAlignment.spaceBetween,
                        //             crossAxisAlignment: CrossAxisAlignment.start,
                        //             children: [
                        //               Container(
                        //                 margin:
                        //                     EdgeInsets.fromLTRB(0, 0, 13.5, 0),
                        //                 child: SizedBox(
                        //                   width: 178.8,
                        //                   child: Text(
                        //                     '1St Innings',
                        //                     style: GoogleFonts.getFont(
                        //                       'Poppins',
                        //                       fontWeight: FontWeight.w600,
                        //                       fontSize: 18,
                        //                       color: Color(0xFF000000),
                        //                     ),
                        //                   ),
                        //                 ),
                        //               ),
                        //               Text(
                        //                 '2Nd Innings',
                        //                 style: GoogleFonts.getFont(
                        //                   'Poppins',
                        //                   fontWeight: FontWeight.w600,
                        //                   fontSize: 18,
                        //                   color: Color(0xFF000000),
                        //                 ),
                        //               ),
                        //             ],
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // ),

                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 18),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color(0xFF5285E8),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Container(
                              padding: EdgeInsets.fromLTRB(20, 16, 20, 6),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 20,
                                  ), // Add SizedBox to push Fixture a little to the right
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _isFixtureSelected = true;
                                      });
                                      // onTapBtnfixture(context);
                                    },
                                    child: Text(
                                      '1st Inning',
                                      style: GoogleFonts.getFont(
                                        'Poppins',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18,
                                        color: _isFixtureSelected
                                            ? Color(0xFF000000)
                                            : Color(0xFFAAAAAA),
                                        decoration: _isFixtureSelected
                                            ? TextDecoration.underline
                                            : TextDecoration.none,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ), // Add SizedBox to create space between texts
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _isFixtureSelected = false;
                                      });
                                    },
                                    child: Text(
                                      '2nd Inning',
                                      style: GoogleFonts.getFont(
                                        'Poppins',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18,
                                        color: !_isFixtureSelected
                                            ? Color(0xFF000000)
                                            : Color(0xFFAAAAAA),
                                        decoration: !_isFixtureSelected
                                            ? TextDecoration.underline
                                            : TextDecoration.none,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ), // Add SizedBox to push Points Table a little to the left
                                ],
                              ),
                            ),
                          ),
                        ),

                        // SUB MENU BELOW THE BLUE

                        Container(
                          // margin: EdgeInsets.fromLTRB(30, 0, 30, 25),
                          margin: EdgeInsets.fromLTRB(66, 0, 31, 42),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xFF1C2026),
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: SizedBox(
                                width: 375,
                                child: Container(
                                  padding: EdgeInsets.fromLTRB(0, 8, 0, 11),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin:
                                            EdgeInsets.fromLTRB(11.1, 0, 0, 5),
                                        child: SizedBox(
                                          width: 252,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                                child: SizedBox(
                                                  width: 26,
                                                  height: 26,
                                                  child: SvgPicture.asset(
                                                    'assets/vectors/mask_group_1_x2.svg',
                                                  ),
                                                ),
                                              ),
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                                child: SizedBox(
                                                  width: 26,
                                                  height: 26,
                                                  child: SvgPicture.asset(
                                                    'assets/vectors/mask_group_3_x2.svg',
                                                  ),
                                                ),
                                              ),
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                                child: SizedBox(
                                                  width: 26,
                                                  height: 26,
                                                  child: SvgPicture.asset(
                                                    'assets/vectors/mask_group_x2.svg',
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 274.6,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  0, 0, 9, 0),
                                              child: SizedBox(
                                                width: 98.9,
                                                child: Text(
                                                  'Playing XI',
                                                  style: GoogleFonts.getFont(
                                                    'Poppins',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12,
                                                    color: Color(0xFF535D67),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            // Text(
                                            //   'Match Odd',
                                            //   style: GoogleFonts.getFont(
                                            //     'Poppins',
                                            //     fontWeight: FontWeight.w500,
                                            //     fontSize: 12,
                                            //     color: Color(0xFFFFFFFF),

                                            //   ),
                                            // ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  right:
                                                      52), // Adding right margin
                                              child: Text(
                                                'Match Odd',
                                                style: GoogleFonts.getFont(
                                                  'Poppins',
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 12,
                                                  color: Color(0xFFFFFFFF),
                                                ),
                                              ),
                                            ),
                                            Text(
                                              'Status',
                                              style: GoogleFonts.getFont(
                                                'Poppins',
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12,
                                                color: Color(0xFF535D67),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        // SUBMENU BAR CLOSED

                        Container(
                          margin: EdgeInsets.fromLTRB(66, 0, 31, 42),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xFFE8E2E2),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: SizedBox(
                                width: 369,
                                // width: double.infinity,
                                child: Container(
                                  padding: EdgeInsets.fromLTRB(9, 52, 15, 36),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin:
                                            EdgeInsets.fromLTRB(0, 0, 0, 13),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Color(0xFF1C2026),
                                            borderRadius:
                                                BorderRadius.circular(7),
                                          ),
                                          child: SizedBox(
                                            width: 345,
                                            child: Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  14, 12, 10.7, 13),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.fromLTRB(
                                                        0, 0, 10.5, 0),
                                                    child: SizedBox(
                                                      // width: 219.5,
                                                      width: 200,
                                                      child: RichText(
                                                        text: TextSpan(
                                                          style: GoogleFonts
                                                              .getFont(
                                                            'Poppins',
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 14,
                                                            color: Color(
                                                                0xFFFFFFFF),
                                                          ),
                                                          children: [
                                                            TextSpan(
                                                              text:
                                                                  '19th Over :',
                                                              style: GoogleFonts
                                                                  .getFont(
                                                                'Poppins',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 12,
                                                                height: 1.3,
                                                              ),
                                                            ),
                                                            TextSpan(
                                                              text: ' 11',
                                                            ),
                                                            TextSpan(
                                                              text: ' runs',
                                                              style: GoogleFonts
                                                                  .getFont(
                                                                'Poppins',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 10,
                                                                height: 1.3,
                                                                color: Color(
                                                                    0xFFAAAAAA),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.fromLTRB(
                                                        0, 2, 0, 1),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          margin: EdgeInsets
                                                              .fromLTRB(0, 0,
                                                                  11.1, 0),
                                                          child: Text(
                                                            'India : 147-8',
                                                            style: GoogleFonts
                                                                .getFont(
                                                              'Poppins',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 12,
                                                              color: Color(
                                                                  0xFFFFFFFF),
                                                            ),
                                                          ),
                                                        ),
                                                        // Container(
                                                        //   margin:
                                                        //       EdgeInsets.fromLTRB(
                                                        //           0, 7, 0, 7.4),
                                                        //   width: 6.3,
                                                        //   height: 3.6,
                                                        //   child: SizedBox(
                                                        //     width: 6.3,
                                                        //     height: 3.6,
                                                        //     child:
                                                        //         SvgPicture.asset(
                                                        //       'assets/vectors/polygon_110_x2.svg',
                                                        //     ),
                                                        //   ),
                                                        // ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin:
                                            EdgeInsets.fromLTRB(0, 0, 0, 13),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Color(0xFF1C2026),
                                            borderRadius:
                                                BorderRadius.circular(7),
                                          ),
                                          child: SizedBox(
                                            width: 345,
                                            child: Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  14, 12, 10.7, 13),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.fromLTRB(
                                                        0, 0, 10.5, 0),
                                                    child: SizedBox(
                                                      width: 219.5,
                                                      child: RichText(
                                                        text: TextSpan(
                                                          style: GoogleFonts
                                                              .getFont(
                                                            'Poppins',
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 14,
                                                            color: Color(
                                                                0xFFFFFFFF),
                                                          ),
                                                          children: [
                                                            TextSpan(
                                                              text:
                                                                  '18th Over :',
                                                              style: GoogleFonts
                                                                  .getFont(
                                                                'Poppins',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 12,
                                                                height: 1.3,
                                                              ),
                                                            ),
                                                            TextSpan(
                                                              text: ' ',
                                                            ),
                                                            TextSpan(
                                                              text:
                                                                  '7 runs, 3 w',
                                                              style: GoogleFonts
                                                                  .getFont(
                                                                'Poppins',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 10,
                                                                height: 1.3,
                                                                color: Color(
                                                                    0xFFAAAAAA),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.fromLTRB(
                                                        0, 2, 0, 1),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          margin: EdgeInsets
                                                              .fromLTRB(0, 0,
                                                                  10.7, 0),
                                                          child: Text(
                                                            'India : 136-5',
                                                            style: GoogleFonts
                                                                .getFont(
                                                              'Poppins',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 12,
                                                              color: Color(
                                                                  0xFFFFFFFF),
                                                            ),
                                                          ),
                                                        ),
                                                        // Container(
                                                        //   margin:
                                                        //       EdgeInsets.fromLTRB(
                                                        //           0, 7, 0, 7.4),
                                                        //   width: 6.3,
                                                        //   height: 3.6,
                                                        //   child: SizedBox(
                                                        //     width: 6.3,
                                                        //     height: 3.6,
                                                        //     child:
                                                        //         SvgPicture.asset(
                                                        //       'assets/vectors/polygon_1_x2.svg',
                                                        //     ),
                                                        //   ),
                                                        // ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin:
                                            EdgeInsets.fromLTRB(0, 0, 0, 13),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Color(0xFF1C2026),
                                            borderRadius:
                                                BorderRadius.circular(7),
                                          ),
                                          child: SizedBox(
                                            width: 345,
                                            child: Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  14, 12, 10.7, 14),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.fromLTRB(
                                                        0, 0, 9, 2),
                                                    child: SizedBox(
                                                      width: 221,
                                                      child: RichText(
                                                        text: TextSpan(
                                                          style: GoogleFonts
                                                              .getFont(
                                                            'Poppins',
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 14,
                                                            color: Color(
                                                                0xFFFFFFFF),
                                                          ),
                                                          children: [
                                                            TextSpan(
                                                              text:
                                                                  '17th Over :',
                                                              style: GoogleFonts
                                                                  .getFont(
                                                                'Poppins',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 12,
                                                                height: 1.3,
                                                              ),
                                                            ),
                                                            TextSpan(
                                                              text:
                                                                  ' 10 runs, 1 w',
                                                              style: GoogleFonts
                                                                  .getFont(
                                                                'Poppins',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 10,
                                                                height: 1.3,
                                                                color: Color(
                                                                    0xFFAAAAAA),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.fromLTRB(
                                                        0, 2, 0, 0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          margin: EdgeInsets
                                                              .fromLTRB(0, 0,
                                                                  10.8, 0),
                                                          child: Text(
                                                            'India : 126-4',
                                                            style: GoogleFonts
                                                                .getFont(
                                                              'Poppins',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 12,
                                                              color: Color(
                                                                  0xFFFFFFFF),
                                                            ),
                                                          ),
                                                        ),
                                                        // Container(
                                                        //   margin:
                                                        //       EdgeInsets.fromLTRB(
                                                        //           0, 7, 0, 7.4),
                                                        //   width: 6.3,
                                                        //   height: 3.6,
                                                        //   child: SizedBox(
                                                        //     width: 6.3,
                                                        //     height: 3.6,
                                                        //     child:
                                                        //         SvgPicture.asset(
                                                        //       'assets/vectors/polygon_16_x2.svg',
                                                        //     ),
                                                        //   ),
                                                        // ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin:
                                            EdgeInsets.fromLTRB(0, 0, 0, 13),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Color(0xFF1C2026),
                                            borderRadius:
                                                BorderRadius.circular(7),
                                          ),
                                          child: SizedBox(
                                            width: 345,
                                            child: Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  14, 12, 10.7, 13),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.fromLTRB(
                                                        0, 0, 10.5, 0),
                                                    child: SizedBox(
                                                      width: 219.5,
                                                      child: RichText(
                                                        text: TextSpan(
                                                          style: GoogleFonts
                                                              .getFont(
                                                            'Poppins',
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 14,
                                                            color: Color(
                                                                0xFFFFFFFF),
                                                          ),
                                                          children: [
                                                            TextSpan(
                                                              text:
                                                                  '16th Over :',
                                                              style: GoogleFonts
                                                                  .getFont(
                                                                'Poppins',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 12,
                                                                height: 1.3,
                                                              ),
                                                            ),
                                                            TextSpan(
                                                              text: ' ',
                                                            ),
                                                            TextSpan(
                                                              text:
                                                                  '5 runs, 2 w',
                                                              style: GoogleFonts
                                                                  .getFont(
                                                                'Poppins',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 10,
                                                                height: 1.3,
                                                                color: Color(
                                                                    0xFFAAAAAA),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.fromLTRB(
                                                        0, 2, 0, 1),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          margin: EdgeInsets
                                                              .fromLTRB(0, 0,
                                                                  10.9, 0),
                                                          child: Text(
                                                            'India : 120-6',
                                                            style: GoogleFonts
                                                                .getFont(
                                                              'Poppins',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 12,
                                                              color: Color(
                                                                  0xFFFFFFFF),
                                                            ),
                                                          ),
                                                        ),
                                                        // Container(
                                                        //   margin:
                                                        //       EdgeInsets.fromLTRB(
                                                        //           0, 7, 0, 7.4),
                                                        //   width: 6.3,
                                                        //   height: 3.6,
                                                        //   child: SizedBox(
                                                        //     width: 6.3,
                                                        //     height: 3.6,
                                                        //     child:
                                                        //         SvgPicture.asset(
                                                        //       'assets/vectors/polygon_17_x2.svg',
                                                        //     ),
                                                        //   ),
                                                        // ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin:
                                            EdgeInsets.fromLTRB(0, 0, 0, 13),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Color(0xFF1C2026),
                                            borderRadius:
                                                BorderRadius.circular(7),
                                          ),
                                          child: SizedBox(
                                            width: 345,
                                            child: Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  14, 12, 10.7, 13),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.fromLTRB(
                                                        0, 0, 10.5, 0),
                                                    child: SizedBox(
                                                      width: 219.5,
                                                      child: RichText(
                                                        text: TextSpan(
                                                          style: GoogleFonts
                                                              .getFont(
                                                            'Poppins',
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 14,
                                                            color: Color(
                                                                0xFFFFFFFF),
                                                          ),
                                                          children: [
                                                            TextSpan(
                                                              text:
                                                                  '15th Over :',
                                                              style: GoogleFonts
                                                                  .getFont(
                                                                'Poppins',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 12,
                                                                height: 1.3,
                                                              ),
                                                            ),
                                                            TextSpan(
                                                              text: ' ',
                                                            ),
                                                            TextSpan(
                                                              text: '2 runs',
                                                              style: GoogleFonts
                                                                  .getFont(
                                                                'Poppins',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 10,
                                                                height: 1.3,
                                                                color: Color(
                                                                    0xFFAAAAAA),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.fromLTRB(
                                                        0, 2, 0, 1),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          margin: EdgeInsets
                                                              .fromLTRB(0, 0,
                                                                  10.1, 0),
                                                          child: Text(
                                                            'India : 164-8',
                                                            style: GoogleFonts
                                                                .getFont(
                                                              'Poppins',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 12,
                                                              color: Color(
                                                                  0xFFFFFFFF),
                                                            ),
                                                          ),
                                                        ),
                                                        // Container(
                                                        //   margin:
                                                        //       EdgeInsets.fromLTRB(
                                                        //           0, 7, 0, 7.4),
                                                        //   width: 6.3,
                                                        //   height: 3.6,
                                                        //   child: SizedBox(
                                                        //     width: 6.3,
                                                        //     height: 3.6,
                                                        //     child:
                                                        //         SvgPicture.asset(
                                                        //       'assets/vectors/polygon_18_x2.svg',
                                                        //     ),
                                                        //   ),
                                                        // ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin:
                                            EdgeInsets.fromLTRB(0, 0, 0, 13),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Color(0xFF1C2026),
                                            borderRadius:
                                                BorderRadius.circular(7),
                                          ),
                                          child: SizedBox(
                                            width: 345,
                                            child: Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  14, 12, 10.7, 13),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.fromLTRB(
                                                        0, 0, 10.5, 0),
                                                    child: SizedBox(
                                                      width: 219.5,
                                                      child: RichText(
                                                        text: TextSpan(
                                                          style: GoogleFonts
                                                              .getFont(
                                                            'Poppins',
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 14,
                                                            color: Color(
                                                                0xFFFFFFFF),
                                                          ),
                                                          children: [
                                                            TextSpan(
                                                              text:
                                                                  '14th Over :',
                                                              style: GoogleFonts
                                                                  .getFont(
                                                                'Poppins',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 12,
                                                                height: 1.3,
                                                              ),
                                                            ),
                                                            TextSpan(
                                                              text: ' ',
                                                            ),
                                                            TextSpan(
                                                              text:
                                                                  '7 runs, 3 w',
                                                              style: GoogleFonts
                                                                  .getFont(
                                                                'Poppins',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 10,
                                                                height: 1.3,
                                                                color: Color(
                                                                    0xFFAAAAAA),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.fromLTRB(
                                                        0, 2, 0, 1),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          margin: EdgeInsets
                                                              .fromLTRB(0, 0,
                                                                  11.6, 0),
                                                          child: Text(
                                                            'India : 124-2',
                                                            style: GoogleFonts
                                                                .getFont(
                                                              'Poppins',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 12,
                                                              color: Color(
                                                                  0xFFFFFFFF),
                                                            ),
                                                          ),
                                                        ),
                                                        // Container(
                                                        //   margin:
                                                        //       EdgeInsets.fromLTRB(
                                                        //           0, 7, 0, 7.4),
                                                        //   width: 6.3,
                                                        //   height: 3.6,
                                                        //   child: SizedBox(
                                                        //     width: 6.3,
                                                        //     height: 3.6,
                                                        //     child:
                                                        //         SvgPicture.asset(
                                                        //       'assets/vectors/polygon_12_x2.svg',
                                                        //     ),
                                                        //   ),
                                                        // ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Color(0xFF1C2026),
                                          borderRadius:
                                              BorderRadius.circular(7),
                                        ),
                                        child: SizedBox(
                                          width: 345,
                                          child: Container(
                                            padding: EdgeInsets.fromLTRB(
                                                14, 12, 10.7, 13),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.fromLTRB(
                                                      0, 0, 10.5, 0),
                                                  child: SizedBox(
                                                    width: 219.5,
                                                    child: RichText(
                                                      text: TextSpan(
                                                        style:
                                                            GoogleFonts.getFont(
                                                          'Poppins',
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 14,
                                                          color:
                                                              Color(0xFFFFFFFF),
                                                        ),
                                                        children: [
                                                          TextSpan(
                                                            text: '13th Over :',
                                                            style: GoogleFonts
                                                                .getFont(
                                                              'Poppins',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 12,
                                                              height: 1.3,
                                                            ),
                                                          ),
                                                          TextSpan(
                                                            text: ' ',
                                                          ),
                                                          TextSpan(
                                                            text: '13runs, 3 w',
                                                            style: GoogleFonts
                                                                .getFont(
                                                              'Poppins',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 10,
                                                              height: 1.3,
                                                              color: Color(
                                                                  0xFFAAAAAA),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.fromLTRB(
                                                      0, 2, 0, 1),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        margin:
                                                            EdgeInsets.fromLTRB(
                                                                0, 0, 13.7, 0),
                                                        child: Text(
                                                          'India : 110-8',
                                                          style: GoogleFonts
                                                              .getFont(
                                                            'Poppins',
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 12,
                                                            color: Color(
                                                                0xFFFFFFFF),
                                                          ),
                                                        ),
                                                      ),
                                                      // Container(
                                                      //   margin:
                                                      //       EdgeInsets.fromLTRB(
                                                      //           0, 7, 0, 7.4),
                                                      //   width: 6.3,
                                                      //   height: 3.6,
                                                      //   child: SizedBox(
                                                      //     width: 6.3,
                                                      //     height: 3.6,
                                                      //     child: SvgPicture.asset(
                                                      //       'assets/vectors/polygon_19_x2.svg',
                                                      //     ),
                                                      //   ),
                                                      // ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // i think its an above is bottom
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBarWidget(),
    );
  }
}
