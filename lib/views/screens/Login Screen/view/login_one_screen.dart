import 'package:cricyard/views/widgets/custom_icon_button_f.dart';
import 'package:cricyard/views/widgets/custom_text_form_field_f.dart';
import 'package:flutter/material.dart';
import '../../../../core/app_export.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../../../widgets/custom_icon_button.dart';

// ignore_for_file: must_be_immutable
class LoginOneScreen extends StatelessWidget {
  LoginOneScreen({Key? key})
      : super(
          key: key,
        );

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SizedBox(
            height: SizeUtils.height,
            child: Form(
              key: _formKey,
              child: Container(
                width: double.maxFinite,
                padding: EdgeInsets.all(37.h),
                child: Column(
                  children: [
                    CustomImageView(
                      imagePath: ImageConstant.imgImageRemovebgPreview,
                      height: 51.v,
                      width: 337.h,
                    ),
                    SizedBox(height: 54.v),
                    Text(
                      "Welcome back!",
                      style: theme.textTheme.displaySmall,
                    ),
                    SizedBox(height: 68.v),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 17.h,
                        right: 6.h,
                      ),
                      child: custom_text_form_field_f(
                        controller: emailController,
                        hintText: "Enter your email",
                        textInputType: TextInputType.emailAddress,
                        borderDecoration:
                            TextFormFieldStyleHelper.outlineOnPrimaryContainer,
                        fillColor: appTheme.gray50,
                      ),
                    ),
                    SizedBox(height: 15.v),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 17.h,
                        right: 6.h,
                      ),
                      child: custom_text_form_field_f(
                        controller: passwordController,
                        hintText: "Enter your password",
                        textInputAction: TextInputAction.done,
                        textInputType: TextInputType.visiblePassword,
                        suffix: Container(
                          margin: EdgeInsets.fromLTRB(30.h, 17.v, 16.h, 17.v),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              11.h,
                            ),
                          ),
                          child: CustomImageView(
                            imagePath: ImageConstant.imgFluenteye20filled,
                            height: 22.adaptSize,
                            width: 22.adaptSize,
                          ),
                        ),
                        suffixConstraints: BoxConstraints(
                          maxHeight: 56.v,
                        ),
                        obscureText: true,
                        contentPadding: EdgeInsets.only(
                          left: 18.h,
                          top: 19.v,
                          bottom: 19.v,
                        ),
                      ),
                    ),
                    SizedBox(height: 16.v),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.only(right: 6.h),
                        child: Text(
                          "Forgot Password?",
                          style: CustomTextStyles.titleSmallGray600,
                        ),
                      ),
                    ),
                    SizedBox(height: 29.v),
                    CustomElevatedButton(
                      text: "Login",
                      margin: EdgeInsets.only(
                        left: 17.h,
                        right: 6.h,
                      ),
                      buttonTextStyle: theme.textTheme.titleMedium!,
                    ),
                    SizedBox(height: 41.v),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 17.h,
                        right: 5.h,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.v),
                            child: SizedBox(
                              width: 112.h,
                              child: const Divider(),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 12.h),
                            child: Text(
                              "Or Login with",
                              style: CustomTextStyles.titleSmallGray600,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.v),
                            child: SizedBox(
                              width: 123.h,
                              child: Divider(
                                indent: 12.h,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 21.v),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.only(right: 49.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              height: 56.v,
                              width: 105.h,
                              padding: EdgeInsets.symmetric(
                                horizontal: 36.h,
                                vertical: 14.v,
                              ),
                              decoration: AppDecoration
                                  .outlineOnPrimaryContainer
                                  .copyWith(
                                borderRadius: BorderRadiusStyle.roundedBorder8,
                              ),
                              child: CustomImageView(
                                imagePath: ImageConstant.imgFacebookIc,
                                height: 26.adaptSize,
                                width: 26.adaptSize,
                                alignment: Alignment.centerLeft,
                              ),
                            ),
                            Container(
                              height: 56.v,
                              width: 105.h,
                              margin: EdgeInsets.only(left: 28.h),
                              padding: EdgeInsets.symmetric(
                                horizontal: 38.h,
                                vertical: 13.v,
                              ),
                              decoration: AppDecoration
                                  .outlineOnPrimaryContainer
                                  .copyWith(
                                borderRadius: BorderRadiusStyle.roundedBorder8,
                              ),
                              child: CustomImageView(
                                imagePath: ImageConstant.imgGoogleIc,
                                height: 26.adaptSize,
                                width: 26.adaptSize,
                                alignment: Alignment.topCenter,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 62.v),
                    SizedBox(
                      width: 182.h,
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Don’t have an account?",
                              style:
                                  CustomTextStyles.titleSmallPoppinsGray90001,
                            ),
                            const TextSpan(
                              text: " ",
                            ),
                            TextSpan(
                              text: "Register Now",
                              style: CustomTextStyles
                                  .titleSmallPoppinsDeeppurpleA400,
                            )
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const Spacer(),
                    CustomIconButton_f(
                      height: 32.adaptSize,
                      width: 32.adaptSize,
                      padding: EdgeInsets.all(5.h),
                      alignment: Alignment.centerLeft,
                      child: CustomImageView(
                        imagePath: ImageConstant.imgArrowLeft,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
