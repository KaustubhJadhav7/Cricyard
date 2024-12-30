import 'package:cricyard/core/app_export.dart';
import 'package:flutter/material.dart';

import '../../../../widgets/custom_icon_button.dart';

class FollowingScreen extends StatelessWidget {
  const FollowingScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: double.maxFinite,
          child: Column(
            children: [
              SizedBox(height: 65.v),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 9.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 16.h),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  top: 5.v,
                                  bottom: 10.v,
                                ),
                                child: CustomIconButton(
                                  height: 32.adaptSize,
                                  width: 32.adaptSize,
                                  padding_f: EdgeInsets.all(8.h),
                                  decoration:
                                      IconButtonStyleHelper.outlineIndigo,
                                  onTap: () {
                                    onTapBtnArrowleftone(context);
                                  },
                                  child: CustomImageView(
                                    imagePath:
                                        ImageConstant.imgArrowLeftGray900,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 23.h),
                                child: Text(
                                  "Following",
                                  textAlign: TextAlign.center,
                                  style: theme.textTheme.headlineLarge,
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 31.v),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 6.h,
                            right: 63.h,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 180.h,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 30.h,
                                  vertical: 11.v,
                                ),
                                decoration: AppDecoration.fillPrimary.copyWith(
                                  borderRadius:
                                      BorderRadiusStyle.circleBorder20,
                                ),
                                child: Text(
                                  "INDIA".toUpperCase(),
                                  style: CustomTextStyles
                                      .labelLargeWhiteA700ExtraBold,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  top: 12.v,
                                  bottom: 11.v,
                                ),
                                child: Text(
                                  "SRI LANKA".toUpperCase(),
                                  style: CustomTextStyles
                                      .labelLargePrimaryExtraBold,
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 17.v),
                        SizedBox(
                          height: 1063.v,
                          width: 410.h,
                          child: Stack(
                            alignment: Alignment.bottomLeft,
                            children: [
                              CustomImageView(
                                imagePath: ImageConstant.imgGroup183,
                                height: 80.v,
                                width: 409.h,
                                alignment: Alignment.bottomCenter,
                                margin: EdgeInsets.only(bottom: 348.v),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: 21.h,
                                  bottom: 363.v,
                                ),
                                child: CustomIconButton(
                                  height: 50.adaptSize,
                                  width: 50.adaptSize,
                                  padding_f: EdgeInsets.all(13.h),
                                  alignment: Alignment.bottomLeft,
                                  child: CustomImageView(
                                    imagePath: ImageConstant.imgSearch,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: 98.h,
                                  bottom: 363.v,
                                ),
                                child: CustomIconButton(
                                  height: 50.adaptSize,
                                  width: 50.adaptSize,
                                  padding_f: EdgeInsets.all(12.h),
                                  alignment: Alignment.bottomLeft,
                                  child: CustomImageView(
                                    imagePath: ImageConstant.imgBxCricketBall,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  right: 89.h,
                                  bottom: 363.v,
                                ),
                                child: CustomIconButton(
                                  height: 50.adaptSize,
                                  width: 50.adaptSize,
                                  padding_f: EdgeInsets.all(12.h),
                                  alignment: Alignment.bottomRight,
                                  child: CustomImageView(
                                    imagePath:
                                        ImageConstant.imgFluentLive24Filled,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  right: 13.h,
                                  bottom: 363.v,
                                ),
                                child: CustomIconButton(
                                  height: 50.adaptSize,
                                  width: 50.adaptSize,
                                  padding_f: EdgeInsets.all(10.h),
                                  alignment: Alignment.bottomRight,
                                  child: CustomImageView(
                                    imagePath: ImageConstant.imgNotification,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(bottom: 399.v),
                                child: CustomIconButton(
                                  height: 64.adaptSize,
                                  width: 64.adaptSize,
                                  padding_f: EdgeInsets.all(19.h),
                                  decoration: IconButtonStyleHelper
                                      .gradientLightGreenAToLightGreenA,
                                  alignment: Alignment.bottomCenter,
                                  child: CustomImageView(
                                    imagePath: ImageConstant.imgLocation,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 8.h),
                                  decoration: AppDecoration.fillPrimary1,
                                  child: Container(
                                    padding: EdgeInsets.only(
                                      top: 16.v,
                                      bottom: 15.v,
                                    ),
                                    decoration: AppDecoration.outlineGray3001,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding:
                                                EdgeInsets.only(left: 16.h),
                                            child: Text(
                                              "Playing XI",
                                              style: CustomTextStyles
                                                  .labelLargePrimary,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 15.v),
                                        _buildRowOne(
                                          context,
                                          imageFiveSeven:
                                              ImageConstant.imgImage5,
                                          imageFiveNine:
                                              ImageConstant.imgImage576x89,
                                          imageFive: ImageConstant.imgImage51,
                                        ),
                                        SizedBox(height: 9.v),
                                        Padding(
                                          padding: EdgeInsets.only(
                                            left: 37.h,
                                            right: 54.h,
                                          ),
                                          child: _buildRowrsharmacOne(
                                            context,
                                            playerName1: "R Sharma(c)",
                                            playerRole1: "Batter",
                                            playerName2: "S Gill",
                                            playerRole2: "Batter",
                                            playerName3: "V Kohli",
                                            playerRole3: "Batter",
                                          ),
                                        ),
                                        SizedBox(height: 16.v),
                                        _buildRowOne(
                                          context,
                                          imageFiveSeven:
                                              ImageConstant.imgImage52,
                                          imageFiveNine:
                                              ImageConstant.imgImage53,
                                          imageFive: ImageConstant.imgImage54,
                                        ),
                                        SizedBox(height: 9.v),
                                        Padding(
                                          padding: EdgeInsets.only(
                                            left: 34.h,
                                            right: 39.h,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(top: 1.v),
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      "KL Rahul(wk)",
                                                      style: CustomTextStyles
                                                          .labelLargeSFProTextPrimary,
                                                    ),
                                                    SizedBox(height: 1.v),
                                                    Opacity(
                                                      opacity: 0.5,
                                                      child: Text(
                                                        "Batter",
                                                        style: CustomTextStyles
                                                            .labelLargeSFProTextPrimaryMedium,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              _buildColumnkyadav(
                                                context,
                                                userName: "I Kishan",
                                                userRole: "Batter",
                                              ),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(top: 1.v),
                                                child: _buildColumnrjadeja(
                                                  context,
                                                  userName: "H Pandya",
                                                  userRole: "All Rounder",
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 16.v),
                                        _buildRowOne(
                                          context,
                                          imageFiveSeven:
                                              ImageConstant.imgImage55,
                                          imageFiveNine:
                                              ImageConstant.imgImage56,
                                          imageFive: ImageConstant.imgImage57,
                                        ),
                                        SizedBox(height: 9.v),
                                        Padding(
                                          padding: EdgeInsets.only(
                                            left: 39.h,
                                            right: 51.h,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                child: _buildColumnrjadeja(
                                                  context,
                                                  userName: "R Jadeja",
                                                  userRole: "All Rounder",
                                                ),
                                              ),
                                              Spacer(
                                                flex: 44,
                                              ),
                                              Expanded(
                                                child: _buildColumnrjadeja(
                                                  context,
                                                  userName: "A Patel",
                                                  userRole: "All Rounder",
                                                ),
                                              ),
                                              Spacer(
                                                flex: 55,
                                              ),
                                              Expanded(
                                                child: _buildColumnkyadav(
                                                  context,
                                                  userName: "K Yadav",
                                                  userRole: "Bowler",
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 16.v),
                                        _buildRowthree(context),
                                        SizedBox(height: 9.v),
                                        Padding(
                                          padding: EdgeInsets.only(
                                            left: 84.h,
                                            right: 76.h,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                children: [
                                                  Text(
                                                    "M Siraj",
                                                    style: CustomTextStyles
                                                        .labelLargeSFProTextPrimary,
                                                  ),
                                                  SizedBox(height: 1.v),
                                                  Opacity(
                                                    opacity: 0.5,
                                                    child: Text(
                                                      "Bowler",
                                                      style: CustomTextStyles
                                                          .labelLargeSFProTextPrimaryMedium,
                                                    ),
                                                  )
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  Text(
                                                    "J Bumrah",
                                                    style: CustomTextStyles
                                                        .labelLargeSFProTextPrimary,
                                                  ),
                                                  SizedBox(height: 1.v),
                                                  Opacity(
                                                    opacity: 0.5,
                                                    child: Text(
                                                      "Bowler",
                                                      style: CustomTextStyles
                                                          .labelLargeSFProTextPrimaryMedium,
                                                    ),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              _buildColumnonbench(context),
                              CustomImageView(
                                imagePath: ImageConstant.imgGroup183,
                                height: 80.v,
                                width: 409.h,
                                alignment: Alignment.bottomCenter,
                                margin: EdgeInsets.only(bottom: 348.v),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: 20.h,
                                  bottom: 363.v,
                                ),
                                child: CustomIconButton(
                                  height: 50.adaptSize,
                                  width: 50.adaptSize,
                                  padding_f: EdgeInsets.all(13.h),
                                  alignment: Alignment.bottomLeft,
                                  child: CustomImageView(
                                    imagePath: ImageConstant.imgSearch,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: 97.h,
                                  bottom: 363.v,
                                ),
                                child: CustomIconButton(
                                  height: 50.adaptSize,
                                  width: 50.adaptSize,
                                  padding_f: EdgeInsets.all(12.h),
                                  alignment: Alignment.bottomLeft,
                                  child: CustomImageView(
                                    imagePath: ImageConstant.imgBxCricketBall,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  right: 90.h,
                                  bottom: 363.v,
                                ),
                                child: CustomIconButton(
                                  height: 50.adaptSize,
                                  width: 50.adaptSize,
                                  padding_f: EdgeInsets.all(12.h),
                                  alignment: Alignment.bottomRight,
                                  child: CustomImageView(
                                    imagePath:
                                        ImageConstant.imgFluentLive24Filled,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  right: 14.h,
                                  bottom: 363.v,
                                ),
                                child: CustomIconButton(
                                  height: 50.adaptSize,
                                  width: 50.adaptSize,
                                  padding_f: EdgeInsets.all(10.h),
                                  alignment: Alignment.bottomRight,
                                  child: CustomImageView(
                                    imagePath: ImageConstant.imgNotification,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(bottom: 399.v),
                                child: CustomIconButton(
                                  height: 64.adaptSize,
                                  width: 64.adaptSize,
                                  padding_f: EdgeInsets.all(19.h),
                                  decoration: IconButtonStyleHelper
                                      .gradientLightGreenAToLightGreenA,
                                  alignment: Alignment.bottomCenter,
                                  child: CustomImageView(
                                    imagePath: ImageConstant.imgLocation,
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
              )
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildRowthree(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.h),
      decoration: AppDecoration.outlineGray3002,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 76.v,
            width: 180.h,
            padding: EdgeInsets.symmetric(horizontal: 45.h),
            decoration: AppDecoration.fillWhiteA700,
            child: CustomImageView(
              imagePath: ImageConstant.imgImage58,
              height: 76.v,
              width: 89.h,
              alignment: Alignment.center,
            ),
          ),
          Container(
            height: 76.v,
            width: 180.h,
            padding: EdgeInsets.symmetric(horizontal: 45.h),
            decoration: AppDecoration.fillWhiteA700,
            child: CustomImageView(
              imagePath: ImageConstant.imgImage59,
              height: 76.v,
              width: 89.h,
              alignment: Alignment.center,
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildColumnonbench(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.h),
        padding: EdgeInsets.symmetric(vertical: 16.v),
        decoration: AppDecoration.fillWhiteA,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 16.h),
                child: Text(
                  "On Bench",
                  style: CustomTextStyles.labelLargePrimary,
                ),
              ),
            ),
            SizedBox(height: 16.v),
            _buildRowOne(
              context,
              imageFiveSeven: ImageConstant.imgImage510,
              imageFiveNine: ImageConstant.imgImage511,
              imageFive: ImageConstant.imgImage59,
            ),
            SizedBox(height: 7.v),
            Padding(
              padding: EdgeInsets.only(
                left: 37.h,
                right: 54.h,
              ),
              child: _buildRowrsharmacOne(
                context,
                playerName1: "R Sharma(c)",
                playerRole1: "Batter",
                playerName2: "S Gill",
                playerRole2: "Batter",
                playerName3: "V Kohli",
                playerRole3: "Batter",
              ),
            ),
            SizedBox(height: 16.v),
            _buildRowOne(
              context,
              imageFiveSeven: ImageConstant.imgImage510,
              imageFiveNine: ImageConstant.imgImage511,
              imageFive: ImageConstant.imgImage59,
            ),
            SizedBox(height: 8.v),
            Padding(
              padding: EdgeInsets.only(
                left: 34.h,
                right: 39.h,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text(
                        "KL Rahul(wk)",
                        style: CustomTextStyles.labelLargeSFProTextPrimary,
                      ),
                      Opacity(
                        opacity: 0.5,
                        child: Text(
                          "Batter",
                          style:
                              CustomTextStyles.labelLargeSFProTextPrimaryMedium,
                        ),
                      )
                    ],
                  ),
                  Spacer(
                    flex: 47,
                  ),
                  Expanded(
                    child: _buildColumnkyadav(
                      context,
                      userName: "I Kishan",
                      userRole: "Batter",
                    ),
                  ),
                  Spacer(
                    flex: 52,
                  ),
                  Expanded(
                    child: _buildColumnrjadeja(
                      context,
                      userName: "H Pandya",
                      userRole: "All Rounder",
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 16.v),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.h),
              decoration: AppDecoration.outlineGray3002,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 136.h),
                decoration: AppDecoration.fillWhiteA700,
                child: CustomImageView(
                  imagePath: ImageConstant.imgImage59,
                  height: 76.v,
                  width: 89.h,
                ),
              ),
            ),
            SizedBox(height: 8.v),
            Text(
              "A Patel",
              style: CustomTextStyles.labelLargeSFProTextPrimary,
            ),
            Opacity(
              opacity: 0.5,
              child: Text(
                "All Rounder",
                style: CustomTextStyles.labelLargeSFProTextPrimaryMedium,
              ),
            )
          ],
        ),
      ),
    );
  }

  /// Common widget
  Widget _buildRowOne(
    BuildContext context, {
    required String imageFiveSeven,
    required String imageFiveNine,
    required String imageFive,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.h),
      decoration: AppDecoration.outlineGray3002,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 76.v,
            width: 120.h,
            padding: EdgeInsets.symmetric(horizontal: 15.h),
            decoration: AppDecoration.fillWhiteA700,
            child: CustomImageView(
              imagePath: imageFiveSeven,
              height: 76.v,
              width: 89.h,
              alignment: Alignment.center,
            ),
          ),
          Container(
            height: 76.v,
            width: 120.h,
            padding: EdgeInsets.symmetric(horizontal: 15.h),
            decoration: AppDecoration.fillWhiteA700,
            child: CustomImageView(
              imagePath: imageFiveNine,
              height: 76.v,
              width: 89.h,
              alignment: Alignment.center,
            ),
          ),
          Container(
            height: 76.v,
            width: 120.h,
            padding: EdgeInsets.symmetric(horizontal: 15.h),
            decoration: AppDecoration.fillWhiteA700,
            child: CustomImageView(
              imagePath: imageFive,
              height: 76.v,
              width: 89.h,
              alignment: Alignment.center,
            ),
          )
        ],
      ),
    );
  }

  /// Common widget
  Widget _buildColumnrjadeja(
    BuildContext context, {
    required String userName,
    required String userRole,
  }) {
    return Column(
      children: [
        Text(
          userName,
          style: CustomTextStyles.labelLargeSFProTextPrimary.copyWith(
            color: theme.colorScheme.primary,
          ),
        ),
        SizedBox(height: 1.v),
        Opacity(
          opacity: 0.5,
          child: Text(
            userRole,
            style: CustomTextStyles.labelLargeSFProTextPrimaryMedium.copyWith(
              color: theme.colorScheme.primary.withOpacity(0.53),
            ),
          ),
        )
      ],
    );
  }

  /// Common widget
  Widget _buildColumnkyadav(
    BuildContext context, {
    required String userName,
    required String userRole,
  }) {
    return Column(
      children: [
        Text(
          userName,
          style: CustomTextStyles.labelLargeSFProTextPrimary.copyWith(
            color: theme.colorScheme.primary,
          ),
        ),
        SizedBox(height: 2.v),
        Opacity(
          opacity: 0.5,
          child: Text(
            userRole,
            style: CustomTextStyles.labelLargeSFProTextPrimaryMedium.copyWith(
              color: theme.colorScheme.primary.withOpacity(0.53),
            ),
          ),
        )
      ],
    );
  }

  /// Common widget
  Widget _buildRowrsharmacOne(
    BuildContext context, {
    required String playerName1,
    required String playerRole1,
    required String playerName2,
    required String playerRole2,
    required String playerName3,
    required String playerRole3,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            Text(
              playerName1,
              style: CustomTextStyles.labelLargeSFProTextPrimary.copyWith(
                color: theme.colorScheme.primary,
              ),
            ),
            Opacity(
              opacity: 0.5,
              child: Text(
                playerRole1,
                style:
                    CustomTextStyles.labelLargeSFProTextPrimaryMedium.copyWith(
                  color: theme.colorScheme.primary.withOpacity(0.53),
                ),
              ),
            )
          ],
        ),
        Spacer(
          flex: 43,
        ),
        Column(
          children: [
            Text(
              playerName2,
              style: CustomTextStyles.labelLargeSFProTextPrimary.copyWith(
                color: theme.colorScheme.primary,
              ),
            ),
            Opacity(
              opacity: 0.5,
              child: Text(
                playerRole2,
                style:
                    CustomTextStyles.labelLargeSFProTextPrimaryMedium.copyWith(
                  color: theme.colorScheme.primary.withOpacity(0.53),
                ),
              ),
            )
          ],
        ),
        Spacer(
          flex: 56,
        ),
        Column(
          children: [
            Text(
              playerName3,
              style: CustomTextStyles.labelLargeSFProTextPrimary.copyWith(
                color: theme.colorScheme.primary,
              ),
            ),
            Opacity(
              opacity: 0.5,
              child: Text(
                playerRole3,
                style:
                    CustomTextStyles.labelLargeSFProTextPrimaryMedium.copyWith(
                  color: theme.colorScheme.primary.withOpacity(0.53),
                ),
              ),
            )
          ],
        )
      ],
    );
  }

  /// Navigates back to the previous screen.
  onTapBtnArrowleftone(BuildContext context) {
    Navigator.pop(context);
  }
}
