import 'package:cricyard/core/app_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as fs;
import '../../../../widgets/app_bar/appbar_leading_iconbutton.dart';
import '../../../../widgets/app_bar/appbar_title.dart';
import '../../../../widgets/custom_floating_button.dart';
import '../../../../widgets/custom_icon_button.dart';
import '../../../../widgets/custom_image_view.dart';
import '../../../ReuseableWidgets/BottomAppBarWidget.dart';
import '../../../profileManagement/profile_settings_f.dart';
import 'custom_app_bar.dart';

// ignore: camel_case_types
class ActivityScreen extends StatelessWidget {
  ActivityScreen(this.userData, {Key? key})
      : super(
          key: key,
        );
  Map<String, dynamic> userData = {};

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(
            horizontal: 20.h,
            vertical: 22.v,
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: 5.v,
                  bottom: 9.v,
                ),
                child: CustomIconButton(
                  height: 32.adaptSize,
                  width: 32.adaptSize,
                  // padding: EdgeInsets.all(3.h),
                  decoration: IconButtonStyleHelper.outlineIndigo,
                  onTap: () {
                    onTapBtnArrowleftone(context);
                  },
                  child: CustomImageView(
                    svgPath: ImageConstant.imgArrowleft,
                    height: 32.adaptSize,
                    width: 32.adaptSize,
                  ),
                ),
              ),
              Stack(
                children: [
                  CustomImageView(
                    imagePath: ImageConstant.imgWhatsappImage20230313,
                    height: 100.adaptSize,
                    width: 100.adaptSize,
                    radius: BorderRadius.circular(
                      50.h,
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: CustomIconButton(
                      height: 32.adaptSize,
                      width: 32.adaptSize,
                      alignment: Alignment.centerRight,
                      onTap: () {
                        onTapBtnEdit(context);
                      },
                      padding_f: EdgeInsets.all(8.h),
                      // decoration: IconButtonStyleHelper.fillPrimary,
                      child: CustomImageView(
                        imagePath: ImageConstant.editIcon,
                        height: 28.adaptSize,
                        width: 28.adaptSize,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(right: 141.h),
                child: CustomIconButton(
                  height: 32.adaptSize,
                  width: 32.adaptSize,
                  padding_f: EdgeInsets.all(8.h),
                  alignment: Alignment.centerRight,
                  child: CustomImageView(
                    svgPath: ImageConstant.imgEdit,
                  ),
                ),
              ),
              SizedBox(height: 2.v),
              Text(
                ' Hello ${userData['firstName']}!',
                overflow: TextOverflow.clip,
                style: CustomTextStyles.headlineSmallSemiBold,
              ),
              SizedBox(height: 15.v),
              _buildCardOne(context),
              SizedBox(height: 89.v)
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
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }

  /// Navigates to the Edit screen.
  onTapBtnEdit(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProfileSettingsScreenF(userData: userData),
        // SettingScreen(),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 64.h,
      leading: AppbarLeadingIconbutton(
        imagePath: ImageConstant.imgArrowLeft,
        margin: EdgeInsets.only(
          left: 32.h,
          top: 9.v,
          bottom: 14.v,
        ),
        onTap: () {
          onTapArrowleftone(context);
        },
      ),
      title: AppbarTitle(
        text: "Activity",
        margin: EdgeInsets.only(left: 32.h),
      ),
      height: 1,
    );
  }

  /// Section Widget
  Widget _buildCardOne(BuildContext context) {
    return SizedBox(
      height: 369.v,
      width: 387.h,
      child: Stack(
        alignment: Alignment.topLeft,
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgCardPerformance,
            height: 369.v,
            width: 387.h,
            radius: BorderRadius.circular(
              25.h,
            ),
            alignment: Alignment.center,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(
                left: 22.h,
                top: 17.v,
                right: 195.h,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Weekly report".toUpperCase(),
                        style: CustomTextStyles.labelSmallBold,
                      ),
                      Text(
                        "21/06/2020 – 27/06/2020".toUpperCase(),
                        style:
                            CustomTextStyles.bodySmallOpenSansOnErrorContainer,
                      )
                    ],
                  ),
                  SizedBox(height: 29.v),
                  Text(
                    "YOUR performance".toUpperCase(),
                    style: theme.textTheme.bodyMedium,
                  ),
                  Text(
                    "10% growth".toUpperCase(),
                    style: CustomTextStyles.headlineSmallOnErrorContainer,
                  )
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Opacity(
              opacity: 0.3,
              child: Padding(
                padding: EdgeInsets.only(
                  top: 22.v,
                  right: 17.h,
                ),
                child: Text(
                  "Ludimos © all rights reserved".toUpperCase(),
                  style: CustomTextStyles.openSansOnErrorContainer,
                ),
              ),
            ),
          ),
          CustomImageView(
            imagePath: ImageConstant.imgImage60,
            height: 16.v,
            width: 58.h,
            alignment: Alignment.topRight,
            margin: EdgeInsets.only(
              top: 18.v,
              right: 34.h,
            ),
          ),
          CustomImageView(
            svgPath: ImageConstant.imgVectorOnerrorcontainer,
            height: 68.v,
            width: 156.h,
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(left: 26.h),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              height: 78.adaptSize,
              width: 78.adaptSize,
              margin: EdgeInsets.only(
                left: 18.h,
                top: 123.v,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  39.h,
                ),
                border: Border.all(
                  color: theme.colorScheme.onErrorContainer.withOpacity(1),
                  width: 4.h,
                ),
              ),
            ),
          ),
          CustomImageView(
            imagePath: ImageConstant.imgVector78x39,
            height: 78.v,
            width: 39.h,
            radius: BorderRadius.circular(
              19.h,
            ),
            alignment: Alignment.topLeft,
            margin: EdgeInsets.only(
              left: 57.h,
              top: 123.v,
            ),
          ),
          CustomImageView(
            imagePath: ImageConstant.imgMaskGroup,
            height: 110.v,
            width: 136.h,
            alignment: Alignment.topRight,
            margin: EdgeInsets.only(
              top: 29.v,
              right: 26.h,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(
                left: 25.h,
                right: 34.h,
                bottom: 11.v,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "50".toUpperCase(),
                        style: theme.textTheme.labelMedium,
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: 5.v,
                            bottom: 7.v,
                          ),
                          child: Divider(
                            indent: 6.h,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 21.v),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 39.v),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "10".toUpperCase(),
                              style: theme.textTheme.labelMedium,
                            ),
                            SizedBox(height: 20.v),
                            Text(
                              "2".toUpperCase(),
                              style: theme.textTheme.labelMedium,
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: 6.h,
                            top: 6.v,
                          ),
                          child: Column(
                            children: [
                              Divider(),
                              SizedBox(height: 1.v),
                              SizedBox(
                                height: 79.v,
                                width: 309.h,
                                child: Stack(
                                  alignment: Alignment.topLeft,
                                  children: [
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Divider(),
                                          SizedBox(height: 33.v),
                                          Container(
                                            width: 174.h,
                                            margin: EdgeInsets.only(
                                              left: 33.h,
                                              right: 101.h,
                                            ),
                                            child: Row(
                                              children: [
                                                Text(
                                                  "21 July",
                                                  style: theme
                                                      .textTheme.labelSmall,
                                                ),
                                                Spacer(
                                                  flex: 50,
                                                ),
                                                Text(
                                                  "23 July",
                                                  style: theme
                                                      .textTheme.labelSmall,
                                                ),
                                                Spacer(
                                                  flex: 49,
                                                ),
                                                Text(
                                                  "27July",
                                                  style: theme
                                                      .textTheme.labelSmall,
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Container(
                                        height: 70.v,
                                        width: 176.h,
                                        padding: EdgeInsets.symmetric(
                                            vertical: 10.v),
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: fs.Svg(
                                              ImageConstant.imgGroup58,
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        child: CustomImageView(
                                          svgPath: ImageConstant.imgPath2,
                                          height: 45.v,
                                          width: 134.h,
                                          alignment: Alignment.bottomLeft,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              height: 78.adaptSize,
              width: 78.adaptSize,
              margin: EdgeInsets.only(
                left: 114.h,
                top: 123.v,
              ),
              child: Stack(
                alignment: Alignment.centerRight,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      height: 78.adaptSize,
                      width: 78.adaptSize,
                      child: CircularProgressIndicator(
                        value: 0.5,
                        strokeWidth: 4.h,
                      ),
                    ),
                  ),
                  CustomImageView(
                    imagePath: ImageConstant.imgVector78x66,
                    height: 78.v,
                    width: 66.h,
                    radius: BorderRadius.circular(
                      22.h,
                    ),
                    alignment: Alignment.centerRight,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildBottomAppBarSea(BuildContext context) {
    return SizedBox(
      child: SizedBox(
        height: 115.v,
        width: 409.h,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: 409.h,
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
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomIconButton(
                      height: 50.adaptSize,
                      width: 50.adaptSize,
                      padding_f: EdgeInsets.all(13.h),
                      child: CustomImageView(
                        svgPath: ImageConstant.imgSearch,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 27.h),
                      child: CustomIconButton(
                        height: 50.adaptSize,
                        width: 50.adaptSize,
                        padding_f: EdgeInsets.all(12.h),
                        child: CustomImageView(
                          svgPath: ImageConstant.imgBxCricketBall,
                        ),
                      ),
                    ),
                    Container(
                      width: 126.h,
                      margin: EdgeInsets.only(left: 123.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CustomIconButton(
                            height: 50.adaptSize,
                            width: 50.adaptSize,
                            padding_f: EdgeInsets.all(12.h),
                            child: CustomImageView(
                              svgPath: ImageConstant.imgFluentLive24Filled,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 26.h),
                            child: CustomIconButton(
                              height: 50.adaptSize,
                              width: 50.adaptSize,
                              padding_f: EdgeInsets.all(10.h),
                              child: CustomImageView(
                                svgPath: ImageConstant.imgNotification,
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            CustomFloatingButton(
              height: 64,
              width: 64,
              alignment: Alignment.topCenter,
              child: CustomImageView(
                svgPath: ImageConstant.imgLocation,
                height: 32.0.v,
                width: 32.0.h,
              ),
            )
          ],
        ),
      ),
    );
  }

  /// Navigates back to the previous screen.
  onTapArrowleftone(BuildContext context) {
    Navigator.pop(context);
  }

  onTapBtnArrowleftone(BuildContext context) {
    Navigator.pop(context);
  }
}
