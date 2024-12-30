import 'package:cricyard/core/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as fs;

import '../../../../core/utils/image_constant.dart';
import '../../../../theme/custom_text_style.dart';
import '../../../widgets/custom_floating_button.dart';
import '../../../widgets/custom_icon_button.dart';
import '../../../widgets/custom_image_view.dart';

class share_appScreen extends StatelessWidget {
  const share_appScreen({Key? key})
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
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 17.h,
                    vertical: 50.v,
                  ),
                  child: Column(
                    children: [
                      _buildTelevisionRow(context),
                      SizedBox(height: 21.v),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: 54.h,
                            right: 34.h,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomImageView(
                                imagePath: ImageConstant.imgLogo2,
                                height: 50.adaptSize,
                                width: 50.adaptSize,
                                margin: EdgeInsets.symmetric(vertical: 20.v),
                              ),
                              CustomImageView(
                                imagePath: ImageConstant.imgClock,
                                height: 91.adaptSize,
                                width: 91.adaptSize,
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 55.v),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 54.h,
                          right: 72.h,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 4.v),
                              child: CustomIconButton(
                                height: 52.adaptSize,
                                width: 52.adaptSize,
                                padding_f: EdgeInsets.all(8.h),
                                decoration:
                                    IconButtonStyleHelper.fillDeepOrangeA,
                                child: CustomImageView(
                                  imagePath: ImageConstant.imgUser,
                                ),
                              ),
                            ),
                            CustomImageView(
                              imagePath: ImageConstant.imgFacebook,
                              height: 45.v,
                              width: 24.h,
                              margin: EdgeInsets.only(bottom: 10.v),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 84.v),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 53.h,
                          right: 60.h,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomImageView(
                              imagePath: ImageConstant.imgGmail,
                              height: 40.v,
                              width: 53.h,
                              margin: EdgeInsets.only(
                                top: 7.v,
                                bottom: 3.v,
                              ),
                            ),
                            CustomImageView(
                              imagePath: ImageConstant.imgLogo47,
                              height: 50.adaptSize,
                              width: 50.adaptSize,
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 85.v),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 54.h,
                          right: 59.h,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomImageView(
                              imagePath: ImageConstant.imgGrid,
                              height: 50.adaptSize,
                              width: 50.adaptSize,
                            ),
                            CustomIconButton(
                              height: 50.adaptSize,
                              width: 50.adaptSize,
                              padding_f: EdgeInsets.all(7.h),
                              decoration: IconButtonStyleHelper.fillLightBlue,
                              child: CustomImageView(
                                imagePath: ImageConstant.imgLink,
                              ),
                            )
                          ],
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 54.h,
                          right: 58.h,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomImageView(
                              imagePath: ImageConstant.imgTrash,
                              height: 38.v,
                              width: 46.h,
                              margin: EdgeInsets.only(
                                top: 2.v,
                                bottom: 8.v,
                              ),
                            ),
                            CustomIconButton(
                              height: 50.adaptSize,
                              width: 50.adaptSize,
                              padding_f: EdgeInsets.all(9.h),
                              decoration: IconButtonStyleHelper.fillBlue,
                              child: CustomImageView(
                                imagePath: ImageConstant.imgSave,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 9.v)
            ],
          ),
        ),
        bottomNavigationBar: _buildBottomAppBar(context),
        floatingActionButton: CustomFloatingButton(
          height: 64,
          width: 64,
          alignment: Alignment.topCenter,
          child: CustomImageView(
            imagePath: ImageConstant.imgLocation,
            height: 32.0.v,
            width: 32.0.h,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }

  /// Section Widget
  Widget _buildTelevisionRow(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 5.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgTelevision,
            height: 24.adaptSize,
            width: 24.adaptSize,
            margin: EdgeInsets.only(
              top: 7.v,
              bottom: 16.v,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 27.h),
            child: Text(
              "Share App",
              style: CustomTextStyles.headlineLargePoppinsBlack900,
            ),
          ),
          Spacer(),
          CustomImageView(
            imagePath: ImageConstant.imgTelevisionErrorcontainer,
            height: 24.adaptSize,
            width: 24.adaptSize,
            margin: EdgeInsets.only(
              top: 7.v,
              bottom: 16.v,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 24.h,
              top: 7.v,
              bottom: 16.v,
            ),
            child: CustomIconButton(
              height: 24.adaptSize,
              width: 24.adaptSize,
              decoration: IconButtonStyleHelper.fillErrorContainer,
              child: CustomImageView(
                imagePath: ImageConstant.imgVector,
              ),
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildBottomAppBar(BuildContext context) {
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
                      ImageConstant.imgGroup94,
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
                        imagePath: ImageConstant.imgSearch,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 27.h),
                      child: CustomIconButton(
                        height: 50.adaptSize,
                        width: 50.adaptSize,
                        padding_f: EdgeInsets.all(12.h),
                        child: CustomImageView(
                          imagePath: ImageConstant.imgBxCricketBall,
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
                          imagePath: ImageConstant.imgFluentLive24Filled,
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
                          imagePath: ImageConstant.imgNotification,
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
                imagePath: ImageConstant.imgLocation,
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
