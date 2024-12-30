import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as fs;
// import 'package:readmore/readmore.dart';
import 'package:cricyard/core/app_export.dart';
import '../../../widgets/custom_floating_button.dart';
import '../../../widgets/custom_icon_button.dart';
import 'side_slide_menu_draweritem.dart';
// import 'package:cricyard/Utils/image_constant.dart';
import 'package:cricyard/Utils/color_constants.dart';
import 'package:cricyard/Utils/size_utils.dart';

class Dashboardcreen extends StatelessWidget {
  Dashboardcreen({Key? key})
      : super(
          key: key,
        );

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: double.maxFinite,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 15.h,
                  vertical: 43.v,
                ),
                child: Column(
                  children: [
                    _buildTelevisionRow(context),
                    SizedBox(height: 61.v),
                    _buildOngoingStack(context),
                    Divider(
                      color: theme.colorScheme.primaryContainer,
                      indent: 37.h,
                      endIndent: 28.h,
                    ),
                    SizedBox(height: 9.v),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 3.h),
                      decoration: AppDecoration.fillGray700.copyWith(
                        borderRadius: BorderRadiusStyle.roundedBorder10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                              left: 1.h,
                              top: 9.v,
                              bottom: 4.v,
                            ),
                            decoration: AppDecoration.outlineBlack,
                            child: Text(
                              "Live SCORE ",
                              style: theme.textTheme.bodySmall,
                            ),
                          ),
                          CustomImageView(
                            imagePath: ImageConstant.imgLive11,
                            height: 32.adaptSize,
                            width: 32.adaptSize,
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 9.v),
                    Container(
                      width: 111.h,
                      padding: EdgeInsets.symmetric(
                        horizontal: 4.h,
                        vertical: 5.v,
                      ),
                      decoration: AppDecoration.fillGray700.copyWith(
                        borderRadius: BorderRadiusStyle.roundedBorder10,
                      ),
                      child: Text(
                        "Fixtures/Results",
                        style: CustomTextStyles.bodyMediumPoppinsBluegray50,
                      ),
                    ),
                    SizedBox(height: 18.v),
                    Divider(
                      color: theme.colorScheme.primaryContainer,
                      indent: 37.h,
                      endIndent: 28.h,
                    ),
                    SizedBox(height: 6.v),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 40.h),
                        child: Text(
                          "Stories",
                          style: CustomTextStyles.headlineLargeSemiBold,
                        ),
                      ),
                    ),
                    SizedBox(height: 17.v),
                    CustomImageView(
                      imagePath: ImageConstant.imgImage3,
                      height: 136.v,
                      width: 167.h,
                      radius: BorderRadius.circular(
                        5.h,
                      ),
                    ),
                    SizedBox(height: 7.v),
                    // ReadMoreText(
                    //   "Lucknow beat Punjab in RUN FEST",
                    //   trimLines: 2,
                    //   colorClickableText: appTheme.black900,
                    //   trimMode: TrimMode.Line,
                    //   trimCollapsedText: "Read more",
                    //   moreStyle: CustomTextStyles.titleMediumBlack900Medium,
                    //   lessStyle: CustomTextStyles.titleMediumBlack900Medium,
                    // )
                  ],
                ),
              ),
              SizedBox(height: 8.v)
            ],
          ),
        ),
        bottomNavigationBar: _buildBottomAppBarStack(context),
        floatingActionButton: CustomFloatingButton(
          height: 64,
          width: 64,
          alignment: Alignment.topCenter,
          child: CustomImageView(
            svgPath: ImageConstant.imgLocation,
            height: 32.0.v,
            width: 32.0.h,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }

  //  Section Widget
  Widget _buildTelevisionRow(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _scaffoldKey.currentState?.openDrawer();
      },
      child: Padding(
        padding: EdgeInsets.only(left: 13.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            IconButton(
                icon: const Icon(
                  Icons.circle_outlined,
                  color: Colors.black,
                ),
                onPressed: () {}),
            CustomImageView(
              svgPath: ImageConstant.imgTelevision,
              height: 24.adaptSize,
              width: 24.adaptSize,
              margin: EdgeInsets.only(
                top: 11.v,
                bottom: 2.v,
              ),
            ),
            CustomImageView(
              imagePath: ImageConstant.imgImageRemovebgPreview,
              height: 35.v,
              width: 272.h,
              margin: EdgeInsets.only(
                left: 15.h,
                bottom: 2.v,
              ),
            ),
            CustomImageView(
              svgPath: ImageConstant.imgTelevisionPrimarycontainer,
              height: 24.adaptSize,
              width: 24.adaptSize,
              margin: EdgeInsets.only(
                left: 15.h,
                top: 11.v,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 11.h,
                top: 11.v,
                bottom: 2.v,
              ),
              child: CustomIconButton(
                height: 24.adaptSize,
                width: 24.adaptSize,
                decoration: IconButtonStyleHelper.fillPrimaryContainer,
                child: CustomImageView(
                  svgPath: ImageConstant.imgVector,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildOngoingStack(BuildContext context) {
    return SizedBox(
      height: 204.v,
      width: 350.h,
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Text(
              "Ongoing",
              style: CustomTextStyles.headlineLargeSemiBold,
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: EdgeInsets.only(
                left: 10.h,
                right: 191.h,
                bottom: 33.v,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "4.3 Ov.",
                      style: theme.textTheme.titleLarge,
                    ),
                  ),
                  SizedBox(height: 5.v),
                  Text(
                    "Team 1",
                    style: theme.textTheme.headlineSmall,
                  )
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 80.h),
              child: Text(
                "Run Rate 2.80",
                style: theme.textTheme.headlineSmall,
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(
                left: 96.h,
                top: 65.v,
              ),
              child: Text(
                "12/0-",
                style: theme.textTheme.titleLarge,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: EdgeInsets.only(
                right: 2.h,
                bottom: 31.v,
              ),
              child: Text(
                "Team 2",
                style: theme.textTheme.headlineSmall,
              ),
            ),
          ),
          CustomImageView(
            imagePath: ImageConstant.imgImage1,
            height: 102.v,
            width: 95.h,
            alignment: Alignment.topLeft,
            margin: EdgeInsets.only(top: 38.v),
          ),
          CustomImageView(
            imagePath: ImageConstant.imgImage2,
            height: 102.adaptSize,
            width: 102.adaptSize,
            alignment: Alignment.topRight,
            margin: EdgeInsets.only(top: 41.v),
          ),
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              height: 100.v,
              child: VerticalDivider(
                width: 1.h,
                thickness: 1.v,
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: EdgeInsets.only(
                left: 187.h,
                top: 66.v,
                right: 100.h,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "To Bat",
                    style: theme.textTheme.titleLarge,
                  ),
                  Text(
                    "0 Ov.",
                    style: theme.textTheme.titleLarge,
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
  Widget _buildBottomAppBarStack(BuildContext context) {
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
                    Padding(
                      padding: EdgeInsets.only(left: 123.h),
                      child: CustomIconButton(
                        height: 50.adaptSize,
                        width: 50.adaptSize,
                        padding_f: EdgeInsets.all(12.h),
                        child: CustomImageView(
                          svgPath: ImageConstant.imgFluentLive24Filled,
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
                          svgPath: ImageConstant.imgNotification,
                        ),
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
}
