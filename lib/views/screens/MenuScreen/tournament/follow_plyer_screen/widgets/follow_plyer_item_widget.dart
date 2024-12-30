import 'package:cricyard/core/app_export.dart';
import 'package:flutter/material.dart';

import '../../../../../../theme/app_decoration.dart';

class FollowPlyerItemWidget extends StatelessWidget {
  const FollowPlyerItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 15.h,
        vertical: 14.v,
      ),
      decoration: AppDecoration.outlineGray3005.copyWith(
        borderRadius: BorderRadiusStyle.circleBorder12,
      ),
      width: 97.h,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "3 ".toUpperCase(),
                  style: theme.textTheme.titleMedium,
                ),
                TextSpan(
                  text: "12".toUpperCase(),
                  style: theme.textTheme.labelMedium,
                )
              ],
            ),
            textAlign: TextAlign.left,
          ),
          SizedBox(height: 5.v),
          Opacity(
            opacity: 0.5,
            child: Text(
              "vs SL, ODI",
              style: CustomTextStyles.labelLargeSFProTextPrimaryMedium,
            ),
          )
        ],
      ),
    );
  }
}
