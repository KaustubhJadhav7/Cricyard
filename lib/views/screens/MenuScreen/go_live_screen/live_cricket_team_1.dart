import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:flutter_app/utils.dart';
import 'package:google_fonts/google_fonts.dart';

class LiveCricketTeam1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFFF0F5F4),
          borderRadius: BorderRadius.circular(25),
        ),
        padding: EdgeInsets.fromLTRB(2, 53, 2, 9),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            SizedBox(
              width: double.infinity,
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
                              border: Border.all(color: Color(0xFFE8ECF4)),
                              borderRadius: BorderRadius.circular(12),
                              color: Color(0xFFC0FE53),
                            ),
                            child: Container(
                              width: 32,
                              height: 32,
                              padding: EdgeInsets.fromLTRB(5.9, 8.1, 9.2, 7),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFFC0FE53),
                                ),
                                child: Container(
                                  width: 16.9,
                                  height: 16.9,
                                  padding:
                                      EdgeInsets.fromLTRB(4.4, 1.8, 4.9, 1.8),
                                  child: SizedBox(
                                    width: 7.6,
                                    height: 13.2,
                                    child: SvgPicture.asset(
                                      'assets/vectors/vector_23_x2.svg',
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
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 16),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFF5285E8),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                        padding: EdgeInsets.fromLTRB(0, 16, 0, 13),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 0, 13.5, 0),
                              child: SizedBox(
                                width: 199.8,
                                child: Text(
                                  'Bangladesh',
                                  style: GoogleFonts.getFont(
                                    'Poppins',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                    color: Color(0xFF000000),
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              'Pakistan',
                              style: GoogleFonts.getFont(
                                'Poppins',
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                color: Color(0xFF000000),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(36, 0, 19, 83),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFF000000),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Container(
                        padding: EdgeInsets.fromLTRB(6, 62, 12, 42),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 0, 0, 17.5),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin:
                                        EdgeInsets.fromLTRB(0, 0, 4.1, 19.5),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  0, 0, 9, 0),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(17),
                                                  image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: AssetImage(
                                                      'assets/images/ellipse_1882.png',
                                                    ),
                                                  ),
                                                ),
                                                child: Container(
                                                  width: 34,
                                                  height: 34,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  0, 7, 0, 9),
                                              child: Text(
                                                'George',
                                                style: GoogleFonts.getFont(
                                                  'Poppins',
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 12,
                                                  color: Color(0xFFFFFFFF),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          margin:
                                              EdgeInsets.fromLTRB(0, 6, 0, 7),
                                          child: SizedBox(
                                            width: 80.4,
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
                                                    width: 24.4,
                                                    child: Text(
                                                      '11',
                                                      style:
                                                          GoogleFonts.getFont(
                                                        'Poppins',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 14,
                                                        color:
                                                            Color(0xFFFFFFFF),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  '6',
                                                  style: GoogleFonts.getFont(
                                                    'Poppins',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 14,
                                                    color: Color(0xFFFFFFFF),
                                                  ),
                                                ),
                                                Text(
                                                  '2',
                                                  style: GoogleFonts.getFont(
                                                    'Poppins',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 14,
                                                    color: Color(0xFFFFFFFF),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin:
                                              EdgeInsets.fromLTRB(0, 6, 0, 7),
                                          child: SizedBox(
                                            width: 62.9,
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
                                                    width: 24.5,
                                                    child: Text(
                                                      '1',
                                                      style:
                                                          GoogleFonts.getFont(
                                                        'Poppins',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 14,
                                                        color:
                                                            Color(0xFFFFFFFF),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  '32.2',
                                                  style: GoogleFonts.getFont(
                                                    'Poppins',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 14,
                                                    color: Color(0xFFFFFFFF),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(1, 0, 0, 0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Color(0x33FFFFFF),
                                      ),
                                      child: Container(
                                        width: 350,
                                        height: 1,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 0, 0, 17.5),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin:
                                        EdgeInsets.fromLTRB(0, 0, 4.1, 19.5),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  0, 0, 9, 0),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(17),
                                                  image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: AssetImage(
                                                      'assets/images/ellipse_1881.png',
                                                    ),
                                                  ),
                                                ),
                                                child: Container(
                                                  width: 34,
                                                  height: 34,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  0, 7, 0, 9),
                                              child: Text(
                                                'Adam',
                                                style: GoogleFonts.getFont(
                                                  'Poppins',
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 12,
                                                  color: Color(0xFFFFFFFF),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          margin:
                                              EdgeInsets.fromLTRB(0, 6, 0, 7),
                                          child: SizedBox(
                                            width: 80.9,
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
                                                    width: 27.6,
                                                    child: Text(
                                                      '21',
                                                      style:
                                                          GoogleFonts.getFont(
                                                        'Poppins',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 14,
                                                        color:
                                                            Color(0xFFFFFFFF),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  '7',
                                                  style: GoogleFonts.getFont(
                                                    'Poppins',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 14,
                                                    color: Color(0xFFFFFFFF),
                                                  ),
                                                ),
                                                Text(
                                                  '1',
                                                  style: GoogleFonts.getFont(
                                                    'Poppins',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 14,
                                                    color: Color(0xFFFFFFFF),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin:
                                              EdgeInsets.fromLTRB(0, 6, 0, 7),
                                          child: SizedBox(
                                            width: 64.9,
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
                                                    width: 26.6,
                                                    child: Text(
                                                      '0',
                                                      style:
                                                          GoogleFonts.getFont(
                                                        'Poppins',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 14,
                                                        color:
                                                            Color(0xFFFFFFFF),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  '32.2',
                                                  style: GoogleFonts.getFont(
                                                    'Poppins',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 14,
                                                    color: Color(0xFFFFFFFF),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(1, 0, 0, 0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Color(0x33FFFFFF),
                                      ),
                                      child: Container(
                                        width: 350,
                                        height: 1,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 0, 0, 17.5),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin:
                                        EdgeInsets.fromLTRB(0, 0, 4.1, 19.5),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  0, 0, 9, 0),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(17),
                                                  image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: AssetImage(
                                                      'assets/images/ellipse_1884.png',
                                                    ),
                                                  ),
                                                ),
                                                child: Container(
                                                  width: 34,
                                                  height: 34,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  0, 7, 0, 9),
                                              child: Text(
                                                'Brian',
                                                style: GoogleFonts.getFont(
                                                  'Poppins',
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 12,
                                                  color: Color(0xFFFFFFFF),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          margin:
                                              EdgeInsets.fromLTRB(0, 6, 0, 7),
                                          child: SizedBox(
                                            width: 78.9,
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
                                                    width: 24.8,
                                                    child: Text(
                                                      '5',
                                                      style:
                                                          GoogleFonts.getFont(
                                                        'Poppins',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 14,
                                                        color:
                                                            Color(0xFFFFFFFF),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  '3',
                                                  style: GoogleFonts.getFont(
                                                    'Poppins',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 14,
                                                    color: Color(0xFFFFFFFF),
                                                  ),
                                                ),
                                                Text(
                                                  '1',
                                                  style: GoogleFonts.getFont(
                                                    'Poppins',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 14,
                                                    color: Color(0xFFFFFFFF),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin:
                                              EdgeInsets.fromLTRB(0, 6, 0, 7),
                                          child: SizedBox(
                                            width: 64.9,
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
                                                    width: 26.6,
                                                    child: Text(
                                                      '0',
                                                      style:
                                                          GoogleFonts.getFont(
                                                        'Poppins',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 14,
                                                        color:
                                                            Color(0xFFFFFFFF),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  '32.2',
                                                  style: GoogleFonts.getFont(
                                                    'Poppins',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 14,
                                                    color: Color(0xFFFFFFFF),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(1, 0, 0, 0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Color(0x33FFFFFF),
                                      ),
                                      child: Container(
                                        width: 350,
                                        height: 1,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 0, 0, 17.5),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin:
                                        EdgeInsets.fromLTRB(0, 0, 4.1, 19.5),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  0, 0, 9, 0),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(17),
                                                  image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: AssetImage(
                                                      'assets/images/ellipse_188.png',
                                                    ),
                                                  ),
                                                ),
                                                child: Container(
                                                  width: 34,
                                                  height: 34,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  0, 7, 0, 9),
                                              child: Text(
                                                'Charles',
                                                style: GoogleFonts.getFont(
                                                  'Poppins',
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 12,
                                                  color: Color(0xFFFFFFFF),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          margin:
                                              EdgeInsets.fromLTRB(0, 6, 0, 7),
                                          child: SizedBox(
                                            width: 78.9,
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
                                                    width: 24.5,
                                                    child: Text(
                                                      '11',
                                                      style:
                                                          GoogleFonts.getFont(
                                                        'Poppins',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 14,
                                                        color:
                                                            Color(0xFFFFFFFF),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  '9',
                                                  style: GoogleFonts.getFont(
                                                    'Poppins',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 14,
                                                    color: Color(0xFFFFFFFF),
                                                  ),
                                                ),
                                                Text(
                                                  '1',
                                                  style: GoogleFonts.getFont(
                                                    'Poppins',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 14,
                                                    color: Color(0xFFFFFFFF),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin:
                                              EdgeInsets.fromLTRB(0, 6, 0, 7),
                                          child: SizedBox(
                                            width: 62.9,
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
                                                    width: 24.5,
                                                    child: Text(
                                                      '1',
                                                      style:
                                                          GoogleFonts.getFont(
                                                        'Poppins',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 14,
                                                        color:
                                                            Color(0xFFFFFFFF),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  '32.2',
                                                  style: GoogleFonts.getFont(
                                                    'Poppins',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 14,
                                                    color: Color(0xFFFFFFFF),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(1, 0, 0, 0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Color(0x33FFFFFF),
                                      ),
                                      child: Container(
                                        width: 350,
                                        height: 1,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 0, 0, 17.5),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin:
                                        EdgeInsets.fromLTRB(0, 0, 4.1, 19.5),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  0, 0, 9, 0),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(17),
                                                  image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: AssetImage(
                                                      'assets/images/ellipse_1885.png',
                                                    ),
                                                  ),
                                                ),
                                                child: Container(
                                                  width: 34,
                                                  height: 34,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  0, 7, 0, 9),
                                              child: Text(
                                                'David',
                                                style: GoogleFonts.getFont(
                                                  'Poppins',
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 12,
                                                  color: Color(0xFFFFFFFF),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          margin:
                                              EdgeInsets.fromLTRB(0, 6, 0, 7),
                                          child: SizedBox(
                                            width: 176.8,
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
                                                    width: 24.5,
                                                    child: Text(
                                                      '7',
                                                      style:
                                                          GoogleFonts.getFont(
                                                        'Poppins',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 14,
                                                        color:
                                                            Color(0xFFFFFFFF),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  '7',
                                                  style: GoogleFonts.getFont(
                                                    'Poppins',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 14,
                                                    color: Color(0xFFFFFFFF),
                                                  ),
                                                ),
                                                Text(
                                                  '0',
                                                  style: GoogleFonts.getFont(
                                                    'Poppins',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 14,
                                                    color: Color(0xFFFFFFFF),
                                                  ),
                                                ),
                                                Text(
                                                  '0',
                                                  style: GoogleFonts.getFont(
                                                    'Poppins',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 14,
                                                    color: Color(0xFFFFFFFF),
                                                  ),
                                                ),
                                                Text(
                                                  '32.2',
                                                  style: GoogleFonts.getFont(
                                                    'Poppins',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 14,
                                                    color: Color(0xFFFFFFFF),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(1, 0, 0, 0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Color(0x33FFFFFF),
                                      ),
                                      child: Container(
                                        width: 350,
                                        height: 1,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 0, 0, 17.5),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin:
                                        EdgeInsets.fromLTRB(0, 0, 4.1, 19.5),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  0, 0, 9, 0),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(17),
                                                  image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: AssetImage(
                                                      'assets/images/ellipse_1883.png',
                                                    ),
                                                  ),
                                                ),
                                                child: Container(
                                                  width: 34,
                                                  height: 34,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  0, 7, 0, 9),
                                              child: Text(
                                                'Ethan',
                                                style: GoogleFonts.getFont(
                                                  'Poppins',
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 12,
                                                  color: Color(0xFFFFFFFF),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          margin:
                                              EdgeInsets.fromLTRB(0, 6, 0, 7),
                                          child: SizedBox(
                                            width: 177.5,
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
                                                    width: 24.5,
                                                    child: Text(
                                                      '4',
                                                      style:
                                                          GoogleFonts.getFont(
                                                        'Poppins',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 14,
                                                        color:
                                                            Color(0xFFFFFFFF),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  '2',
                                                  style: GoogleFonts.getFont(
                                                    'Poppins',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 14,
                                                    color: Color(0xFFFFFFFF),
                                                  ),
                                                ),
                                                Text(
                                                  '0',
                                                  style: GoogleFonts.getFont(
                                                    'Poppins',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 14,
                                                    color: Color(0xFFFFFFFF),
                                                  ),
                                                ),
                                                Text(
                                                  '0',
                                                  style: GoogleFonts.getFont(
                                                    'Poppins',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 14,
                                                    color: Color(0xFFFFFFFF),
                                                  ),
                                                ),
                                                Text(
                                                  '32.2',
                                                  style: GoogleFonts.getFont(
                                                    'Poppins',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 14,
                                                    color: Color(0xFFFFFFFF),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(1, 0, 0, 0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Color(0x33FFFFFF),
                                      ),
                                      child: Container(
                                        width: 350,
                                        height: 1,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 0, 4.1, 1),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.fromLTRB(0, 0, 9, 0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(17),
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: AssetImage(
                                                'assets/images/ellipse_1886.png',
                                              ),
                                            ),
                                          ),
                                          child: Container(
                                            width: 34,
                                            height: 34,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.fromLTRB(0, 7, 0, 9),
                                        child: Text(
                                          'Frank',
                                          style: GoogleFonts.getFont(
                                            'Poppins',
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12,
                                            color: Color(0xFFFFFFFF),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(0, 6, 0, 7),
                                    child: SizedBox(
                                      width: 179.9,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.fromLTRB(
                                                0, 0, 10.5, 0),
                                            child: SizedBox(
                                              width: 26.5,
                                              child: Text(
                                                '21',
                                                style: GoogleFonts.getFont(
                                                  'Poppins',
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14,
                                                  color: Color(0xFFFFFFFF),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text(
                                            '8',
                                            style: GoogleFonts.getFont(
                                              'Poppins',
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14,
                                              color: Color(0xFFFFFFFF),
                                            ),
                                          ),
                                          Text(
                                            '4',
                                            style: GoogleFonts.getFont(
                                              'Poppins',
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14,
                                              color: Color(0xFFFFFFFF),
                                            ),
                                          ),
                                          Text(
                                            '1',
                                            style: GoogleFonts.getFont(
                                              'Poppins',
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14,
                                              color: Color(0xFFFFFFFF),
                                            ),
                                          ),
                                          Text(
                                            '32.2',
                                            style: GoogleFonts.getFont(
                                              'Poppins',
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14,
                                              color: Color(0xFFFFFFFF),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(1, 0, 0, 0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0x33FFFFFF),
                                ),
                                child: Container(
                                  width: 350,
                                  height: 1,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Container(
                  //   margin: EdgeInsets.fromLTRB(11, 0, 4, 0),
                  //   child: SizedBox(
                  //     width: 409,
                  //     height: 80,
                  //     child: SvgPicture.asset(
                  //       'assets/vectors/subtract_x2.svg',
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
            // Positioned(
            //   right: 176,
            //   bottom: 51,
            //   child: Container(
            //     decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(51),
            //       gradient: LinearGradient(
            //         begin: Alignment(0, -1),
            //         end: Alignment(0, 1),
            //         colors: <Color>[Color(0xFFBEFF4C), Color(0x00BBFB4C)],
            //         stops: <double>[0, 1],
            //       ),
            //     ),
            //     child: Container(
            //       width: 64,
            //       height: 64,
            //       child: Container(
            //         width: 20,
            //         height: 20,
            //         child: SizedBox(
            //           width: 20,
            //           height: 20,
            //           child: SvgPicture.asset(
            //             'assets/vectors/vector_12_x2.svg',
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),

            // Positioned(
            //   left: 31,
            //   bottom: 15,
            //   child: Container(
            //     decoration: BoxDecoration(
            //       color: Color(0xFFC7FC6C),
            //       borderRadius: BorderRadius.circular(51),
            //     ),
            //     child: Container(
            //       width: 50,
            //       height: 50,
            //       padding: EdgeInsets.fromLTRB(14, 14, 13.5, 13.5),
            //       child: SizedBox(
            //         width: 22.5,
            //         height: 22.5,
            //         child: SvgPicture.asset(
            //           'assets/vectors/vector_1_x2.svg',
            //         ),
            //       ),
            //     ),
            //   ),
            // ),

            // Positioned(
            //   left: 108,
            //   bottom: 15,
            //   child: Container(
            //     decoration: BoxDecoration(
            //       color: Color(0xFFC7FC6C),
            //       borderRadius: BorderRadius.circular(51),
            //     ),
            //     child: Container(
            //       width: 50,
            //       height: 50,
            //       padding: EdgeInsets.fromLTRB(16.1, 14.1, 14.1, 16.1),
            //       child: Container(
            //         width: 19.8,
            //         height: 19.8,
            //         child: SizedBox(
            //           width: 19.8,
            //           height: 19.8,
            //           child: SvgPicture.asset(
            //             'assets/vectors/vector_x2.svg',
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),

            // Positioned(
            //   right: 93,
            //   bottom: 15,
            //   child: Container(
            //     decoration: BoxDecoration(
            //       color: Color(0xFFC7FC6C),
            //       borderRadius: BorderRadius.circular(51),
            //     ),
            //     child: Container(
            //       width: 50,
            //       height: 50,
            //       padding: EdgeInsets.fromLTRB(15, 18.6, 15, 16.6),
            //       child: Container(
            //         width: 20,
            //         height: 14.7,
            //         child: SizedBox(
            //           width: 20,
            //           height: 14.7,
            //           child: SvgPicture.asset(
            //             'assets/vectors/vector_36_x2.svg',
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),

            // Positioned(
            //   right: 17,
            //   bottom: 15,
            //   child: Container(
            //     decoration: BoxDecoration(
            //       color: Color(0xFFC7FC6C),
            //       borderRadius: BorderRadius.circular(51),
            //     ),
            //     child: Container(
            //       width: 50,
            //       height: 50,
            //       padding: EdgeInsets.fromLTRB(20, 17, 20, 15),
            //       child: Container(
            //         width: 4,
            //         height: 18,
            //         child: SizedBox(
            //           width: 4,
            //           height: 18,
            //           child: SvgPicture.asset(
            //             'assets/vectors/vector_34_x2.svg',
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),

            Positioned(
              left: 56,
              top: 56,
              child: Container(
                width: 107.5,
                height: 56,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Color(0xFF000000),
                      width: 2,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 30,
              right: 19,
              top: 127,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFF2F353F),
                ),
                child: SizedBox(
                  width: 375,
                  height: 45,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(20.4, 12, 21.3, 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 10.5, 0),
                          child: SizedBox(
                            width: 150.1,
                            child: Text(
                              'Batsman',
                              style: GoogleFonts.getFont(
                                'Poppins',
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: Color(0xFFFFFFFF),
                              ),
                            ),
                          ),
                        ),
                        Text(
                          'R',
                          style: GoogleFonts.getFont(
                            'Poppins',
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Color(0xFFFFFFFF),
                          ),
                        ),
                        Text(
                          'B',
                          style: GoogleFonts.getFont(
                            'Poppins',
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Color(0xFFFFFFFF),
                          ),
                        ),
                        Text(
                          '4s',
                          style: GoogleFonts.getFont(
                            'Poppins',
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Color(0xFFFFFFFF),
                          ),
                        ),
                        Text(
                          '6s',
                          style: GoogleFonts.getFont(
                            'Poppins',
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Color(0xFFFFFFFF),
                          ),
                        ),
                        Text(
                          'SR',
                          style: GoogleFonts.getFont(
                            'Poppins',
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Color(0xFFFFFFFF),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
