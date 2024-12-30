import 'package:cricyard/core/utils/image_constant.dart';
import 'package:cricyard/core/utils/size_utils.dart';
import 'package:cricyard/theme/theme_helper.dart';
import 'package:cricyard/views/widgets/custom_image_view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../widgets/custom_icon_button.dart';

class PlayerCarrier extends StatelessWidget {
  onTapBtnArrowleftone(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.only(left: 20.h),
          child: Text(
            "Player Career",
            style: theme.textTheme.headlineLarge,
          ),
        ),
        leading: Padding(
          padding: EdgeInsets.only(
            top: 4.v,
            bottom: 11.v,
          ),
          child: CustomIconButton(
            height: 32.adaptSize,
            width: 32.adaptSize,
            padding_f: EdgeInsets.all(6.h),
            decoration: IconButtonStyleHelper.outlineIndigo,
            onTap: () {
              onTapBtnArrowleftone(context);
            },
            child: CustomImageView(
              svgPath: ImageConstant.imgArrowLeft,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFFF0F5F4),
            borderRadius: BorderRadius.circular(16),
          ),
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Profile Section
              Container(
                height: 400,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/frame_2.jpeg'),
                    fit: BoxFit
                        .cover, // Changed from BoxFit.cover to BoxFit.contain
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // CircleAvatar(
                    //   radius: 40,
                    //   backgroundImage: AssetImage('assets/images/profile.jpg'),
                    // ),
                    SizedBox(height: 16),
                    Text(
                      'Virat Kohli',
                      style: GoogleFonts.robotoCondensed(
                        fontWeight: FontWeight.w800,
                        fontSize: 23,
                        color: Color(0xFFFF9969),
                      ),
                    ),
                    Text(
                      'INDIA',
                      style: GoogleFonts.robotoCondensed(
                        fontWeight: FontWeight.w800,
                        fontSize: 11,
                        color: Color(0xFFFF9969),
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Right-hand batsman, Age: 34',
                      style: GoogleFonts.robotoCondensed(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 16),
              // Recent Form Section
              Text(
                'Recent Form',
                style: GoogleFonts.robotoCondensed(
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Match 1: 100 runs',
                      style: GoogleFonts.robotoCondensed(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Match 2: 50 runs',
                      style: GoogleFonts.robotoCondensed(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Match 3: 75 runs',
                      style: GoogleFonts.robotoCondensed(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              // Career Highlights Section
              Text(
                'Career Highlights',
                style: GoogleFonts.robotoCondensed(
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Highest Score: 183',
                      style: GoogleFonts.robotoCondensed(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Total Runs: 12,000',
                      style: GoogleFonts.robotoCondensed(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Centuries: 43',
                      style: GoogleFonts.robotoCondensed(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              // Personal Information Section
              Text(
                'Personal Information',
                style: GoogleFonts.robotoCondensed(
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Born: November 5, 1988',
                      style: GoogleFonts.robotoCondensed(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Role: Batsman',
                      style: GoogleFonts.robotoCondensed(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Batting Style: Right-hand bat',
                      style: GoogleFonts.robotoCondensed(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Bowling Style: Right-arm medium',
                      style: GoogleFonts.robotoCondensed(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      // bottomNavigationBar: BottomAppBarWidget(),
    );
  }
}