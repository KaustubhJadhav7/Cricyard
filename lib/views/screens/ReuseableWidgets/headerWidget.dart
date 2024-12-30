import 'package:cricyard/core/app_export.dart';
import 'package:flutter/material.dart';
import 'package:cricyard/views/widgets/custom_icon_button.dart';

import '../MenuScreen/Notification/GetAllNotification.dart';

Widget headerWidget(
    BuildContext context, GlobalKey<ScaffoldState> scaffoldKey) {
  return GestureDetector(
    child: Padding(
      padding: EdgeInsets.only(left: 1.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: () {
              scaffoldKey.currentState?.openDrawer();
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: SizedBox(
                  height: 26,
                  child: Image.asset(ImageConstant.imgMainMenu)),
            ),
          ),

          SizedBox(width: 6.h,),
          Expanded(
            flex: 6,
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Image.asset(ImageConstant.imgImageRemovebgPreview,scale: 4,),
            ),
          ),
          const SizedBox(width: 20,),
          SizedBox(
            height: 26,
            child: Image.asset(ImageConstant.imgNotification3)),
          const SizedBox(width: 30,),
          GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => GetAllNotification(),
              ),
            );
          },
          child: SizedBox(
              height: 26,
              child: Image.asset(ImageConstant.imgBell)),
        ),
          const SizedBox(width: 30,),
        ],
      ),
    ),
  );
}
