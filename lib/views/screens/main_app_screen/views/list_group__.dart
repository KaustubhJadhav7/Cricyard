import 'package:flutter/material.dart';

import '../../../../Utils/size_utils.dart';
import '../../../../theme/app_style.dart';

// ignore: must_be_immutable
class ListtextItemWidget extends StatelessWidget {
  ListtextItemWidget();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Lorem ipsum",
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.left,
              style: AppStyle.txtGilroySemiBold16,
            ),
            Padding(
              padding: getPadding(
                top: 10,
              ),
              child: Text(
                "Lorem ipsum",
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
                style: AppStyle.txtGilroyRegular14,
              ),
            ),
          ],
        ),
        Padding(
          padding: getPadding(
            top: 11,
            bottom: 13,
          ),
          child: Text(
            "7.5",
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.left,
            style: AppStyle.txtGilroySemiBold18,
          ),
        ),
      ],
    );
  }
}