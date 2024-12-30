import 'package:cricyard/core/app_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as fs;

import '../../../../../core/utils/image_constant.dart';
import '../../../../widgets/custom_floating_button.dart';
import '../../../../widgets/custom_icon_button.dart';
import '../../../../widgets/custom_image_view.dart';
import '../../../../widgets/custom_text_form_field.dart';
import '../login_page/login_page.dart';

class LoginTabContainerScreen extends StatefulWidget {
  const LoginTabContainerScreen({Key? key})
      : super(
          key: key,
        );

  @override
  LoginTabContainerScreenState createState() => LoginTabContainerScreenState();
}
// ignore_for_file: must_be_immutable

// ignore_for_file: must_be_immutable
class LoginTabContainerScreenState extends State<LoginTabContainerScreen>
    with TickerProviderStateMixin {
  TextEditingController underlineoneController = TextEditingController();

  late TabController tabviewController;

  @override
  void initState() {
    super.initState();
    tabviewController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SizedBox(
          width: double.maxFinite,
          child: Column(
            children: [
              Column(
                children: [
                  SizedBox(height: 46.v),
                  _buildTelevisionRow(context),
                  SizedBox(height: 34.v),
                  _buildUnderlineStack(context),
                  SizedBox(
                    height: 627.v,
                    child: TabBarView(
                      controller: tabviewController,
                      children: [
                        LoginPage(),
                        LoginPage(),
                        LoginPage(),
                        LoginPage()
                      ],
                    ),
                  )
                ],
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
      padding: EdgeInsets.only(
        left: 14.h,
        right: 17.h,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgTelevision,
            height: 24.adaptSize,
            width: 24.adaptSize,
            margin: EdgeInsets.only(top: 11.v),
          ),
          CustomImageView(
            imagePath: ImageConstant.imgImageRemovebgPreview,
            height: 35.v,
            width: 272.h,
            margin: EdgeInsets.only(left: 30.h),
          ),
          CustomImageView(
            imagePath: ImageConstant.imgTelevisionBlueA20002,
            height: 24.adaptSize,
            width: 24.adaptSize,
            margin: EdgeInsets.only(
              left: 11.h,
              top: 11.v,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 12.h,
              top: 11.v,
            ),
            child: CustomIconButton(
              height: 24.adaptSize,
              width: 24.adaptSize,
              decoration: IconButtonStyleHelper.fillBlueA,
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
  Widget _buildUnderlineStack(BuildContext context) {
    return SizedBox(
      height: 60.v,
      width: 424.h,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 113.h),
            child: CustomTextFormField(
              width: 107.h,
              controller: underlineoneController,
              textInputAction: TextInputAction.done,
              alignment: Alignment.topLeft,
            ),
          ),
          Container(
            height: 56.v,
            width: 424.h,
            decoration: BoxDecoration(
              color: appTheme.blueA20002,
              borderRadius: BorderRadius.circular(
                10.h,
              ),
            ),
            child: TabBar(
              controller: tabviewController,
              labelPadding: EdgeInsets.zero,
              tabs: [
                Tab(
                  child: Text(
                    "matches",
                  ),
                ),
                Tab(
                  child: Text(
                    "Tournament",
                  ),
                ),
                Tab(
                  child: Text(
                    "Teams",
                  ),
                ),
                Tab(
                  child: Text(
                    "Highlights",
                  ),
                )
              ],
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
                      ImageConstant.imgGroup183,
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
