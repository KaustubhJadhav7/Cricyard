import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:flutter_app/utils.dart';
import 'package:google_fonts/google_fonts.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return 
    Container(
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(32),
      ),
      child: Container(
        padding: EdgeInsets.fromLTRB(0, 46, 0, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(18, 0, 18, 47.1),
              child: Align(
                alignment: Alignment.topLeft,
                child: SizedBox(
                  width: 195,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 48,
                        height: 48,
                        child: Container(
                          padding: EdgeInsets.fromLTRB(19.5, 16, 19.5, 16),
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                width: 9,
                                height: 16,
                                child: SizedBox(
                                  width: 9,
                                  height: 16,
                                  child: SvgPicture.asset(
                                    'assets/vectors/vector_745_x2.svg',
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: -16,
                                child: Container(
                                  width: 48,
                                  height: 48,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Color(0xFFF5F5F5)),
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 7, 0, 1),
                        child: Text(
                          'Settings',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.getFont(
                            'Kumbh Sans',
                            fontWeight: FontWeight.w700,
                            fontSize: 24,
                            height: 0.8,
                            letterSpacing: -0.5,
                            color: Color(0xFF121212),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 35.6),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(18, 0, 18, 20.2),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Account',
                        style: GoogleFonts.getFont(
                          'Kumbh Sans',
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          height: 1.4,
                          letterSpacing: -0.3,
                          color: Color(0xFF7647EB),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(18, 0, 29.3, 16.1),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                          child: SizedBox(
                            width: 310.3,
                            child: Text(
                              'Edit Profile',
                              style: GoogleFonts.getFont(
                                'Kumbh Sans',
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                height: 1.3,
                                letterSpacing: -0.3,
                                color: Color(0xFF121212),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 2.3, 0, 4.3),
                          width: 7.5,
                          height: 13.4,
                          child: SizedBox(
                            width: 7.5,
                            height: 13.4,
                            child: SvgPicture.asset(
                              'assets/vectors/vector_593_x2.svg',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(18, 0, 0, 15.6),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFF5F5F5),
                      ),
                      child: Container(
                        width: 357.1,
                        height: 1.5,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(18, 0, 29.3, 16.1),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                          child: SizedBox(
                            width: 310.2,
                            child: Text(
                              'Password',
                              style: GoogleFonts.getFont(
                                'Kumbh Sans',
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                height: 1.3,
                                letterSpacing: -0.3,
                                color: Color(0xFF121212),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 5.3, 0, 1.3),
                          width: 7.5,
                          height: 13.4,
                          child: SizedBox(
                            width: 7.5,
                            height: 13.4,
                            child: SvgPicture.asset(
                              'assets/vectors/vector_56_x2.svg',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(18, 0, 0, 15.6),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFF5F5F5),
                      ),
                      child: Container(
                        width: 357.1,
                        height: 1.5,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(18, 0, 29.3, 14.4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 10, 1.7),
                          child: SizedBox(
                            width: 310.3,
                            child: Text(
                              'Language',
                              style: GoogleFonts.getFont(
                                'Kumbh Sans',
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                height: 1.3,
                                letterSpacing: -0.3,
                                color: Color(0xFF121212),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 8.3, 0, 0),
                          width: 7.5,
                          height: 13.4,
                          child: SizedBox(
                            width: 7.5,
                            height: 13.4,
                            child: SvgPicture.asset(
                              'assets/vectors/vector_839_x2.svg',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFF5F5F5),
                    ),
                    child: Container(
                      width: 375.1,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 35.6),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(18, 0, 18, 21.2),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Preferences',
                        style: GoogleFonts.getFont(
                          'Kumbh Sans',
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          height: 1.4,
                          letterSpacing: -0.3,
                          color: Color(0xFF7647EB),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(18, 0, 29.3, 16.1),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                          child: SizedBox(
                            width: 310.3,
                            child: Text(
                              'Theme',
                              style: GoogleFonts.getFont(
                                'Kumbh Sans',
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                height: 1.3,
                                letterSpacing: -0.3,
                                color: Color(0xFF121212),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 2.3, 0, 4.3),
                          width: 7.5,
                          height: 13.4,
                          child: SizedBox(
                            width: 7.5,
                            height: 13.4,
                            child: SvgPicture.asset(
                              'assets/vectors/vector_385_x2.svg',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(18, 0, 0, 15.6),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFF5F5F5),
                      ),
                      child: Container(
                        width: 357.1,
                        height: 1.5,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(18, 0, 29.3, 16.1),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                          child: SizedBox(
                            width: 310.2,
                            child: Text(
                              'Notifications',
                              style: GoogleFonts.getFont(
                                'Kumbh Sans',
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                height: 1.3,
                                letterSpacing: -0.3,
                                color: Color(0xFF121212),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 1.3, 0, 5.3),
                          width: 7.5,
                          height: 13.4,
                          child: SizedBox(
                            width: 7.5,
                            height: 13.4,
                            child: SvgPicture.asset(
                              'assets/vectors/vector_148_x2.svg',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(18, 0, 0, 15.6),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFF5F5F5),
                      ),
                      child: Container(
                        width: 357.1,
                        height: 1.5,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(18, 0, 29.3, 16.1),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                          child: SizedBox(
                            width: 310.3,
                            child: Text(
                              'Attendance',
                              style: GoogleFonts.getFont(
                                'Kumbh Sans',
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                height: 1.3,
                                letterSpacing: -0.3,
                                color: Color(0xFF121212),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 3.3, 0, 3.3),
                          width: 7.5,
                          height: 13.4,
                          child: SizedBox(
                            width: 7.5,
                            height: 13.4,
                            child: SvgPicture.asset(
                              'assets/vectors/vector_69_x2.svg',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFF5F5F5),
                    ),
                    child: Container(
                      width: 375.1,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 35.6),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(18, 0, 18, 21.3),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Advanced Settings',
                        style: GoogleFonts.getFont(
                          'Kumbh Sans',
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          height: 1.4,
                          letterSpacing: -0.3,
                          color: Color(0xFF7647EB),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(18, 0, 29.3, 16.2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                          child: SizedBox(
                            width: 310.2,
                            child: Text(
                              'Clear Analytics Record',
                              style: GoogleFonts.getFont(
                                'Kumbh Sans',
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                height: 1.3,
                                letterSpacing: -0.3,
                                color: Color(0xFF121212),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 2.3, 0, 4.3),
                          width: 7.5,
                          height: 13.4,
                          child: SizedBox(
                            width: 7.5,
                            height: 13.4,
                            child: SvgPicture.asset(
                              'assets/vectors/vector_323_x2.svg',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(18, 0, 0, 15.7),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFF5F5F5),
                      ),
                      child: Container(
                        width: 357.1,
                        height: 1.5,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(18, 0, 29.3, 16.2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                          child: SizedBox(
                            width: 310.3,
                            child: Text(
                              'Clear Cache',
                              style: GoogleFonts.getFont(
                                'Kumbh Sans',
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                height: 1.3,
                                letterSpacing: -0.3,
                                color: Color(0xFF121212),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 5.3, 0, 1.3),
                          width: 7.5,
                          height: 13.4,
                          child: SizedBox(
                            width: 7.5,
                            height: 13.4,
                            child: SvgPicture.asset(
                              'assets/vectors/vector_410_x2.svg',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFF5F5F5),
                    ),
                    child: Container(
                      width: 375.1,
                      height: 1.5,
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
                  margin: EdgeInsets.fromLTRB(18, 0, 18, 11.3),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Support',
                      style: GoogleFonts.getFont(
                        'Kumbh Sans',
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        height: 1.4,
                        letterSpacing: -0.3,
                        color: Color(0xFF7647EB),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(18, 0, 29.3, 6.2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
                        child: SizedBox(
                          width: 300.2,
                          child: Text(
                            'Terms of Service & Privacy',
                            style: GoogleFonts.getFont(
                              'Kumbh Sans',
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              height: 1.3,
                              letterSpacing: -0.3,
                              color: Color(0xFF121212),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 12.3, 0, 14.3),
                        width: 7.5,
                        height: 13.4,
                        child: SizedBox(
                          width: 7.5,
                          height: 13.4,
                          child: SvgPicture.asset(
                            'assets/vectors/vector_318_x2.svg',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(18, 0, 0, 15.7),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFF5F5F5),
                    ),
                    child: Container(
                      width: 357.1,
                      height: 1.5,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(18, 0, 29.3, 16.2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                        child: SizedBox(
                          width: 310.3,
                          child: Text(
                            'Clear Cache',
                            style: GoogleFonts.getFont(
                              'Kumbh Sans',
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              height: 1.3,
                              letterSpacing: -0.3,
                              color: Color(0xFF121212),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 5.3, 0, 1.3),
                        width: 7.5,
                        height: 13.4,
                        child: SizedBox(
                          width: 7.5,
                          height: 13.4,
                          child: SvgPicture.asset(
                            'assets/vectors/vector_852_x2.svg',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFF5F5F5),
                  ),
                  child: Container(
                    width: 375.1,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}