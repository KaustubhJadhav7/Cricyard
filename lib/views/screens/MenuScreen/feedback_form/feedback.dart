import 'package:cricyard/core/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as fs;

import '../../../../core/utils/image_constant.dart';
import '../../../../theme/custom_button_style.dart';
import '../../../../theme/custom_text_style.dart';
import '../../../../theme/theme_helper.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../../../widgets/custom_floating_button.dart';
import '../../../widgets/custom_icon_button.dart';
import '../../../widgets/custom_image_view.dart';
import '../../../widgets/custom_text_form_field.dart';
// ignore_for_file: must_be_immutable

// ignore_for_file: must_be_immutable
class feedbackScreen extends StatelessWidget {
  feedbackScreen({Key? key})
      : super(
          key: key,
        );

  TextEditingController nameController = TextEditingController();

  TextEditingController contactnumbervaController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController commentController = TextEditingController();

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
          child: Form(
            key: _formKey,
            child: SizedBox(
              width: double.maxFinite,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 26.h,
                      vertical: 49.v,
                    ),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(right: 69.h),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: 4.v,
                                    bottom: 11.v,
                                  ),
                                  child: CustomIconButton(
                                    height: 32.adaptSize,
                                    width: 32.adaptSize,
                                    padding_f: EdgeInsets.all(8.h),
                                    decoration:
                                        IconButtonStyleHelper.outlineIndigoTL12,
                                    onTap: () {
                                      onTapBtnArrowleftone(context);
                                    },
                                    child: CustomImageView(
                                      svgPath: ImageConstant
                                          .imgArrowLeftOnprimary32x32,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 20.h),
                                  child: Text(
                                    "Feedback form",
                                    style: CustomTextStyles
                                        .headlineLargePoppinsBlack900,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 20.0, // Position from the bottom
                          right: 126.0, // Position from the right
                          child: Image.asset(
                            ImageConstant.forms, 
                            height: 64.0, // Adjust image size
                            width: 64.0,
                          ),
                        ),
                        SizedBox(height: 59.v),
                        _buildRowName(context),
                        SizedBox(height: 29.v),
                        _buildEmailAddressInput(context),
                        SizedBox(height: 30.v),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 10.h),
                            child: Text(
                              "Share your experience in scaling",
                              style:
                                  CustomTextStyles.titleSmallMontserratBlack900,
                            ),
                          ),
                        ),
                        SizedBox(height: 18.v),
                        _buildRatingScale(context),
                        SizedBox(height: 30.v),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 10.h,
                            right: 16.h,
                          ),
                          child: CustomTextFormField(
                            controller: commentController,
                            hintText: "Add your comments...",
                            textInputAction: TextInputAction.done,
                            suffix: Container(
                              margin: EdgeInsets.fromLTRB(30.h, 30.v, 5.h, 5.v),
                              child: CustomImageView(
                                svgPath: ImageConstant.imgSettings,
                                height: 15.adaptSize,
                                width: 15.adaptSize,
                              ),
                            ),
                            suffixConstraints: BoxConstraints(
                              maxHeight: 85.v,
                            ),
                            maxLines: 5,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 9.h,
                              vertical: 11.v,
                            ),
                          ),
                        ),
                        SizedBox(height: 40.v),
                        CustomElevatedButton(
                          height: 45.v,
                          text: "SUBMIT",
                          margin: EdgeInsets.only(
                            left: 15.h,
                            right: 11.h,
                          ),
                          buttonStyle: CustomButtonStyles.outlineBlack,
                          buttonTextStyle:
                              CustomTextStyles.titleSmallPoppinsWhiteA700,
                        ),
                        SizedBox(height: 68.v)
                      ],
                    ),
                  ),
                  SizedBox(height: 9.v)
                ],
              ),
            ),
          ),
        ),
        // bottomNavigationBar: _buildBottomAppBarSea(context),
        // floatingActionButton: CustomFloatingButton(
        //   height: 64,
        //   width: 64,
        //   alignment: Alignment.topCenter,
        //   child:
        //       // CustomImageView(
        //       //   svgPath: ImageConstant.forms,
        //       //   height: 32.0.v,
        //       //   width: 32.0.h,
        //       // ),
        //       Image.asset(
        //     ImageConstant.forms, // path to the asset image
        //     height: 32.0.v,
        //     width: 32.0.h,
        //   ),
        // ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      ),
    );
  }

  /// Section Widget
  Widget _buildNameInput(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(right: 15.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Name",
              style: CustomTextStyles.titleSmallMontserratBlack900,
            ),
            SizedBox(height: 3.v),
            CustomTextFormField(
              width: 160.h,
              controller: nameController,
              hintText: "Your Name",
              hintStyle: theme.textTheme.labelMedium!,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 10.h,
                vertical: 12.v,
              ),
              borderDecoration: TextFormFieldStyleHelper.outlineCyan,
              fillColor: appTheme.whiteA700,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildContactNumberInput(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(left: 15.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Contact Number",
              style: CustomTextStyles.titleSmallMontserratBlack900,
            ),
            SizedBox(height: 4.v),
            CustomTextFormField(
              width: 160.h,
              controller: contactnumbervaController,
              hintText: "+91 00000 00000",
              hintStyle: theme.textTheme.bodySmall!,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 10.h,
                vertical: 12.v,
              ),
            )
          ],
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildRowName(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 10.h,
        right: 16.h,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [_buildNameInput(context), _buildContactNumberInput(context)],
      ),
    );
  }

  /// Section Widget
  Widget _buildEmailAddressInput(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 11.h),
      padding: EdgeInsets.symmetric(horizontal: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Email Address",
            style: CustomTextStyles.titleSmallMontserratBlack900,
          ),
          SizedBox(height: 4.v),
          CustomTextFormField(
            width: 160.h,
            controller: emailController,
            hintText: "Your Email",
            hintStyle: theme.textTheme.bodySmall!,
            textInputType: TextInputType.emailAddress,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 9.h,
              vertical: 12.v,
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildRatingScale(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 10.h,
        right: 16.h,
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 10.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      right: 17.h,
                      bottom: 14.v,
                    ),
                    child: Column(
                      children: [
                        Container(
                          height: 40.adaptSize,
                          width: 40.adaptSize,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                ImageConstant.imgWorst,
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(height: 2.v),
                        Text(
                          "Worst",
                          style: CustomTextStyles.labelLargeCyan900,
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 17.h),
                    child: Column(
                      children: [
                        Container(
                          height: 40.adaptSize,
                          width: 40.adaptSize,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                ImageConstant.imgItSJustFine,
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(height: 2.v),
                        SizedBox(
                          width: 34.h,
                          child: Text(
                            "Not \nGood",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: CustomTextStyles.labelLargeCyan900,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 17.h,
                      right: 17.h,
                      bottom: 15.v,
                    ),
                    child: Column(
                      children: [
                        Container(
                          height: 40.adaptSize,
                          width: 40.adaptSize,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                ImageConstant.imgNeutral,
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(height: 1.v),
                        Text(
                          "Fine",
                          style: CustomTextStyles.labelLargeCyan900,
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 17.h),
                    child: Column(
                      children: [
                        Container(
                          height: 40.adaptSize,
                          width: 40.adaptSize,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                ImageConstant.imgGood,
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(height: 2.v),
                        SizedBox(
                          width: 34.h,
                          child: Text(
                            "Looks\nGood",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: CustomTextStyles.labelLargeCyan900,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 17.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          height: 40.adaptSize,
                          width: 40.adaptSize,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                ImageConstant.imgLoveit,
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(height: 2.v),
                        SizedBox(
                          width: 33.h,
                          child: Text(
                            "Very\nGood",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: CustomTextStyles.labelLargeCyan900,
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 9.v),
          SizedBox(
            height: 28.v,
            width: 350.h,
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 8.v,
                    width: 350.h,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.onError,
                      borderRadius: BorderRadius.circular(
                        4.h,
                      ),
                    ),
                  ),
                ),
                CustomImageView(
                  svgPath: ImageConstant.imgSliderRuler,
                  height: 28.v,
                  width: 57.h,
                  alignment: Alignment.centerLeft,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  // Widget _buildBottomAppBarSea(BuildContext context) {
  //   return SizedBox(
  //     child: SizedBox(
  //       height: 115.v,
  //       width: 409.h,
  //       child: Stack(
  //         alignment: Alignment.topCenter,
  //         children: [
  //           Align(
  //             alignment: Alignment.bottomCenter,
  //             child: Container(
  //               width: 409.h,
  //               margin: EdgeInsets.only(top: 35.v),
  //               padding: EdgeInsets.symmetric(
  //                 horizontal: 13.h,
  //                 vertical: 15.v,
  //               ),
  //               decoration: BoxDecoration(
  //                 image: DecorationImage(
  //                   image: fs.Svg(
  //                     ImageConstant.imgGroup94,
  //                   ),
  //                   fit: BoxFit.cover,
  //                 ),
  //               ),
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.end,
  //                 children: [
  //                   CustomIconButton(
  //                     height: 50.adaptSize,
  //                     width: 50.adaptSize,
  //                     padding_f: EdgeInsets.all(13.h),
  //                     child: CustomImageView(
  //                       svgPath: ImageConstant.imgSearch,
  //                     ),
  //                   ),
  //                   Padding(
  //                     padding: EdgeInsets.only(left: 27.h),
  //                     child: CustomIconButton(
  //                       height: 50.adaptSize,
  //                       width: 50.adaptSize,
  //                       padding_f: EdgeInsets.all(12.h),
  //                       child: CustomImageView(
  //                         svgPath: ImageConstant.imgBxCricketBall,
  //                       ),
  //                     ),
  //                   ),
  //                   Padding(
  //                     padding: EdgeInsets.only(left: 123.h),
  //                     child: CustomIconButton(
  //                       height: 50.adaptSize,
  //                       width: 50.adaptSize,
  //                       padding_f: EdgeInsets.all(12.h),
  //                       child: CustomImageView(
  //                         svgPath: ImageConstant.imgFluentLive24Filled,
  //                       ),
  //                     ),
  //                   ),
  //                   Padding(
  //                     padding: EdgeInsets.only(left: 26.h),
  //                     child: CustomIconButton(
  //                       height: 50.adaptSize,
  //                       width: 50.adaptSize,
  //                       padding_f: EdgeInsets.all(10.h),
  //                       child: CustomImageView(
  //                         svgPath: ImageConstant.imgNotification,
  //                       ),
  //                     ),
  //                   )
  //                 ],
  //               ),
  //             ),
  //           ),
  //           CustomFloatingButton(
  //             height: 64,
  //             width: 64,
  //             alignment: Alignment.topCenter,
  //             child: CustomImageView(
  //               svgPath: ImageConstant.imgLocation,
  //               height: 32.0.v,
  //               width: 32.0.h,
  //             ),
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }

  /// Navigates back to the previous screen.
  onTapBtnArrowleftone(BuildContext context) {
    Navigator.pop(context);
  }
}
