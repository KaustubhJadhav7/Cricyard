import 'package:cricyard/core/app_export.dart';
import 'package:flutter/material.dart';

class FindfriendslistItemWidget extends StatelessWidget {
  const FindfriendslistItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgImage2,
            height: 40.v,
            width: 41.h,
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 37.h,
              top: 10.v,
              bottom: 2.v,
            ),
            child: Text(
              "Addai",
              style: theme.textTheme.titleMedium,
            ),
          )
        ],
      ),
    );
  }
}
