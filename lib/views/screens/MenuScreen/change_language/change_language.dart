import 'package:cricyard/core/app_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as fs;

import '../../../widgets/custom_floating_button.dart';
import '../../../widgets/custom_icon_button.dart';
import '../../../widgets/custom_outlined_button.dart';

class ChangeLanguageScreen extends StatelessWidget {
  const ChangeLanguageScreen({Key? key})
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
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 17.h,
                  vertical: 54.v,
                ),
                child: Column(
                  children: [
                    _buildTelevisionRow(context),
                    SizedBox(height: 44.v),
                    _buildMarathiButton(context),
                    SizedBox(height: 22.v),
                    _buildTeluguButton(context),
                    SizedBox(height: 22.v),
                    _buildTamilButton(context),
                    SizedBox(height: 22.v),
                    _buildKannadaButton(context),
                    SizedBox(height: 23.v),
                    _buildGujratiButton(context),
                    SizedBox(height: 23.v),
                    _buildHindiButton(context),
                    SizedBox(height: 29.v),
                    _buildBengaliButton(context),
                    SizedBox(height: 23.v),
                    _buildBihariButton(context)
                  ],
                ),
              ),
              SizedBox(height: 9.v)
            ],
          ),
        ),
        bottomNavigationBar: _buildBottomAppBarSearch(context),
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
              top: 3.v,
              bottom: 8.v,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 24.h),
            child: Text(
              "Change Language",
              style: theme.textTheme.headlineSmall,
            ),
          ),
          Spacer(),
          CustomImageView(
            imagePath: ImageConstant.imgTelevisionErrorcontainer,
            height: 24.adaptSize,
            width: 24.adaptSize,
            margin: EdgeInsets.only(
              top: 3.v,
              bottom: 8.v,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 24.h,
              top: 3.v,
              bottom: 8.v,
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
  Widget _buildMarathiButton(BuildContext context) {
    return CustomOutlinedButton(
      text: "Marathiमराठी",
      margin: EdgeInsets.only(
        left: 32.h,
        right: 31.h,
      ),
    );
  }

  /// Section Widget
  Widget _buildTeluguButton(BuildContext context) {
    return CustomOutlinedButton(
      text: "Telugu",
      margin: EdgeInsets.only(
        left: 32.h,
        right: 31.h,
      ),
    );
  }

  /// Section Widget
  Widget _buildTamilButton(BuildContext context) {
    return CustomOutlinedButton(
      text: "Tamil",
      margin: EdgeInsets.only(
        left: 32.h,
        right: 31.h,
      ),
    );
  }

  /// Section Widget
  Widget _buildKannadaButton(BuildContext context) {
    return CustomOutlinedButton(
      text: "Kannada",
      margin: EdgeInsets.only(
        left: 32.h,
        right: 31.h,
      ),
    );
  }

  /// Section Widget
  Widget _buildGujratiButton(BuildContext context) {
    return CustomOutlinedButton(
      text: "Gujrati",
      margin: EdgeInsets.only(
        left: 32.h,
        right: 31.h,
      ),
    );
  }

  /// Section Widget
  Widget _buildHindiButton(BuildContext context) {
    return CustomOutlinedButton(
      text: "Hindi",
      margin: EdgeInsets.only(
        left: 32.h,
        right: 31.h,
      ),
    );
  }

  /// Section Widget
  Widget _buildBengaliButton(BuildContext context) {
    return CustomOutlinedButton(
      text: "Bengali",
      margin: EdgeInsets.only(
        left: 29.h,
        right: 34.h,
      ),
    );
  }

  /// Section Widget
  Widget _buildBihariButton(BuildContext context) {
    return CustomOutlinedButton(
      text: "Bihari",
      margin: EdgeInsets.only(
        left: 32.h,
        right: 31.h,
      ),
    );
  }

  /// Section Widget
  Widget _buildBottomAppBarSearch(BuildContext context) {
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
