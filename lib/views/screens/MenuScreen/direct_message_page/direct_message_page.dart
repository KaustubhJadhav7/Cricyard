import 'package:cricyard/core/app_export.dart';
import 'package:flutter/material.dart';

import '../../../../theme/app_decoration.dart';
import '../../../../theme/custom_button_style.dart';
import '../../../../theme/theme_helper.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../../../widgets/custom_image_view.dart';

class DirectMessagePage extends StatelessWidget {
  const DirectMessagePage({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: appTheme.gray100,
        body: Container(
          width: double.maxFinite,
          decoration: AppDecoration.fillGray,
          child: Column(
            children: [
              SizedBox(height: 91.v),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 126.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomImageView(
                      svgPath: ImageConstant.imgVectorBlueA100,
                      height: 161.adaptSize,
                      width: 161.adaptSize,
                    ),
                    SizedBox(height: 91.v),
                    CustomElevatedButton(
                      height: 48.v,
                      text: "Send Message",
                      margin: EdgeInsets.only(left: 6.h),
                      buttonStyle: CustomButtonStyles.none,
                      decoration:
                          CustomButtonStyles.gradientWhiteAToWhiteADecoration,
                      buttonTextStyle: theme.textTheme.bodyLarge!,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
