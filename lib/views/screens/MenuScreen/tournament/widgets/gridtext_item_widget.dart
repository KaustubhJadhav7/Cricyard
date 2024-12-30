import 'package:cricyard/core/app_export.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/image_constant.dart';
import '../../../../../theme/custom_text_style.dart';
import '../../../../widgets/custom_image_view.dart';

class GridtextItemWidget extends StatelessWidget {
  const GridtextItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomImageView(
          imagePath: ImageConstant.imgPngwing6,
          height: 30.adaptSize,
          width: 30.adaptSize,
        ),
        SizedBox(height: 7.v),
        Text(
          "England",
          style: CustomTextStyles.labelLargeDMSansOnPrimaryContainer,
        )
      ],
    );
  }
}
