import 'package:cricyard/core/app_export.dart';
import 'package:flutter/material.dart';

import '../../../../../theme/custom_button_style.dart';
import '../../../../widgets/custom_elevated_button.dart';
import 'widgets/follow_plyer_item_widget.dart';

class FollowPlyerScreen extends StatelessWidget {
  const FollowPlyerScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildStackArrowLeft(context),
                SizedBox(height: 10.v),
                SizedBox(
                  height: 1136.v,
                  width: double.maxFinite,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          height: 1136.v,
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primary.withOpacity(0.05),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _buildColumnIccMens(context),
                            SizedBox(height: 8.v),
                            _buildStackCreateFrom(context),
                            SizedBox(height: 8.v),
                            _buildColumnPlayerCar(context),
                            SizedBox(height: 8.v),
                            _buildColumnDebutMatch(context)
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildStackArrowLeft(BuildContext context) {
    return Container(
      height: 608.v,
      width: double.maxFinite,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            ImageConstant.imgFrame2,
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        alignment: Alignment.topLeft,
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: 501.v,
              width: double.maxFinite,
              child: Stack(
                alignment: Alignment.centerRight,
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: EdgeInsets.only(top: 10.v),
                      child: Text(
                        "INDIA",
                        style: CustomTextStyles.titleMediumDeeporange300,
                      ),
                    ),
                  ),
                  CustomImageView(
                    imagePath: ImageConstant.imgImage6,
                    height: 497.v,
                    width: 152.h,
                    alignment: Alignment.centerRight,
                    margin: EdgeInsets.only(right: 91.h),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: double.maxFinite,
                      margin: EdgeInsets.only(top: 429.v),
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.h,
                        vertical: 11.v,
                      ),
                      decoration: AppDecoration.fillWhiteA700,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              CustomImageView(
                                imagePath: ImageConstant.imgClose,
                                height: 28.adaptSize,
                                width: 28.adaptSize,
                                radius: BorderRadius.circular(
                                  14.h,
                                ),
                              ),
                              SizedBox(height: 4.v),
                              Text(
                                "IND",
                                style: CustomTextStyles
                                    .labelLargeSFProTextPrimary_1,
                              )
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: 18.h,
                              top: 6.v,
                              bottom: 6.v,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Right hand batsman",
                                  style: CustomTextStyles.labelLargePrimary,
                                ),
                                SizedBox(height: 3.v),
                                Text(
                                  "34 Yrs",
                                  style: CustomTextStyles
                                      .labelLargeSFProTextPrimary_1,
                                )
                              ],
                            ),
                          ),
                          Spacer(),
                          CustomElevatedButton(
                            height: 40.v,
                            width: 74.h,
                            text: "Follow",
                            margin: EdgeInsets.symmetric(vertical: 4.v),
                            buttonStyle: CustomButtonStyles.fillWhiteA,
                            buttonTextStyle: CustomTextStyles.labelLargePrimary,
                          ),
                          CustomImageView(
                            imagePath: ImageConstant.imgBellFill1,
                            height: 20.v,
                            width: 18.h,
                            margin: EdgeInsets.only(
                              left: 16.h,
                              top: 14.v,
                              bottom: 14.v,
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(
                left: 33.h,
                top: 74.v,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomImageView(
                    imagePath: ImageConstant.imgArrowLeftWhiteA700,
                    height: 29.v,
                    width: 14.h,
                    margin: EdgeInsets.only(
                      top: 4.v,
                      bottom: 9.v,
                    ),
                    onTap: () {
                      onTapImgArrowleftone(context);
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 61.h),
                    child: Text(
                      "Virat Kohli",
                      style: theme.textTheme.displaySmall,
                    ),
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
  Widget _buildColumnIccMens(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.h),
      decoration: AppDecoration.outlineGray3001,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: AppDecoration.outlineGray3003.copyWith(
              borderRadius: BorderRadiusStyle.roundedBorder24,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: 13.v,
                    bottom: 10.v,
                  ),
                  child: Column(
                    children: [
                      Opacity(
                        opacity: 0.5,
                        child: Text(
                          "Test",
                          style:
                              CustomTextStyles.labelLargeSFProTextPrimaryMedium,
                        ),
                      ),
                      SizedBox(height: 3.v),
                      Text(
                        "14".toUpperCase(),
                        style: theme.textTheme.titleMedium,
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 53.h,
                    vertical: 10.v,
                  ),
                  decoration: AppDecoration.outlineGray3004,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 2.v),
                      Opacity(
                        opacity: 0.5,
                        child: Text(
                          "ODI",
                          style:
                              CustomTextStyles.labelLargeSFProTextPrimaryMedium,
                        ),
                      ),
                      SizedBox(height: 3.v),
                      Text(
                        "8".toUpperCase(),
                        style: theme.textTheme.titleMedium,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 13.v,
                    bottom: 10.v,
                  ),
                  child: Column(
                    children: [
                      Opacity(
                        opacity: 0.5,
                        child: Text(
                          "T20",
                          style:
                              CustomTextStyles.labelLargeSFProTextPrimaryMedium,
                        ),
                      ),
                      SizedBox(height: 3.v),
                      Text(
                        "22".toUpperCase(),
                        style: theme.textTheme.titleMedium,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 10.v),
          Text(
            "ICC Men’s Batter Ranking",
            style: CustomTextStyles.labelLargePrimary,
          ),
          SizedBox(height: 15.v)
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildStackCreateFrom(BuildContext context) {
    return SizedBox(
      height: 138.v,
      width: double.maxFinite,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              height: 138.v,
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: appTheme.whiteA700,
                border: Border(
                  bottom: BorderSide(
                    color: appTheme.gray300,
                    width: 1.h,
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.only(left: 16.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Recent Form",
                    style: CustomTextStyles.labelLargePrimary,
                  ),
                  SizedBox(height: 16.v),
                  SizedBox(
                    height: 72.v,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          width: 12.h,
                        );
                      },
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return FollowPlyerItemWidget();
                      },
                    ),
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
  Widget _buildColumnPlayerCar(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16.h, 18.v, 16.h, 17.v),
      decoration: AppDecoration.outlineGray3001,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Player Career ",
            style: CustomTextStyles.labelLargePrimary,
          ),
          SizedBox(height: 15.v),
          Row(
            children: [
              CustomElevatedButton(
                height: 32.v,
                width: 80.h,
                text: "Batting".toUpperCase(),
                buttonStyle: CustomButtonStyles.fillPrimaryTL16,
                buttonTextStyle:
                    CustomTextStyles.labelMediumWhiteA700ExtraBold_1,
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 8.h,
                  top: 9.v,
                  bottom: 8.v,
                ),
                child: Text(
                  "Bowling".toUpperCase(),
                  style: CustomTextStyles.labelMediumPrimary,
                ),
              )
            ],
          ),
          SizedBox(height: 16.v),
          _buildRowInnings(
            context,
            inningsText: "Matches",
            scoreText: "279",
          ),
          _buildRowInnings(
            context,
            inningsText: "Innings",
            scoreText: "268",
          ),
          _buildRowInnings(
            context,
            inningsText: "Runs",
            scoreText: "13,027",
          ),
          _buildRowInnings(
            context,
            inningsText: "Best",
            scoreText: "183",
          ),
          _buildRowInnings(
            context,
            inningsText: "100s",
            scoreText: "47",
          ),
          _buildRowInnings(
            context,
            inningsText: "50s",
            scoreText: "65",
          ),
          _buildRowInnings(
            context,
            inningsText: "Strike Rate",
            scoreText: "93.79",
          ),
          _buildRowInnings(
            context,
            inningsText: "Avg",
            scoreText: "57.39",
          ),
          _buildRowInnings(
            context,
            inningsText: "Fours",
            scoreText: "1,221",
          ),
          _buildRowInnings(
            context,
            inningsText: "Six",
            scoreText: "141",
          ),
          SizedBox(height: 12.v),
          Row(
            children: [
              Text(
                "Duck Out",
                style: theme.textTheme.labelLarge,
              ),
              Padding(
                padding: EdgeInsets.only(left: 83.h),
                child: Text(
                  "-",
                  style: theme.textTheme.labelLarge,
                ),
              )
            ],
          ),
          SizedBox(height: 9.v)
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildColumnDebutMatch(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16.h,
        vertical: 17.v,
      ),
      decoration: AppDecoration.fillWhiteA,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Debut Match",
            style: CustomTextStyles.labelLargePrimary,
          ),
          SizedBox(height: 16.v),
          Container(
            padding: EdgeInsets.only(
              top: 10.v,
              bottom: 9.v,
            ),
            decoration: AppDecoration.outlineGray3006,
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.v),
                  child: Text(
                    "ODI",
                    style: theme.textTheme.labelLarge,
                  ),
                ),
                Spacer(),
                Card(
                  clipBehavior: Clip.antiAlias,
                  elevation: 0,
                  margin: EdgeInsets.only(
                    top: 2.v,
                    bottom: 19.v,
                  ),
                  color: appTheme.yellow600,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusStyle.roundedBorder3,
                  ),
                  child: Container(
                    height: 15.v,
                    width: 21.h,
                    decoration: AppDecoration.fillYellow.copyWith(
                      borderRadius: BorderRadiusStyle.roundedBorder3,
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            height: 15.v,
                            width: 21.h,
                            decoration: BoxDecoration(
                              color: appTheme.yellow600,
                              borderRadius: BorderRadius.circular(
                                3.h,
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                3.h,
                              ),
                              child: LinearProgressIndicator(
                                value: 0.14,
                                backgroundColor: appTheme.yellow600,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  appTheme.green900,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                            height: 15.v,
                            width: 21.h,
                            child: Stack(
                              alignment: Alignment.centerRight,
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    height: 15.v,
                                    width: 21.h,
                                    decoration: BoxDecoration(
                                      color: appTheme.deepOrangeA200
                                          .withOpacity(0.46),
                                      borderRadius: BorderRadius.circular(
                                        3.h,
                                      ),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                        3.h,
                                      ),
                                      child: LinearProgressIndicator(
                                        value: 0.14,
                                        backgroundColor: appTheme.deepOrangeA200
                                            .withOpacity(0.46),
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                          appTheme.green900,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                CustomImageView(
                                  imagePath: ImageConstant.imgSubtract,
                                  height: 11.v,
                                  width: 10.h,
                                  alignment: Alignment.centerRight,
                                  margin: EdgeInsets.only(right: 2.h),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    height: 11.v,
                                    width: 3.h,
                                    margin: EdgeInsets.only(left: 5.h),
                                    decoration: BoxDecoration(
                                      color: appTheme.deepOrangeA200,
                                    ),
                                  ),
                                ),
                                Opacity(
                                  opacity: 0.2,
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      height: 11.v,
                                      width: 3.h,
                                      margin: EdgeInsets.only(left: 5.h),
                                      decoration: BoxDecoration(
                                        color:
                                            theme.colorScheme.primaryContainer,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 8.h,
                    top: 1.v,
                    right: 96.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Sri Lanka at Dambulla",
                        style: theme.textTheme.labelLarge,
                      ),
                      SizedBox(height: 3.v),
                      Text(
                        "August 18, 2008",
                        style: theme.textTheme.labelLarge,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              top: 10.v,
              bottom: 9.v,
            ),
            decoration: AppDecoration.outlineGray3006,
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.v),
                  child: Text(
                    "T20I",
                    style: theme.textTheme.labelLarge,
                  ),
                ),
                Spacer(),
                CustomImageView(
                  imagePath: ImageConstant.imgTelevisionGreen600,
                  height: 15.v,
                  width: 21.h,
                  radius: BorderRadius.circular(
                    3.h,
                  ),
                  margin: EdgeInsets.only(
                    top: 2.v,
                    bottom: 19.v,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 8.h,
                    top: 1.v,
                    right: 105.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Zimbabwe at Harare",
                        style: theme.textTheme.labelLarge,
                      ),
                      SizedBox(height: 3.v),
                      Text(
                        "June 12, 2010",
                        style: theme.textTheme.labelLarge,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              top: 10.v,
              bottom: 9.v,
            ),
            decoration: AppDecoration.outlineGray3006,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: 11.v,
                    bottom: 10.v,
                  ),
                  child: Text(
                    "Test",
                    style: theme.textTheme.labelLarge,
                  ),
                ),
                Spacer(),
                CustomImageView(
                  imagePath: ImageConstant.imgTeamLogo,
                  height: 17.adaptSize,
                  width: 17.adaptSize,
                  margin: EdgeInsets.only(
                    top: 2.v,
                    bottom: 17.v,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 10.h,
                    top: 2.v,
                    right: 85.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "West Indies at Kingston",
                        style: theme.textTheme.labelLarge,
                      ),
                      SizedBox(height: 2.v),
                      Text(
                        "June 20 - 23, 2011",
                        style: theme.textTheme.labelLarge,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 11.v),
          Padding(
            padding: EdgeInsets.only(right: 69.h),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 17.v),
                  child: Text(
                    "IPL",
                    style: theme.textTheme.labelLarge,
                  ),
                ),
                Spacer(),
                CustomImageView(
                  imagePath: ImageConstant.imgTeamLogoPrimary,
                  height: 21.adaptSize,
                  width: 21.adaptSize,
                  margin: EdgeInsets.only(bottom: 29.v),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 157.h,
                        child: Text(
                          "Kolkata Knight Riders at M Chinnaswamy Stadium",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.labelLarge,
                        ),
                      ),
                      Text(
                        "April 18, 2008",
                        style: theme.textTheme.labelLarge,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 9.v)
        ],
      ),
    );
  }

  /// Common widget
  Widget _buildRowInnings(
    BuildContext context, {
    required String inningsText,
    required String scoreText,
  }) {
    return Container(
      padding: EdgeInsets.only(
        top: 10.v,
        bottom: 9.v,
      ),
      decoration: AppDecoration.outlineGray3006,
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 2.v),
            child: Text(
              inningsText,
              style: theme.textTheme.labelLarge!.copyWith(
                color: theme.colorScheme.primary.withOpacity(0.9),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 95.h,
              top: 1.v,
            ),
            child: Text(
              scoreText,
              style: theme.textTheme.labelLarge!.copyWith(
                color: theme.colorScheme.primary.withOpacity(0.9),
              ),
            ),
          )
        ],
      ),
    );
  }

  /// Navigates back to the previous screen.
  onTapImgArrowleftone(BuildContext context) {
    Navigator.pop(context);
  }
}
