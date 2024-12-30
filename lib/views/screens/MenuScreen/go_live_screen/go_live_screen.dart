import 'package:cricyard/core/app_export.dart';
import 'package:cricyard/views/screens/ReuseableWidgets/BottomAppBarWidget.dart';
import 'package:flutter/material.dart';
import '../../Login Screen/view/CustomButton.dart';
import '../../ReuseableWidgets/CustomDrawer.dart';
import '../../ReuseableWidgets/headerWidget.dart';
import '../NewStreamFolder/TestStreaming/VideoStreamingOnly.dart';
import '../NewStreamFolder/LiveMatchStreamingActual/publishVideoAudioWidget.dart';
import '../NewStreamFolder/LiveMatchStreamingActual/streamVideoWidget.dart';
import '../NewStreamFolder/TestStreaming/streamVideoWidgetTest.dart';
import '../NewStreamFolder/TestStreaming/test.dart';

class GoLiveScreen extends StatelessWidget {
  GoLiveScreen({Key? key})
      : super(
          key: key,
        );
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      child: Scaffold(
        key: _scaffoldKey,
        drawer: CustomDrawer(context: context),
        backgroundColor: appTheme.gray100,
        body: SizedBox(
          width: double.maxFinite,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 17.h,
                  vertical: 45.v,
                ),
                child: Column(
                  children: [
                    headerWidget(context, _scaffoldKey),
                    SizedBox(height: 35.v),
                    CustomButton(
                      text: 'Go Live',
                      onTap: () {
                        // Closes the drawer
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                PublishVideoAudioWidget(matchId: 14),
                          ),
                        );
                        // Add your logic for menu 2 here
                      },
                    ),
                    CustomButton(
                      text: 'view Live',
                      onTap: () {
                        // Closes the drawer
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => StreamVideoWidgetTest(
                              matchId: 14,
                            ),
                            // builder: (context) => VideoStreamingOnly(),
                            // builder: (context) => pickvideo(),
                          ),
                        );
                        // Add your logic for menu 2 here
                      },
                    ),
                    CustomImageView(
                      imagePath: ImageConstant.imgRectangle32,
                      height: 230.v,
                      width: 371.h,
                      radius: BorderRadius.circular(
                        20.h,
                      ),
                    ),
                    SizedBox(height: 26.v),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 31.h),
                        child: Text(
                          "Trending series",
                          style: theme.textTheme.headlineLarge,
                        ),
                      ),
                    ),
                    SizedBox(height: 9.v),
                    _buildIndianPremimumRow(context),
                    SizedBox(height: 9.v)
                  ],
                ),
              ),
              SizedBox(height: 9.v)
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBarWidget(),
        // floatingActionButton: CustomFloatingButton(
        //   height: 64,
        //   width: 64,
        //   alignment: Alignment.topCenter,
        //   child: CustomImageView(
        //     svgPath: ImageConstant.imgLocation,
        //     height: 32.0.v,
        //     width: 32.0.h,
        //   ),
        // ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }

  /// Section Widget
  Widget _buildIndianPremimumRow(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 17.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            decoration: AppDecoration.fillBlueGray.copyWith(
              borderRadius: BorderRadiusStyle.roundedBorder15,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 2.h),
                  child: _buildIndianPremimumStack(
                    context,
                    dynamicImageProp1: ImageConstant.imgRectangle3,
                  ),
                ),
                Container(
                  width: 107.h,
                  margin: EdgeInsets.only(left: 9.h),
                  child: Text(
                    "Indian premimum league 2023 ..........",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
                SizedBox(height: 14.v),
                Container(
                  width: 106.h,
                  margin: EdgeInsets.only(left: 8.h),
                  child: Text(
                    "hsjhi kooiodew ijiiu nhuayhu8 jiua9u jhiau9 jo9u9a",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodySmall,
                  ),
                )
              ],
            ),
          ),
          Container(
            decoration: AppDecoration.fillBlueGray.copyWith(
              borderRadius: BorderRadiusStyle.roundedBorder15,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 2.h),
                  child: _buildIndianPremimumStack(
                    context,
                    dynamicImageProp1: ImageConstant.imgRectangle5,
                  ),
                ),
                SizedBox(height: 2.v),
                CustomImageView(
                  imagePath: ImageConstant.imgIndianPremimum,
                  height: 38.v,
                  width: 107.h,
                  margin: EdgeInsets.only(left: 8.h),
                ),
                SizedBox(height: 4.v),
                Container(
                  width: 106.h,
                  margin: EdgeInsets.only(left: 6.h),
                  child: Text(
                    "hsjhi kooiodew ijiiu nhuayhu8 jiua9u jhiau9 jo9u9a",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodySmall,
                  ),
                ),
                SizedBox(height: 3.v)
              ],
            ),
          )
        ],
      ),
    );
  }

  /// Common widget
  Widget _buildIndianPremimumStack(
    BuildContext context, {
    required String dynamicImageProp1,
  }) {
    return SizedBox(
      height: 72.v,
      width: 145.h,
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          CustomImageView(
            imagePath: dynamicImageProp1,
            height: 72.v,
            width: 145.h,
            radius: BorderRadius.circular(
              15.h,
            ),
            alignment: Alignment.center,
          ),
          CustomImageView(
            imagePath: ImageConstant.imgEllipse22,
            height: 38.v,
            width: 46.h,
            radius: BorderRadius.circular(
              19.h,
            ),
            alignment: Alignment.bottomLeft,
            margin: EdgeInsets.only(
              left: 43.h,
              bottom: 9.v,
            ),
          )
        ],
      ),
    );
  }
}
