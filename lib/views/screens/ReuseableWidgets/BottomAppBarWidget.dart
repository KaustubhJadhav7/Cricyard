import 'package:cricyard/core/app_export.dart';
import 'package:cricyard/views/screens/MenuScreen/new_dash/Newdashboard.dart';
import 'package:flutter/material.dart';
import 'package:cricyard/views/widgets/custom_icon_button.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as fs;
import 'package:google_fonts/google_fonts.dart';

import '../MenuScreen/merch/screens/home_screen.dart';

class BottomAppBarWidget extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: SizedBox(
        height: 115.v,
        width: double.infinity,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 35.v),
                padding: EdgeInsets.symmetric(
                  horizontal: 13.h,
                  vertical: 15.v,
                ),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: fs.Svg(
                      ImageConstant.imgGroup146,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomIconButton(
                      height: 50.adaptSize,
                      width: 50.adaptSize,
                      padding_f: EdgeInsets.all(13.h),
                      child: CustomImageView(
                        onTap: (){
                          print("Bat Ball Clicked");
                        },
                        svgPath: ImageConstant.imgBatball,
                        height: 32.0.v, // Adjusted height
                        width: 32.0.h, // Adjusted width
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 27.h),
                      child: CustomIconButton(
                        height: 50.adaptSize,
                        width: 50.adaptSize,
                        padding_f: EdgeInsets.all(12.h),
                        child: CustomImageView(
                          onTap: (){
                            print("Ball Clicked");
                          },
                          svgPath: ImageConstant.imgBxCricketBall,
                          height: 32.0.v, // Adjusted height
                          width: 32.0.h, // Adjusted width
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 123.h),
                      child: CustomIconButton(
                        height: 50.adaptSize,
                        width: 50.adaptSize,
                        padding_f: EdgeInsets.all(12.h),
                        child: CustomImageView(
                          onTap: (){
                            print("Live Clicked");
                          },
                          svgPath: ImageConstant.imgFluentLive24Filled,
                          height: 32.0.v, // Adjusted height
                          width: 32.0.h, // Adjusted width
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 26.h),
                      child: CustomIconButton(
                        height: 50.adaptSize,
                        width: 50.adaptSize,
                        padding_f: EdgeInsets.all(10.h),
                        child: CustomImageView(
                          onTap: (){
                            print("more Clicked");
                            _showModalBottomSheet(context);
                          },
                          svgPath: ImageConstant.imgOverflowmenu,
                          height: 32.0.v, // Adjusted height
                          width: 32.0.h, // Adjusted width
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding:  EdgeInsets.only(bottom: 40.0),
                child: CustomIconButton(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Newdashboard(),));
                  },
                  height: 70.adaptSize,
                  width: 70.adaptSize,
                  padding_f: EdgeInsets.all(10.h),
                  child: CustomImageView(
                    svgPath: ImageConstant.home,
                    height: 32.0.v, // Adjusted height
                    width: 32.0.h, // Adjusted width
                  ),
                ),
              ),
            ),
            // CustomFloatingButton(
            //   height: 64,
            //   width: 64,
            //   alignment: Alignment.topCenter,
            //   child: CustomImageView(
            //     svgPath: ImageConstant.imgLocation,
            //     height: 32.0.v,
            //     width: 32.0.h,
            //   ),
            // )
          ],
        ),
      ),
    );

  }
  void _showModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height*0.2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>const ProductHomeScreen() ,));
                  },
                  child: Column(
                    children: [
                      SizedBox(
                          height: 60,
                          child: Image.asset(ImageConstant.imgStore)),
                      Text("Go to store",style: GoogleFonts.getFont('Poppins',color: Colors.black),)
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                   // Navigator.push(context, MaterialPageRoute(builder: (context) =>const ProductHomeScreen() ,));
                  },
                  child: Column(
                    children: [
                      SizedBox(
                          height: 60,
                          child: Image.asset(ImageConstant.imgStore)),
                      Text("Create store",style: GoogleFonts.getFont('Poppins',color: Colors.black),)
                    ],
                  ),
                ),
              ),
            ],
          )
        );
      },
    );
  }


}
