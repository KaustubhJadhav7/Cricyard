import 'package:cricyard/core/app_export.dart';
import 'package:flutter/material.dart';

import '../../../../../theme/custom_button_style.dart';
import '../../../../widgets/custom_drop_down.dart';
import '../../../../widgets/custom_elevated_button.dart';
// ignore_for_file: must_be_immutable

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key})
      : super(
          key: key,
        );

  @override
  LoginPageState createState() => LoginPageState();
}
// ignore_for_file: must_be_immutable

// ignore_for_file: must_be_immutable
class LoginPageState extends State<LoginPage>
    with AutomaticKeepAliveClientMixin<LoginPage> {
  List<String> dropdownItemList = ["Item One", "Item Two", "Item Three"];

  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.maxFinite,
          decoration: AppDecoration.fillOnError,
          child: Column(
            children: [
              SizedBox(height: 18.v),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 21.h,
                    right: 16.h,
                  ),
                  child: Column(
                    children: [
                      _buildRowmy(context),
                      Spacer(
                        flex: 33,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 22.h,
                          right: 38.h,
                        ),
                        child: CustomDropDown(
                          hintText: "Audio Language",
                          items: dropdownItemList,
                        ),
                      ),
                      Spacer(
                        flex: 66,
                      ),
                      _buildRowregister(context)
                    ],
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
  Widget _buildMyTournamentButton(BuildContext context) {
    return Expanded(
      child: CustomElevatedButton(
        text: "My tournament",
        margin: EdgeInsets.only(right: 6.h),
        buttonStyle: CustomButtonStyles.none,
        decoration: CustomButtonStyles.gradientWhiteAToWhiteADecoration,
        buttonTextStyle: CustomTextStyles.labelLargePoppinsGray50,
      ),
    );
  }

  /// Section Widget
  Widget _buildFollowingButton(BuildContext context) {
    return Expanded(
      child: CustomElevatedButton(
        text: "Following",
        margin: EdgeInsets.symmetric(horizontal: 6.h),
        buttonStyle: CustomButtonStyles.none,
        decoration: CustomButtonStyles.gradientGrayBToWhiteADecoration,
      ),
    );
  }

  /// Section Widget
  Widget _buildAllButton(BuildContext context) {
    return Expanded(
      child: CustomElevatedButton(
        text: "All",
        margin: EdgeInsets.only(left: 6.h),
        buttonStyle: CustomButtonStyles.none,
        decoration: CustomButtonStyles.gradientWhiteAToWhiteADecoration,
      ),
    );
  }

  /// Section Widget
  Widget _buildRowmy(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildMyTournamentButton(context),
        _buildFollowingButton(context),
        _buildAllButton(context)
      ],
    );
  }

  /// Section Widget
  Widget _buildRegisterButton(BuildContext context) {
    return CustomElevatedButton(
      height: 43.v,
      width: 143.h,
      text: "Register",
      margin: EdgeInsets.only(top: 18.v),
      buttonStyle: CustomButtonStyles.fillBlueA,
      buttonTextStyle: CustomTextStyles.bodyLargeGray50,
    );
  }

  /// Section Widget
  Widget _buildViewAllButton(BuildContext context) {
    return CustomElevatedButton(
      height: 61.v,
      width: 188.h,
      text: "View All Tournaments",
      buttonStyle: CustomButtonStyles.none,
      decoration: CustomButtonStyles.gradientWhiteAToWhiteATL25Decoration,
      buttonTextStyle: theme.textTheme.bodyLarge!,
    );
  }

  /// Section Widget
  Widget _buildRowregister(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [_buildRegisterButton(context), _buildViewAllButton(context)],
      ),
    );
  }
}
