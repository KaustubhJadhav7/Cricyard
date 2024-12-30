import 'package:cricyard/core/app_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as fs;
import '../../../../widgets/custom_floating_button.dart';
import '../../../../widgets/custom_icon_button.dart';
import '../../../ReuseableWidgets/BottomAppBarWidget.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(vertical: 8.v),
          child: Column(
            children: [
              SizedBox(height: 52.v),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 32.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(bottom: 15.v),
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
                            Padding(
                              padding: EdgeInsets.only(left: 22.h),
                              child: Text(
                                "Settings",
                                style: theme.textTheme.headlineLarge,
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 16.v),
                        Padding(
                          padding: EdgeInsets.only(left: 10.h, right: 16.h),
                          child: Text(
                            "Account",
                            style: theme.textTheme.titleMedium,
                          ),
                        ),
                        SizedBox(height: 6.v),
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            width: 342.h,
                            margin: EdgeInsets.only(
                              left: 6.h,
                              right: 16.h,
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.h,
                              vertical: 12.v,
                            ),
                            decoration: AppDecoration.fillBlueGray.copyWith(
                              borderRadius: BorderRadiusStyle.roundedBorder6,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    CustomImageView(
                                      imagePath:
                                          ImageConstant.setting_profile_logo,
                                      height: 30.adaptSize,
                                      width: 30.adaptSize,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: 36.h,
                                        top: 4.v,
                                      ),
                                      child: Text(
                                        "Edit profile",
                                        style: theme.textTheme.titleMedium,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 9.v),
                                Row(
                                  children: [
                                    CustomImageView(
                                      imagePath:
                                          ImageConstant.setting_securitylogo,
                                      height: 30.adaptSize,
                                      width: 30.adaptSize,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: 36.h,
                                        top: 4.v,
                                      ),
                                      child: Text(
                                        "security",
                                        style: theme.textTheme.titleMedium,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 9.v),
                                Row(
                                  children: [
                                    CustomImageView(
                                      imagePath:
                                          ImageConstant.setting_notification,
                                      height: 30.adaptSize,
                                      width: 30.adaptSize,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: 36.h,
                                        top: 2.v,
                                        bottom: 3.v,
                                      ),
                                      child: Text(
                                        "Notifications",
                                        style: theme.textTheme.titleMedium,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 9.v),
                                Row(
                                  children: [
                                    CustomImageView(
                                      imagePath: ImageConstant.setting_privacy,
                                      height: 30.adaptSize,
                                      width: 30.adaptSize,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: 36.h,
                                        top: 4.v,
                                      ),
                                      child: Text(
                                        "Privacy",
                                        style: theme.textTheme.titleMedium,
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 24.v),
                        _buildColumnsupportab(context),
                        SizedBox(height: 27.v),
                        Padding(
                          padding: EdgeInsets.only(left: 10.h),
                          child: Text(
                            "Cache & cellular",
                            style: theme.textTheme.titleMedium,
                          ),
                        ),
                        SizedBox(height: 21.v),
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            width: 342.h,
                            margin: EdgeInsets.only(right: 20.h),
                            padding: EdgeInsets.symmetric(
                              horizontal: 15.h,
                              vertical: 12.v,
                            ),
                            decoration: AppDecoration.fillBlueGray.copyWith(
                              borderRadius: BorderRadiusStyle.roundedBorder6,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    CustomImageView(
                                      imagePath:
                                          ImageConstant.setting_free_space,
                                      height: 30.adaptSize,
                                      width: 30.adaptSize,
                                    ),
                                    Opacity(
                                      opacity: 0.9,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          left: 38.h,
                                          top: 5.v,
                                        ),
                                        child: Text(
                                          "Free up space",
                                          style: CustomTextStyles
                                              .titleMediumPrimary,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 9.v),
                                Row(
                                  children: [
                                    CustomImageView(
                                      imagePath:
                                          ImageConstant.setting_datasaver,
                                      height: 30.adaptSize,
                                      width: 30.adaptSize,
                                    ),
                                    Opacity(
                                      opacity: 0.9,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          left: 38.h,
                                          top: 3.v,
                                          bottom: 2.v,
                                        ),
                                        child: Text(
                                          "Data Saver",
                                          style: CustomTextStyles
                                              .titleMediumPrimary,
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 21.v),
                        _buildColumnactions(context)
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBarWidget(),
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

  /// Section Widget
  Widget _buildColumnsupportab(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 11.h),
            child: Text(
              "Support & About",
              style: theme.textTheme.titleMedium,
            ),
          ),
          SizedBox(height: 3.v),
          Container(
            width: 342.h,
            margin: EdgeInsets.only(left: 6.h),
            padding: EdgeInsets.symmetric(
              horizontal: 16.h,
              vertical: 12.v,
            ),
            decoration: AppDecoration.fillBlueGray.copyWith(
              borderRadius: BorderRadiusStyle.roundedBorder6,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CustomImageView(
                      imagePath: ImageConstant.setting_subscription,
                      height: 30.adaptSize,
                      width: 30.adaptSize,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 35.h,
                        top: 4.v,
                      ),
                      child: Text(
                        "My Subscribtion",
                        style: theme.textTheme.titleMedium,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 9.v),
                Row(
                  children: [
                    CustomImageView(
                      imagePath: ImageConstant.setting_help,
                      height: 30.adaptSize,
                      width: 30.adaptSize,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 36.h,
                        top: 5.v,
                      ),
                      child: Text(
                        "Help & Support",
                        style: theme.textTheme.titleMedium,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 9.v),
                Padding(
                  padding: EdgeInsets.only(right: 91.h),
                  child: Row(
                    children: [
                      CustomImageView(
                        imagePath: ImageConstant.setting_terms,
                        height: 30.adaptSize,
                        width: 30.adaptSize,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 36.h,
                          top: 2.v,
                          bottom: 3.v,
                        ),
                        child: Text(
                          "Terms and Policies",
                          style: theme.textTheme.titleMedium,
                        ),
                      )
                    ],
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
  Widget _buildColumnactions(BuildContext context) {
    var fillIndigoC;
    return Padding(
      padding: EdgeInsets.only(right: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 11.h),
            child: Text(
              "Actions",
              style: theme.textTheme.titleMedium,
            ),
          ),
          SizedBox(height: 6.v),
          Container(
            width: 342.h,
            margin: EdgeInsets.only(left: 6.h),
            padding: EdgeInsets.all(12.h),
            decoration: AppDecoration.fillBlueGray.copyWith(
              borderRadius: BorderRadiusStyle.roundedBorder6,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    CustomImageView(
                      imagePath: ImageConstant.setting_reportspam,
                      height: 30.adaptSize,
                      width: 30.adaptSize,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 36.h,
                        top: 5.v,
                      ),
                      child: Text(
                        "Report a problem",
                        style: theme.textTheme.titleMedium,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 9.v),
                Row(
                  children: [
                    CustomImageView(
                      imagePath: ImageConstant.setting_addaccount,
                      height: 30.adaptSize,
                      width: 30.adaptSize,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 36.h,
                        top: 3.v,
                        bottom: 2.v,
                      ),
                      child: Text(
                        "Add account",
                        style: theme.textTheme.titleMedium,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 9),
                GestureDetector(
                  // onTap: () => _logoutUser(), // Define the action on tap

                  child: Row(
                    children: [
                      CustomImageView(
                        imagePath: ImageConstant.setting_logout,
                        height: 30.adaptSize,
                        width: 30.adaptSize,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 36.h,
                          top: 5.v,
                        ),
                        child: Text(
                          "Log out",
                          style: theme.textTheme.titleMedium,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildBottomappbarsea(BuildContext context) {
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
                      ImageConstant.imgGroup152,
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
                      // padding: EdgeInsets.all(13.h),
                      child: CustomImageView(
                        svgPath: ImageConstant.imgSearch,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 27.h),
                      child: CustomIconButton(
                        height: 50.adaptSize,
                        width: 50.adaptSize,
                        // padding: EdgeInsets.all(12.h),
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
                        // padding: EdgeInsets.all(12.h),
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
                        // padding: EdgeInsets.all(10.h),
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

  /// Navigates back to the previous screen.
  onTapBtnArrowleftone(BuildContext context) {
    Navigator.pop(context);
  }

  //   Future<void> _logoutUser() async {
  //   try {
  //     SharedPreferences prefs = await SharedPreferences.getInstance();

  //     // Remove 'userData' and 'isLoggedIn' from SharedPreferences
  //     await prefs.remove('userData');
  //     await prefs.remove('isLoggedIn');
  //     String logouturl = "${ApiConstants.baseUrl}/token/logout";
  //     var response = await http.get(Uri.parse(logouturl));
  //     if (response.statusCode == 401) {
  //       LogoutService.logout();
  //     }
  //     if (response.statusCode <= 209) {
  //       // ignore: use_build_context_synchronously
  //       Navigator.pushAndRemoveUntil(
  //         context,
  //         MaterialPageRoute(builder: (context) => const LoginScreenF(false)),
  //         (route) => false, // Remove all routes from the stack
  //       );
  //     } else {
  //       const Text('failed to logout');
  //     }
  //   } catch (error) {
  //     print('Error occurred during logout: $error');
  //   }
  // }
}
