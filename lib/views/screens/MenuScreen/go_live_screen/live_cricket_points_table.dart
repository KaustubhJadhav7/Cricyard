import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:flutter_app/utils.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../routes/app_routes.dart';
import '../../ReuseableWidgets/BottomAppBarWidget.dart';

class LiveCricketPointsTable extends StatefulWidget {
  @override
  _LiveCricketPointsTableState createState() => _LiveCricketPointsTableState();
}

class _LiveCricketPointsTableState extends State<LiveCricketPointsTable> {
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
          padding: EdgeInsets.fromLTRB(2, 51, 2, 9),
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
                      margin: EdgeInsets.fromLTRB(30, 0, 30, 11),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 10, 11.2, 6),
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
                                        'assets/vectors/vector_67_x2.svg',
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

                    ///BLUE COLOR PART

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
                                  onTapBtnfixture(context);
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

                    //BLUE COLOR PART  AND END OF HEADER

                    Container(
                      margin: EdgeInsets.fromLTRB(27, 0, 28, 50),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xFF000000),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Container(
                          padding: EdgeInsets.fromLTRB(10, 68, 9, 3.5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 0, 0, 23.5),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin:
                                          EdgeInsets.fromLTRB(7, 0, 2.1, 23.5),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin:
                                                EdgeInsets.fromLTRB(0, 2, 0, 1),
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
                                            '3',
                                            style: GoogleFonts.getFont(
                                              'Poppins',
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14,
                                              color: Color(0xFFFFFFFF),
                                            ),
                                          ),
                                          Text(
                                            '5',
                                            style: GoogleFonts.getFont(
                                              'Poppins',
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14,
                                              color: Color(0xFFFFFFFF),
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
                                          Text(
                                            '-0.036',
                                            style: GoogleFonts.getFont(
                                              'Poppins',
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14,
                                              color: Color(0xFFDB2137),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Opacity(
                                      opacity: 0.2,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Color(0xFFFFFFFF),
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
                                margin: EdgeInsets.fromLTRB(0, 0, 0, 23.5),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin:
                                          EdgeInsets.fromLTRB(7, 0, 11.3, 23.5),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin:
                                                EdgeInsets.fromLTRB(0, 2, 0, 1),
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
                                            '4',
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
                                            '0.25',
                                            style: GoogleFonts.getFont(
                                              'Poppins',
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14,
                                              color: Color(0xFF0DAC13),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Opacity(
                                      opacity: 0.2,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Color(0xFFFFFFFF),
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
                                margin: EdgeInsets.fromLTRB(0, 0, 0, 23.5),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin:
                                          EdgeInsets.fromLTRB(7, 0, 4.3, 23.5),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin:
                                                EdgeInsets.fromLTRB(0, 2, 0, 1),
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
                                            '8',
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
                                            '4',
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
                                            '-0.021',
                                            style: GoogleFonts.getFont(
                                              'Poppins',
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14,
                                              color: Color(0xFFDB2137),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Opacity(
                                      opacity: 0.2,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Color(0xFFFFFFFF),
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
                                margin: EdgeInsets.fromLTRB(0, 0, 0, 23.5),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin:
                                          EdgeInsets.fromLTRB(7, 0, 6.3, 23.5),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin:
                                                EdgeInsets.fromLTRB(0, 2, 0, 1),
                                            child: Text(
                                              'Henry',
                                              style: GoogleFonts.getFont(
                                                'Poppins',
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12,
                                                color: Color(0xFFFFFFFF),
                                              ),
                                            ),
                                          ),
                                          Text(
                                            '5',
                                            style: GoogleFonts.getFont(
                                              'Poppins',
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14,
                                              color: Color(0xFFFFFFFF),
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
                                            '1',
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
                                            '-0.011',
                                            style: GoogleFonts.getFont(
                                              'Poppins',
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14,
                                              color: Color(0xFFDB2137),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Opacity(
                                      opacity: 0.2,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Color(0xFFFFFFFF),
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
                                margin: EdgeInsets.fromLTRB(0, 0, 0, 23.5),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin:
                                          EdgeInsets.fromLTRB(7, 0, 11.1, 23.5),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin:
                                                EdgeInsets.fromLTRB(0, 2, 0, 1),
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
                                            '3',
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
                                            '1',
                                            style: GoogleFonts.getFont(
                                              'Poppins',
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14,
                                              color: Color(0xFFFFFFFF),
                                            ),
                                          ),
                                          Text(
                                            '0.32',
                                            style: GoogleFonts.getFont(
                                              'Poppins',
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14,
                                              color: Color(0xFF0DAC13),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Opacity(
                                      opacity: 0.2,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Color(0xFFFFFFFF),
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
                                margin: EdgeInsets.fromLTRB(0, 0, 0, 23.5),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin:
                                          EdgeInsets.fromLTRB(7, 0, 11.3, 23.5),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin:
                                                EdgeInsets.fromLTRB(0, 2, 0, 1),
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
                                            '3',
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
                                            '3',
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
                                          Text(
                                            '0.62',
                                            style: GoogleFonts.getFont(
                                              'Poppins',
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14,
                                              color: Color(0xFF0DAC13),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Opacity(
                                      opacity: 0.2,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Color(0xFFFFFFFF),
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
                                margin: EdgeInsets.fromLTRB(0, 0, 0, 23.5),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin:
                                          EdgeInsets.fromLTRB(7, 0, 14.4, 23.5),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin:
                                                EdgeInsets.fromLTRB(0, 2, 0, 1),
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
                                          Text(
                                            '1',
                                            style: GoogleFonts.getFont(
                                              'Poppins',
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14,
                                              color: Color(0xFFFFFFFF),
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
                                                    0, 0, 20.9, 0),
                                                child: Text(
                                                  '2',
                                                  style: GoogleFonts.getFont(
                                                    'Poppins',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 14,
                                                    color: Color(0xFFFFFFFF),
                                                  ),
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
                                            ],
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
                                            '1',
                                            style: GoogleFonts.getFont(
                                              'Poppins',
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14,
                                              color: Color(0xFFFFFFFF),
                                            ),
                                          ),
                                          Text(
                                            '0.11',
                                            style: GoogleFonts.getFont(
                                              'Poppins',
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14,
                                              color: Color(0xFF0DAC13),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Opacity(
                                      opacity: 0.2,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Color(0xFFFFFFFF),
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
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin:
                                        EdgeInsets.fromLTRB(7, 0, 14.4, 23.5),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin:
                                              EdgeInsets.fromLTRB(0, 2, 0, 1),
                                          child: Text(
                                            'Banti',
                                            style: GoogleFonts.getFont(
                                              'Poppins',
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12,
                                              color: Color(0xFFFFFFFF),
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
                                          '1',
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
                                          '0.11',
                                          style: GoogleFonts.getFont(
                                            'Poppins',
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                            color: Color(0xFF0DAC13),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Opacity(
                                    opacity: 0.2,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Color(0xFFFFFFFF),
                                      ),
                                      child: Container(
                                        width: 350,
                                        height: 1,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
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
                          'assets/vectors/subtract_1_x2.svg',
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              //bottom starts

              Positioned(
                left: 24,
                right: 25,
                top: 135,
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF1C2026),
                  ),
                  child: SizedBox(
                    width: 375,
                    height: 45,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(20, 12, 24.1, 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 10.5, 0),
                            child: SizedBox(
                              width: 114.6,
                              child: Text(
                                'Teams',
                                style: GoogleFonts.getFont(
                                  'Poppins',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: Color(0xFFFFFFFF),
                                ),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 0, 20.1, 0),
                                child: Text(
                                  'R',
                                  style: GoogleFonts.getFont(
                                    'Poppins',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    color: Color(0xFFFFFFFF),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 0, 20.4, 0),
                                child: Text(
                                  'W',
                                  style: GoogleFonts.getFont(
                                    'Poppins',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    color: Color(0xFFFFFFFF),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 0, 20.4, 0),
                                child: Text(
                                  'L',
                                  style: GoogleFonts.getFont(
                                    'Poppins',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    color: Color(0xFFFFFFFF),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 0, 20.5, 0),
                                child: Text(
                                  'NR',
                                  style: GoogleFonts.getFont(
                                    'Poppins',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    color: Color(0xFFFFFFFF),
                                  ),
                                ),
                              ),
                              Text(
                                'Pts',
                                style: GoogleFonts.getFont(
                                  'Poppins',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: Color(0xFFFFFFFF),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            'NRR',
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
      ),
      bottomNavigationBar: BottomAppBarWidget(),
    );
  }

  onTapBtnfixture(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.Fixturelive);
  }
}
