import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:flutter_app/utils.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../routes/app_routes.dart';
import '../../ReuseableWidgets/BottomAppBarWidget.dart';

class LiveCricketFixture extends StatefulWidget {
  @override
  _LiveCricketFixtureState createState() => _LiveCricketFixtureState();
}

class _LiveCricketFixtureState extends State<LiveCricketFixture> {
  bool _isFixtureSelected = true;
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
                    //header code starts///

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
                                        'assets/vectors/vector_27_x2.svg',
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
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 18),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xFF5285E8),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Container(
                          padding: EdgeInsets.fromLTRB(20, 16, 20, 6),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                },
                                child: Text(
                                  'Fixture',
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
                                  onTapBtnpointtable(context);
                                },
                                child: Text(
                                  'Points Table',
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

                    //header code ends

                    Container(
                      margin: EdgeInsets.fromLTRB(40, 0, 40, 15),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xFF1C2026),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0x33000000),
                                offset: Offset(0, 1),
                                blurRadius: 1,
                              ),
                            ],
                          ),
                          child: Container(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 11),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Color(0xFF2F353F),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                      ),
                                    ),
                                    child: Container(
                                      padding:
                                          EdgeInsets.fromLTRB(15, 9, 10, 12),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin:
                                                EdgeInsets.fromLTRB(0, 0, 0, 3),
                                            child: SizedBox(
                                              width: 310,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.fromLTRB(
                                                        0, 0, 9, 0),
                                                    child: SizedBox(
                                                      width: 254,
                                                      child: Text(
                                                        'Asia Cup 2023, 12th Match',
                                                        style:
                                                            GoogleFonts.getFont(
                                                          'Poppins',
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 12,
                                                          color:
                                                              Color(0xFFFFFFFF),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.fromLTRB(
                                                        0, 1, 0, 0),
                                                    width: 47,
                                                    height: 17,
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            6, 5, 6.5, 5.4),
                                                    child: Container(
                                                      width: 34.5,
                                                      height: 6.6,
                                                      child: SizedBox(
                                                        width: 34.5,
                                                        height: 6.6,
                                                        child: SvgPicture.asset(
                                                          'assets/vectors/finished_1_x2.svg',
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              'Today, 01:00 PM',
                                              style: GoogleFonts.getFont(
                                                'Poppins',
                                                fontWeight: FontWeight.w400,
                                                fontSize: 10,
                                                color: Color(0xFFAAAAAA),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                                  child: SizedBox(
                                    width: 315,
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
                                                  0, 0, 10, 0),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: AssetImage(
                                                      'assets/images/image_3091.png',
                                                    ),
                                                  ),
                                                ),
                                                child: Container(
                                                  width: 36,
                                                  height: 36,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  0, 9, 0, 9),
                                              child: Text(
                                                'Turkey',
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
                                          margin: EdgeInsets.fromLTRB(
                                              0, 11.3, 0, 11.3),
                                          width: 15,
                                          height: 13.3,
                                          child: SizedBox(
                                            width: 15,
                                            height: 13.3,
                                            child: SvgPicture.asset(
                                              'assets/vectors/vector_45_x2.svg',
                                            ),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  0, 9, 10, 9),
                                              child: Text(
                                                'Germany',
                                                style: GoogleFonts.getFont(
                                                  'Poppins',
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 12,
                                                  color: Color(0xFFFFFFFF),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: AssetImage(
                                                    'assets/images/image_3101.png',
                                                  ),
                                                ),
                                              ),
                                              child: Container(
                                                width: 36,
                                                height: 36,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(10, 0, 10, 16),
                                  child: SizedBox(
                                    width: 315,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin:
                                              EdgeInsets.fromLTRB(0, 0, 9, 0),
                                          child: SizedBox(
                                            width: 215.7,
                                            child: RichText(
                                              text: TextSpan(
                                                text: '163-7 ',
                                                style: GoogleFonts.getFont(
                                                  'Poppins',
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 12,
                                                  color: Color(0xFFFFFFFF),
                                                ),
                                                children: [
                                                  TextSpan(
                                                    text: '(20 Over)',
                                                    style: GoogleFonts.getFont(
                                                      'Poppins',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 12,
                                                      height: 1.3,
                                                      color: Color(0xFFAAAAAA),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        RichText(
                                          text: TextSpan(
                                            text: '108-5 ',
                                            style: GoogleFonts.getFont(
                                              'Poppins',
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12,
                                              color: Color(0xFFFFFFFF),
                                            ),
                                            children: [
                                              TextSpan(
                                                text: '(12 Over)',
                                                style: GoogleFonts.getFont(
                                                  'Poppins',
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12,
                                                  height: 1.3,
                                                  color: Color(0xFFAAAAAA),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(13, 0, 12.5, 8),
                                  child: Opacity(
                                    opacity: 0.2,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Color(0xFFFFFFFF),
                                      ),
                                      child: Container(
                                        width: 309.5,
                                        height: 1,
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  'Germany Won by 6 Wickets',
                                  style: GoogleFonts.getFont(
                                    'Poppins',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    color: Color(0xFFFFBB0E),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(40, 0, 40, 15),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xFF1C2026),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0x33000000),
                                offset: Offset(0, 1),
                                blurRadius: 1,
                              ),
                            ],
                          ),
                          child: Container(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 11),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Color(0xFF2F353F),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                      ),
                                    ),
                                    child: Container(
                                      padding:
                                          EdgeInsets.fromLTRB(15, 9, 10, 12),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin:
                                                EdgeInsets.fromLTRB(0, 0, 0, 3),
                                            child: SizedBox(
                                              width: 310,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.fromLTRB(
                                                        0, 0, 9, 0),
                                                    child: SizedBox(
                                                      width: 254,
                                                      child: Text(
                                                        'Asia Cup 2023, 12th Match',
                                                        style:
                                                            GoogleFonts.getFont(
                                                          'Poppins',
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 12,
                                                          color:
                                                              Color(0xFFFFFFFF),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.fromLTRB(
                                                        0, 1, 0, 0),
                                                    width: 47,
                                                    height: 17,
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            6, 5, 6.5, 5.4),
                                                    child: Container(
                                                      width: 34.5,
                                                      height: 6.6,
                                                      child: SizedBox(
                                                        width: 34.5,
                                                        height: 6.6,
                                                        child: SvgPicture.asset(
                                                          'assets/vectors/finished_3_x2.svg',
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              'Today, 01:00 PM',
                                              style: GoogleFonts.getFont(
                                                'Poppins',
                                                fontWeight: FontWeight.w400,
                                                fontSize: 10,
                                                color: Color(0xFFAAAAAA),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                                  child: SizedBox(
                                    width: 315,
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
                                                  0, 0, 10, 0),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: AssetImage(
                                                      'assets/images/image_309.png',
                                                    ),
                                                  ),
                                                ),
                                                child: Container(
                                                  width: 36,
                                                  height: 36,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  0, 9, 0, 9),
                                              child: Text(
                                                'India',
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
                                          margin: EdgeInsets.fromLTRB(
                                              0, 11.3, 0, 11.3),
                                          width: 15,
                                          height: 13.3,
                                          child: SizedBox(
                                            width: 15,
                                            height: 13.3,
                                            child: SvgPicture.asset(
                                              'assets/vectors/vector_6_x2.svg',
                                            ),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  0, 9, 10, 9),
                                              child: Text(
                                                'Pakistan',
                                                style: GoogleFonts.getFont(
                                                  'Poppins',
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 12,
                                                  color: Color(0xFFFFFFFF),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: AssetImage(
                                                    'assets/images/image_310.png',
                                                  ),
                                                ),
                                              ),
                                              child: Container(
                                                width: 36,
                                                height: 36,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(10, 0, 10, 16),
                                  child: SizedBox(
                                    width: 315,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin:
                                              EdgeInsets.fromLTRB(0, 0, 9, 0),
                                          child: SizedBox(
                                            width: 215.7,
                                            child: RichText(
                                              text: TextSpan(
                                                text: '161-5 ',
                                                style: GoogleFonts.getFont(
                                                  'Poppins',
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 12,
                                                  color: Color(0xFFFFFFFF),
                                                ),
                                                children: [
                                                  TextSpan(
                                                    text: '(15 Over)',
                                                    style: GoogleFonts.getFont(
                                                      'Poppins',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 12,
                                                      height: 1.3,
                                                      color: Color(0xFFAAAAAA),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        RichText(
                                          text: TextSpan(
                                            text: '105-2 ',
                                            style: GoogleFonts.getFont(
                                              'Poppins',
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12,
                                              color: Color(0xFFFFFFFF),
                                            ),
                                            children: [
                                              TextSpan(
                                                text: '(16 Over)',
                                                style: GoogleFonts.getFont(
                                                  'Poppins',
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12,
                                                  height: 1.3,
                                                  color: Color(0xFFAAAAAA),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(13, 0, 12.5, 8),
                                  child: Opacity(
                                    opacity: 0.2,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Color(0xFFFFFFFF),
                                      ),
                                      child: Container(
                                        width: 309.5,
                                        height: 1,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 0, 1, 0),
                                  child: Text(
                                    'India Won by 2 Wickets',
                                    style: GoogleFonts.getFont(
                                      'Poppins',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      color: Color(0xFFFFBB0E),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(40, 0, 40, 53),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xFF1C2026),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0x33000000),
                                offset: Offset(0, 1),
                                blurRadius: 1,
                              ),
                            ],
                          ),
                          child: Container(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 11),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Color(0xFF2F353F),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                      ),
                                    ),
                                    child: Container(
                                      padding:
                                          EdgeInsets.fromLTRB(15, 9, 10, 12),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin:
                                                EdgeInsets.fromLTRB(0, 0, 0, 3),
                                            child: SizedBox(
                                              width: 310,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.fromLTRB(
                                                        0, 0, 9, 0),
                                                    child: SizedBox(
                                                      width: 254,
                                                      child: Text(
                                                        'Asia Cup 2023, 12th Match',
                                                        style:
                                                            GoogleFonts.getFont(
                                                          'Poppins',
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 12,
                                                          color:
                                                              Color(0xFFFFFFFF),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.fromLTRB(
                                                        0, 1, 0, 0),
                                                    width: 47,
                                                    height: 17,
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            6, 5, 6.5, 5.4),
                                                    child: Container(
                                                      width: 34.5,
                                                      height: 6.6,
                                                      child: SizedBox(
                                                        width: 34.5,
                                                        height: 6.6,
                                                        child: SvgPicture.asset(
                                                          'assets/vectors/finished_x2.svg',
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              'Today, 01:00 PM',
                                              style: GoogleFonts.getFont(
                                                'Poppins',
                                                fontWeight: FontWeight.w400,
                                                fontSize: 10,
                                                color: Color(0xFFAAAAAA),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                                  child: SizedBox(
                                    width: 315,
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
                                                  0, 0, 10, 0),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: AssetImage(
                                                      'assets/images/image_3092.png',
                                                    ),
                                                  ),
                                                ),
                                                child: Container(
                                                  width: 36,
                                                  height: 36,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  0, 9, 0, 9),
                                              child: Text(
                                                'Jamaica',
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
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  0, 11.3, 33.8, 11.3),
                                              width: 15,
                                              height: 13.3,
                                              child: SizedBox(
                                                width: 15,
                                                height: 13.3,
                                                child: SvgPicture.asset(
                                                  'assets/vectors/vector_17_x2.svg',
                                                ),
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.fromLTRB(
                                                      0, 9, 10, 9),
                                                  child: Text(
                                                    'Switzerland',
                                                    style: GoogleFonts.getFont(
                                                      'Poppins',
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 12,
                                                      color: Color(0xFFFFFFFF),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: AssetImage(
                                                        'assets/images/image_3102.png',
                                                      ),
                                                    ),
                                                  ),
                                                  child: Container(
                                                    width: 36,
                                                    height: 36,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(10, 0, 10, 16),
                                  child: SizedBox(
                                    width: 315,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin:
                                              EdgeInsets.fromLTRB(0, 0, 9, 0),
                                          child: SizedBox(
                                            width: 219,
                                            child: RichText(
                                              text: TextSpan(
                                                text: '135-2 ',
                                                style: GoogleFonts.getFont(
                                                  'Poppins',
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 12,
                                                  color: Color(0xFFFFFFFF),
                                                ),
                                                children: [
                                                  TextSpan(
                                                    text: '(14 Over)',
                                                    style: GoogleFonts.getFont(
                                                      'Poppins',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 12,
                                                      height: 1.3,
                                                      color: Color(0xFFAAAAAA),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        RichText(
                                          text: TextSpan(
                                            text: '118-5 ',
                                            style: GoogleFonts.getFont(
                                              'Poppins',
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12,
                                              color: Color(0xFFFFFFFF),
                                            ),
                                            children: [
                                              TextSpan(
                                                text: '(13 Over)',
                                                style: GoogleFonts.getFont(
                                                  'Poppins',
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12,
                                                  height: 1.3,
                                                  color: Color(0xFFAAAAAA),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(13, 0, 12.5, 8),
                                  child: Opacity(
                                    opacity: 0.2,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Color(0xFFFFFFFF),
                                      ),
                                      child: Container(
                                        width: 309.5,
                                        height: 1,
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  'Switzerland Won by 10 Balls',
                                  style: GoogleFonts.getFont(
                                    'Poppins',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    color: Color(0xFFFFBB0E),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(11, 0, 4, 0),
                      child: SizedBox(
                        width: 409,
                        height: 80,
                        child: SvgPicture.asset(
                          'assets/vectors/subtract_8_x2.svg',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBarWidget(),
    );
  }

  onTapBtnpointtable(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.pointstable);
  }
}
