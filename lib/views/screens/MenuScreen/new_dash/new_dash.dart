import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:flutter_app/utils.dart';
import 'package:google_fonts/google_fonts.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF0F5F4),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Container(
        padding: const EdgeInsets.fromLTRB(0, 43, 0, 10),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            SizedBox(
              width: 1048.9,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(46, 0, 46, 24),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: SizedBox(
                        width: 381,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.fromLTRB(0, 4, 20, 0),
                              child: SizedBox(
                                width: 18,
                                height: 34,
                                child: SvgPicture.asset(
                                  'assets/vectors/vector_29_x4.svg',
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.fromLTRB(0, 0, 10, 3),
                              child: Container(
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                      'assets/images/image_removebg_preview_1.png',
                                    ),
                                  ),
                                ),
                                child: Container(
                                  width: 272,
                                  height: 35,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(42.2, 0, 42.2, 11),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Trending Now',
                        style: GoogleFonts.getFont(
                          'Poppins',
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          height: 1.1,
                          letterSpacing: -0.4,
                          color: const Color(0xFF2E2C2C),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(35, 0, 35, 125),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(19, 19, 19, 19),
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xFF9747FF)),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFFFFFF),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 15, 0, 10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.fromLTRB(
                                            15, 0, 15, 10.3),
                                        child: SizedBox(
                                          width: 322,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                margin:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 7, 7, 3),
                                                child: SizedBox(
                                                  width: 260.5,
                                                  child: Text(
                                                    'Kabaddi | Match 8',
                                                    style: GoogleFonts.getFont(
                                                      'Roboto',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 14,
                                                      height: 1,
                                                      letterSpacing: 0.2,
                                                      color: const Color(
                                                          0xCC000000),
                                                    ),
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
                                                    margin: const EdgeInsets
                                                        .fromLTRB(0, 6, 5.5, 6),
                                                    child: Text(
                                                      'Live',
                                                      style:
                                                          GoogleFonts.getFont(
                                                        'Roboto',
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 14,
                                                        height: 0.9,
                                                        color: const Color(
                                                            0xFF000000),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    decoration:
                                                        const BoxDecoration(
                                                      image: DecorationImage(
                                                        fit: BoxFit.cover,
                                                        image: AssetImage(
                                                          'assets/images/image_7.gif',
                                                        ),
                                                      ),
                                                    ),
                                                    child: Container(
                                                      width: 24,
                                                      height: 24,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.fromLTRB(
                                            0, 0, 0, 9.3),
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            color: Color(0x1A000000),
                                          ),
                                          child: Container(
                                            width: 352,
                                            height: 1,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.fromLTRB(
                                            15, 0, 15, 10.2),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.fromLTRB(
                                                  0, 0, 62, 40),
                                              child: Stack(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        margin: const EdgeInsets
                                                            .fromLTRB(
                                                            0, 0, 10, 0),
                                                        child: Container(
                                                          decoration:
                                                              const BoxDecoration(
                                                            image:
                                                                DecorationImage(
                                                              fit: BoxFit.cover,
                                                              image: AssetImage(
                                                                'assets/images/image_4.png',
                                                              ),
                                                            ),
                                                          ),
                                                          child: Container(
                                                            width: 30,
                                                            height: 30,
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        margin: const EdgeInsets
                                                            .fromLTRB(
                                                            0, 3, 10.8, 3),
                                                        child: Text(
                                                          'Patna Pirates',
                                                          style: GoogleFonts
                                                              .getFont(
                                                            'Roboto',
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 16,
                                                            height: 1.5,
                                                            color: const Color(
                                                                0xCC000000),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        margin: const EdgeInsets
                                                            .fromLTRB(
                                                            0, 3, 0, 3),
                                                        child: Text(
                                                          '33',
                                                          style: GoogleFonts
                                                              .getFont(
                                                            'Roboto',
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 14,
                                                            height: 1.7,
                                                            color: const Color(
                                                                0xCC000000),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Positioned(
                                                    right: -13,
                                                    bottom: -40,
                                                    child: SizedBox(
                                                      width: 175,
                                                      height: 30,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Container(
                                                            margin:
                                                                const EdgeInsets
                                                                    .fromLTRB(0,
                                                                    0, 10.9, 0),
                                                            child: Container(
                                                              decoration:
                                                                  const BoxDecoration(
                                                                image:
                                                                    DecorationImage(
                                                                  fit: BoxFit
                                                                      .cover,
                                                                  image:
                                                                      AssetImage(
                                                                    'assets/images/image_6.png',
                                                                  ),
                                                                ),
                                                              ),
                                                              child: Container(
                                                                width: 30,
                                                                height: 30,
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            margin:
                                                                const EdgeInsets
                                                                    .fromLTRB(0,
                                                                    3, 10.7, 3),
                                                            child: Text(
                                                              'Gujarat Giants',
                                                              style: GoogleFonts
                                                                  .getFont(
                                                                'Roboto',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontSize: 16,
                                                                height: 1.5,
                                                                color: const Color(
                                                                    0xCC000000),
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            margin:
                                                                const EdgeInsets
                                                                    .fromLTRB(
                                                                    0, 3, 0, 3),
                                                            child: RichText(
                                                              text: TextSpan(
                                                                text: '30',
                                                                style:
                                                                    GoogleFonts
                                                                        .getFont(
                                                                  'Roboto',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize: 14,
                                                                  height: 1.7,
                                                                  color: const Color(
                                                                      0xCC000000),
                                                                ),
                                                                children: [
                                                                  TextSpan(
                                                                    text: '*',
                                                                    style: GoogleFonts
                                                                        .getFont(
                                                                      'Roboto',
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      fontSize:
                                                                          14,
                                                                      height:
                                                                          1.3,
                                                                      color: const Color(
                                                                          0xFFF6423A),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
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
                                              width: 98,
                                              decoration: const BoxDecoration(
                                                border: Border(
                                                  left: BorderSide(
                                                    color: Color(0x1A000000),
                                                    width: 1,
                                                  ),
                                                ),
                                              ),
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 13.5, 10.5, 13.5),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Container(
                                                      margin: const EdgeInsets
                                                          .fromLTRB(0, 0, 0, 5),
                                                      child: Text(
                                                        'Empty Raid',
                                                        style:
                                                            GoogleFonts.getFont(
                                                          'Roboto',
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 12,
                                                          height: 1.2,
                                                          letterSpacing: 0.2,
                                                          color: const Color(
                                                              0xFFA6A9B8),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      margin: const EdgeInsets
                                                          .fromLTRB(3, 0, 3, 0),
                                                      child: RichText(
                                                        text: TextSpan(
                                                          text: '33 : 30',
                                                          style: GoogleFonts
                                                              .getFont(
                                                            'Roboto',
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 16,
                                                            height: 1.5,
                                                            color: const Color(
                                                                0xCC000000),
                                                          ),
                                                          children: [
                                                            TextSpan(
                                                              text: '*',
                                                              style: GoogleFonts
                                                                  .getFont(
                                                                'Roboto',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize: 16,
                                                                height: 1.3,
                                                                color: const Color(
                                                                    0xFFFF443B),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
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
                                        margin: const EdgeInsets.fromLTRB(
                                            0, 0, 0, 9.3),
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            color: Color(0x1A000000),
                                          ),
                                          child: Container(
                                            width: 352,
                                            height: 1,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.fromLTRB(
                                            15, 0, 15, 0),
                                        child: Align(
                                          alignment: Alignment.topLeft,
                                          child: Container(
                                            child: Text(
                                              'Gujarat Giants Empty Raid',
                                              style: GoogleFonts.getFont(
                                                'Roboto',
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12,
                                                height: 1.2,
                                                letterSpacing: 0.2,
                                                color: const Color(0xCC000000),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: const Color(0xFFFFFFFF),
                                boxShadow: [
                                  const BoxShadow(
                                    color: Color(0x33636363),
                                    offset: Offset(0, 2),
                                    blurRadius: 4,
                                  ),
                                ],
                              ),
                              child: Container(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 15, 0, 10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.fromLTRB(
                                          15, 0, 15, 10.3),
                                      child: SizedBox(
                                        width: 322,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.fromLTRB(
                                                  0, 7, 7, 3),
                                              child: SizedBox(
                                                width: 260.5,
                                                child: Text(
                                                  'Kabaddi | Match 8',
                                                  style: GoogleFonts.getFont(
                                                    'Roboto',
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 14,
                                                    height: 1,
                                                    letterSpacing: 0.2,
                                                    color:
                                                        const Color(0xCC000000),
                                                  ),
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
                                                  margin:
                                                      const EdgeInsets.fromLTRB(
                                                          0, 6, 5.5, 6),
                                                  child: Text(
                                                    'Live',
                                                    style: GoogleFonts.getFont(
                                                      'Roboto',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 14,
                                                      height: 0.9,
                                                      color: const Color(
                                                          0xFF000000),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                    image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: AssetImage(
                                                        'assets/images/image_7.gif',
                                                      ),
                                                    ),
                                                  ),
                                                  child: Container(
                                                    width: 24,
                                                    height: 24,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.fromLTRB(
                                          0, 0, 0, 9.3),
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          color: Color(0x1A000000),
                                        ),
                                        child: Container(
                                          width: 352,
                                          height: 1,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.fromLTRB(
                                          15, 0, 15, 10.2),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.fromLTRB(
                                                0, 0, 62, 40),
                                            child: Stack(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      margin: const EdgeInsets
                                                          .fromLTRB(
                                                          0, 0, 10, 0),
                                                      child: Container(
                                                        decoration:
                                                            const BoxDecoration(
                                                          image:
                                                              DecorationImage(
                                                            fit: BoxFit.cover,
                                                            image: AssetImage(
                                                              'assets/images/image_4.png',
                                                            ),
                                                          ),
                                                        ),
                                                        child: Container(
                                                          width: 30,
                                                          height: 30,
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      margin: const EdgeInsets
                                                          .fromLTRB(
                                                          0, 3, 10.8, 3),
                                                      child: Text(
                                                        'Patna Pirates',
                                                        style:
                                                            GoogleFonts.getFont(
                                                          'Roboto',
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 16,
                                                          height: 1.5,
                                                          color: const Color(
                                                              0xCC000000),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      margin: const EdgeInsets
                                                          .fromLTRB(0, 3, 0, 3),
                                                      child: Text(
                                                        '33',
                                                        style:
                                                            GoogleFonts.getFont(
                                                          'Roboto',
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 14,
                                                          height: 1.7,
                                                          color: const Color(
                                                              0xCC000000),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Positioned(
                                                  right: -13,
                                                  bottom: -40,
                                                  child: SizedBox(
                                                    width: 175,
                                                    height: 30,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          margin:
                                                              const EdgeInsets
                                                                  .fromLTRB(0,
                                                                  0, 10.9, 0),
                                                          child: Container(
                                                            decoration:
                                                                const BoxDecoration(
                                                              image:
                                                                  DecorationImage(
                                                                fit: BoxFit
                                                                    .cover,
                                                                image:
                                                                    AssetImage(
                                                                  'assets/images/image_6.png',
                                                                ),
                                                              ),
                                                            ),
                                                            child: Container(
                                                              width: 30,
                                                              height: 30,
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          margin:
                                                              const EdgeInsets
                                                                  .fromLTRB(0,
                                                                  3, 10.7, 3),
                                                          child: Text(
                                                            'Gujarat Giants',
                                                            style: GoogleFonts
                                                                .getFont(
                                                              'Roboto',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: 16,
                                                              height: 1.5,
                                                              color: const Color(
                                                                  0xCC000000),
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          margin:
                                                              const EdgeInsets
                                                                  .fromLTRB(
                                                                  0, 3, 0, 3),
                                                          child: RichText(
                                                            text: TextSpan(
                                                              text: '30',
                                                              style: GoogleFonts
                                                                  .getFont(
                                                                'Roboto',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize: 14,
                                                                height: 1.7,
                                                                color: const Color(
                                                                    0xCC000000),
                                                              ),
                                                              children: [
                                                                TextSpan(
                                                                  text: '*',
                                                                  style: GoogleFonts
                                                                      .getFont(
                                                                    'Roboto',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontSize:
                                                                        14,
                                                                    height: 1.3,
                                                                    color: const Color(
                                                                        0xFFF6423A),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
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
                                            width: 98,
                                            decoration: const BoxDecoration(
                                              border: Border(
                                                left: BorderSide(
                                                  color: Color(0x1A000000),
                                                  width: 1,
                                                ),
                                              ),
                                            ),
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      0, 13.5, 10.5, 13.5),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Container(
                                                    margin: const EdgeInsets
                                                        .fromLTRB(0, 0, 0, 5),
                                                    child: Text(
                                                      'Empty Raid',
                                                      style:
                                                          GoogleFonts.getFont(
                                                        'Roboto',
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 12,
                                                        height: 1.2,
                                                        letterSpacing: 0.2,
                                                        color: const Color(
                                                            0xFFA6A9B8),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    margin: const EdgeInsets
                                                        .fromLTRB(3, 0, 3, 0),
                                                    child: RichText(
                                                      text: TextSpan(
                                                        text: '33 : 30',
                                                        style:
                                                            GoogleFonts.getFont(
                                                          'Roboto',
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 16,
                                                          height: 1.5,
                                                          color: const Color(
                                                              0xCC000000),
                                                        ),
                                                        children: [
                                                          TextSpan(
                                                            text: '*',
                                                            style: GoogleFonts
                                                                .getFont(
                                                              'Roboto',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 16,
                                                              height: 1.3,
                                                              color: const Color(
                                                                  0xFFFF443B),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
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
                          ],
                        ),
                      ),
                    ),
                  ),
                  //
                ],
              ),
            ),
            //
          ],
        ),
      ),
    );
  }
}
