import 'package:cricyard/views/screens/Login%20Screen/view/login_screen_f.dart';
import 'package:flutter/material.dart';
import '../../../../core/app_export.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../../signupF/SignupScreenF.dart';

class DecisionScreen extends StatelessWidget {
  const DecisionScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(vertical: 28.v),
          child: Column(
            children: [
              _buildStackSection(context),
              SizedBox(height: 46.v),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: 278.h,
                  margin: EdgeInsets.only(left: 54.h),
                  child: Text(
                    "Discover all about Cricket",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.displayMedium!.copyWith(
                      fontWeight: FontWeight.bold, // Make text bold
                      fontSize: 35.0, // Increase font size
                      height: 1.5,
                    ),
                  ),
                ),
              ),
              const Spacer(),
              // SizedBox(height: 23.v),
              Padding(
                padding: EdgeInsets.only(
                  left: 54.h,
                  right: 66.h,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomElevatedButton(
                      height: 67.v,
                      width: MediaQuery.of(context).size.width / 2 - 70.h,
                      text: "Sign in",
                      buttonTextStyle: CustomTextStyles.titleMedium18,
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreenF(false)),
                          (route) => false, // Remove all routes from the stack
                        );
                      },
                    ),
                    const SizedBox(width: 2),
                    CustomElevatedButton(
                      height: 67.v,
                      width: MediaQuery.of(context).size.width / 2 - 70.h,
                      text: "Sign up",
                      buttonTextStyle: CustomTextStyles.titleMedium18,
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignupScreenF()),
                          (route) => false, // Remove all routes from the stack
                        );
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildStackSection(BuildContext context) {
    return SizedBox(
      height: 413.v,
      width: double.maxFinite,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // black background
          CustomImageView(
            svgPath: ImageConstant.imgGroup3090,
            height: 338.v,
            width: 291.h,
            alignment: Alignment.bottomCenter,
          ),
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              height: 400.v,
              width: double.maxFinite,
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  // player image
                  CustomImageView(
                    imagePath: ImageConstant.imgAlfredKenneall,
                    height: 408.v,
                    width: 428.h,
                    alignment: Alignment.center,
                  ),

                  const SizedBox(height: 15),

                  // cricyard logo
                  CustomImageView(
                    imagePath: ImageConstant.imgImageRemovebgPreview,
                    height: 51.v,
                    width: 337.h,
                    alignment: Alignment.topCenter,
                    margin: EdgeInsets.only(top: 9.v),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
