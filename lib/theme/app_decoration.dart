import 'package:cricyard/core/app_export.dart';
import 'package:flutter/material.dart';

import '../Utils/color_constants.dart';
import '../Utils/size_utils.dart';
import 'theme_helper.dart';

class AppDecoration {
  // Gradient decorations
  static BoxDecoration get gradientOnErrorContainerToOnErrorContainer =>
      BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(0.32, 0.2),
          end: Alignment(0.75, 0.83),
          colors: [
            theme.colorScheme.onErrorContainer.withOpacity(0.7),
            theme.colorScheme.onErrorContainer.withOpacity(0.7),
            theme.colorScheme.onErrorContainer.withOpacity(0.7)
          ],
        ),
      );
  static BoxDecoration get fillBlueGray => BoxDecoration(
        color: appTheme.blueGray100,
      );
  static BoxDecoration get fillBlue5001 => BoxDecoration(
        color: ColorConstant.blue5001,
      );
  static BoxDecoration get outlineGray5002 => BoxDecoration(
        color: ColorConstant.gray5002,
        border: Border.all(
          color: ColorConstant.gray5002,
          width: getHorizontalSize(
            1,
          ),
        ),
      );
  static BoxDecoration get outlineBlueA70001 => BoxDecoration(
        border: Border.all(
          color: ColorConstant.blueA70001,
          width: getHorizontalSize(
            1,
          ),
        ),
      );
  static BoxDecoration get outlineGray60026 => BoxDecoration(
        color: ColorConstant.whiteA700,
        boxShadow: [
          BoxShadow(
            color: ColorConstant.gray60026,
            spreadRadius: getHorizontalSize(
              2,
            ),
            blurRadius: getHorizontalSize(
              2,
            ),
            offset: const Offset(
              0,
              2.41,
            ),
          ),
        ],
      );
  static BoxDecoration get txtFillBluegray100 => BoxDecoration(
        color: ColorConstant.blueGray100,
      );
  static BoxDecoration get fillBlueA700 => BoxDecoration(
        color: ColorConstant.blueA700,
      );
  static BoxDecoration get fillBluegray50 => BoxDecoration(
        color: ColorConstant.blueGray50,
      );

  static BoxDecoration get fillBlack => BoxDecoration(
        color: appTheme.black900,
      );
  static BoxDecoration get fillGray => BoxDecoration(
        color: appTheme.gray10001,
      );
  static BoxDecoration get fillGray700 => BoxDecoration(
        color: appTheme.gray700,
      );
  static BoxDecoration get fillLightGreenA => BoxDecoration(
        color: appTheme.lightGreenA200,
      );
  static BoxDecoration get fillOnErrorContainer => BoxDecoration(
        color: theme.colorScheme.onErrorContainer.withOpacity(1),
      );
  static BoxDecoration get fillPrimary => BoxDecoration(
        color: theme.colorScheme.primary,
      );
  static BoxDecoration get outlineBlueA7002 => BoxDecoration(
        color: ColorConstant.whiteA700,
        border: Border.all(
          color: ColorConstant.blueA700,
          width: getHorizontalSize(
            1,
          ),
        ),
      );
  static BoxDecoration get outlineBlueA7001 => BoxDecoration(
        color: ColorConstant.whiteA700,
        border: Border.all(
          color: ColorConstant.blueA700,
          width: getHorizontalSize(
            1,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: ColorConstant.gray60019,
            spreadRadius: getHorizontalSize(
              2,
            ),
            blurRadius: getHorizontalSize(
              2,
            ),
            offset: const Offset(
              0,
              12,
            ),
          ),
        ],
      );
  static BoxDecoration get outlineGray70011 => BoxDecoration(
        color: ColorConstant.whiteA700,
        boxShadow: [
          BoxShadow(
            color: ColorConstant.gray70011,
            spreadRadius: getHorizontalSize(
              2,
            ),
            blurRadius: getHorizontalSize(
              2,
            ),
            offset: const Offset(
              0,
              0,
            ),
          ),
        ],
      );
  static BoxDecoration get outlineGray600191 => const BoxDecoration();
  static BoxDecoration get txtOutlineBlueA700 => BoxDecoration(
        border: Border.all(
          color: ColorConstant.blueA700,
          width: getHorizontalSize(
            1,
          ),
        ),
      );
  static BoxDecoration get outlineBlue50 => BoxDecoration(
        color: ColorConstant.whiteA700,
        border: Border.all(
          color: ColorConstant.blue50,
          width: getHorizontalSize(
            1,
          ),
        ),
      );
  static BoxDecoration get txtFillBlueA700 => BoxDecoration(
        color: ColorConstant.blueA700,
      );
  static BoxDecoration get outlineBlack90019 => BoxDecoration(
        color: ColorConstant.blueA700,
        boxShadow: [
          BoxShadow(
            color: ColorConstant.black90019,
            spreadRadius: getHorizontalSize(
              2,
            ),
            blurRadius: getHorizontalSize(
              2,
            ),
            offset: const Offset(
              0,
              2,
            ),
          ),
        ],
      );
  static BoxDecoration get outlineBluegray100 => BoxDecoration(
        color: ColorConstant.gray50,
        border: Border(
          bottom: BorderSide(
            color: ColorConstant.blueGray100,
            width: getHorizontalSize(
              1,
            ),
          ),
        ),
      );
  static BoxDecoration get fillGray50 => BoxDecoration(
        color: ColorConstant.gray50,
      );
  static BoxDecoration get outlineBluegray10001 => BoxDecoration(
        color: ColorConstant.whiteA700,
        border: Border.all(
          color: ColorConstant.blueGray10001,
          width: getHorizontalSize(
            1,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: ColorConstant.black90033,
            spreadRadius: getHorizontalSize(
              2,
            ),
            blurRadius: getHorizontalSize(
              2,
            ),
            offset: const Offset(
              0,
              1,
            ),
          ),
        ],
      );
  static BoxDecoration get fillBlack900b2 => BoxDecoration(
        color: ColorConstant.black900B2,
      );
  static BoxDecoration get outlineBlack90033 => BoxDecoration(
        border: Border.all(
          color: ColorConstant.black90033,
          width: getHorizontalSize(
            1,
          ),
        ),
      );
  static BoxDecoration get outlineBlack90011 => BoxDecoration(
        color: ColorConstant.whiteA700,
        boxShadow: [
          BoxShadow(
            color: ColorConstant.black90011,
            spreadRadius: getHorizontalSize(
              2,
            ),
            blurRadius: getHorizontalSize(
              2,
            ),
            offset: const Offset(
              0,
              0,
            ),
          ),
        ],
      );
  static BoxDecoration get outlineGray30001 => BoxDecoration(
        border: Border.all(
          color: ColorConstant.gray30001,
          width: getHorizontalSize(
            1,
          ),
        ),
      );
  static BoxDecoration get outlineBlue200 => BoxDecoration(
        border: Border.all(
          color: ColorConstant.blue200,
          width: getHorizontalSize(
            1,
          ),
        ),
      );
  static BoxDecoration get outlineGray60019 => BoxDecoration(
        color: ColorConstant.whiteA700,
        boxShadow: [
          BoxShadow(
            color: ColorConstant.gray60019,
            spreadRadius: getHorizontalSize(
              2,
            ),
            blurRadius: getHorizontalSize(
              2,
            ),
            offset: const Offset(
              0,
              12,
            ),
          ),
        ],
      );
  static BoxDecoration get outlineGray700261 => BoxDecoration(
        color: ColorConstant.whiteA700,
        boxShadow: [
          BoxShadow(
            color: ColorConstant.gray70026,
            spreadRadius: getHorizontalSize(
              2,
            ),
            blurRadius: getHorizontalSize(
              2,
            ),
            offset: const Offset(
              0,
              0,
            ),
          ),
        ],
      );
  static BoxDecoration get fillWhiteA700 => BoxDecoration(
        color: ColorConstant.whiteA700,
      );
  static BoxDecoration get outlineBlueA700 => BoxDecoration(
        color: ColorConstant.gray50,
        border: Border.all(
          color: ColorConstant.blueA700,
          width: getHorizontalSize(
            2,
          ),
          strokeAlign: strokeAlignOutside,
        ),
      );
  static BoxDecoration get fillBlue900 => BoxDecoration(
        color: ColorConstant.blue900,
      );
  static BoxDecoration get outlineBluegray1002 => BoxDecoration(
        color: ColorConstant.whiteA700,
        border: Border(
          top: BorderSide(
            color: ColorConstant.blueGray100,
            width: getHorizontalSize(
              1,
            ),
          ),
          bottom: BorderSide(
            color: ColorConstant.blueGray100,
            width: getHorizontalSize(
              1,
            ),
          ),
        ),
      );
  static BoxDecoration get fillRed100 => BoxDecoration(
        color: ColorConstant.red100,
      );
  static BoxDecoration get outlineBluegray1001 => BoxDecoration(
        color: ColorConstant.whiteA700,
        border: Border.all(
          color: ColorConstant.blueGray100,
          width: getHorizontalSize(
            1,
          ),
        ),
      );
  static BoxDecoration get outlineYellow9003f => BoxDecoration(
        color: ColorConstant.whiteA700,
        border: Border.all(
          color: ColorConstant.yellow9003f,
          width: getHorizontalSize(
            1,
          ),
          strokeAlign: strokeAlignOutside,
        ),
      );
  static BoxDecoration get fillBlue50 => BoxDecoration(
        color: ColorConstant.blue50,
      );
  static BoxDecoration get outlineGray70026 => BoxDecoration(
        color: ColorConstant.whiteA70099,
        boxShadow: [
          BoxShadow(
            color: ColorConstant.gray70026,
            spreadRadius: getHorizontalSize(
              2,
            ),
            blurRadius: getHorizontalSize(
              2,
            ),
            offset: const Offset(
              0,
              0,
            ),
          ),
        ],
      );
  static BoxDecoration get txtOutlineBlack9000c => BoxDecoration(
        color: ColorConstant.gray100,
        border: Border.all(
          color: ColorConstant.black9000c,
          width: getHorizontalSize(
            1,
          ),
        ),
      );
  static BoxDecoration get fillRed700 => BoxDecoration(
        color: ColorConstant.red700,
      );
  static BoxDecoration get fillGray5003 => BoxDecoration(
        color: ColorConstant.gray5003,
      );
  static BoxDecoration get fillGray200 => BoxDecoration(
        color: ColorConstant.gray200,
      );
  static BoxDecoration get outlineBluegray50 => BoxDecoration(
        color: ColorConstant.whiteA700,
        border: Border.all(
          color: ColorConstant.blueGray50,
          width: getHorizontalSize(
            1,
          ),
        ),
      );

  // Outline decorations
  static BoxDecoration get outlineOnPrimaryContainer => BoxDecoration(
        color: appTheme.whiteA700,
        border: Border.all(
          color: theme.colorScheme.onPrimaryContainer,
          width: 1.h,
        ),
      );

  // Outline decorations
  static BoxDecoration get outlineBlack => BoxDecoration();

  // Fill decorations
  static BoxDecoration get fillBlueA => BoxDecoration(
        color: appTheme.blueA200,
      );

  static BoxDecoration get fillGray800 => BoxDecoration(
        color: appTheme.gray800,
      );
  static BoxDecoration get fillOnError => BoxDecoration(
        color: theme.colorScheme.onError,
      );
  static BoxDecoration get fillPink => BoxDecoration(
        color: appTheme.pink400,
      );

  static BoxDecoration get fillPrimary1 => BoxDecoration(
        color: theme.colorScheme.primary.withOpacity(0.05),
      );
  static BoxDecoration get fillPrimary2 => BoxDecoration(
        color: theme.colorScheme.primary.withOpacity(0.1),
      );
  static BoxDecoration get fillWhiteA => BoxDecoration(
        color: appTheme.whiteA700,
      );

  static BoxDecoration get fillYellow => BoxDecoration(
        color: appTheme.yellow600,
      );
// Outline decorations
  static BoxDecoration get outlineGray => BoxDecoration(
        color: appTheme.whiteA700.withOpacity(0.6),
        border: Border.all(
          color: appTheme.gray300,
          width: 1.h,
        ),
      );
  static BoxDecoration get outlineGray300 => BoxDecoration(
        color: appTheme.whiteA700.withOpacity(0.6),
        border: Border(
          bottom: BorderSide(
            color: appTheme.gray300,
            width: 1.h,
          ),
        ),
      );
  static BoxDecoration get outlineGray3001 => BoxDecoration(
        color: appTheme.whiteA700,
        border: Border(
          bottom: BorderSide(
            color: appTheme.gray300,
            width: 1.h,
          ),
        ),
      );
  static BoxDecoration get outlineGray3002 => BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: appTheme.gray300,
            width: 1.h,
          ),
        ),
      );
  static BoxDecoration get outlineGray3003 => BoxDecoration(
        border: Border.all(
          color: appTheme.gray300,
          width: 1.h,
        ),
      );
  static BoxDecoration get outlineGray3004 => BoxDecoration(
        border: Border(
          left: BorderSide(
            color: appTheme.gray300,
            width: 1.h,
          ),
          right: BorderSide(
            color: appTheme.gray300,
            width: 1.h,
          ),
        ),
      );
  static BoxDecoration get outlineGray3005 => BoxDecoration(
        color: appTheme.whiteA700.withOpacity(0.05),
        border: Border.all(
          color: appTheme.gray300,
          width: 1.h,
        ),
      );
  static BoxDecoration get outlineGray3006 => BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: appTheme.gray300,
            width: 1.h,
          ),
        ),
      );
}

class BorderRadiusStyle {
  static BorderRadius customBorderTL50 = BorderRadius.only(
    topLeft: Radius.circular(
      getHorizontalSize(
        50,
      ),
    ),
    bottomLeft: Radius.circular(
      getHorizontalSize(
        50,
      ),
    ),
  );

  static BorderRadius customBorderTL10 = BorderRadius.only(
    topLeft: Radius.circular(
      getHorizontalSize(
        10,
      ),
    ),
    topRight: Radius.circular(
      getHorizontalSize(
        10,
      ),
    ),
  );

  static BorderRadius circleBorder9 = BorderRadius.circular(
    getHorizontalSize(
      9,
    ),
  );

  static BorderRadius circleBorder22 = BorderRadius.circular(
    getHorizontalSize(
      22,
    ),
  );

  static BorderRadius roundedBorder16 = BorderRadius.circular(
    getHorizontalSize(
      16,
    ),
  );

  static BorderRadius circleBorder12 = BorderRadius.circular(
    getHorizontalSize(
      12,
    ),
  );

  static BorderRadius roundedBorder6 = BorderRadius.circular(
    getHorizontalSize(
      6,
    ),
  );

  static BorderRadius circleBorder25 = BorderRadius.circular(
    getHorizontalSize(
      25,
    ),
  );

  static BorderRadius roundedBorder3 = BorderRadius.circular(
    getHorizontalSize(
      3,
    ),
  );

  static BorderRadius circleBorder30 = BorderRadius.circular(
    getHorizontalSize(
      30,
    ),
  );

  static BorderRadius circleBorder76 = BorderRadius.circular(
    getHorizontalSize(
      76,
    ),
  );

  static BorderRadius txtRoundedBorder6 = BorderRadius.circular(
    getHorizontalSize(
      6,
    ),
  );

  static BorderRadius circleBorder61 = BorderRadius.circular(
    getHorizontalSize(
      61,
    ),
  );
  static BorderRadius get roundedBorder8 => BorderRadius.circular(
        8.h,
      );

  // Circle borders
  static BorderRadius get circleBorder24 => BorderRadius.circular(
        24.h,
      );
  static BorderRadius get circleBorder50 => BorderRadius.circular(
        50.h,
      );
// Rounded borders
  static BorderRadius get roundedBorder10 => BorderRadius.circular(
        10.h,
      );
  static BorderRadius get roundedBorder15 => BorderRadius.circular(
        15.h,
      );
  static BorderRadius get roundedBorder19 => BorderRadius.circular(
        19.h,
      );
  static BorderRadius get roundedBorder5 => BorderRadius.circular(
        5.h,
      );

  static BorderRadius get circleBorder20 => BorderRadius.circular(
        20.h,
      );
// Custom borders
  static BorderRadius get customBorderBL12 => BorderRadius.vertical(
        bottom: Radius.circular(12.h),
      );
  static BorderRadius get customBorderTL12 => BorderRadius.vertical(
        top: Radius.circular(12.h),
      );

  static BorderRadius get roundedBorder24 => BorderRadius.circular(
        24.h,
      );
}

// Comment/Uncomment the below code based on your Flutter SDK version.

// For Flutter SDK Version 3.7.2 or greater.

double get strokeAlignInside => BorderSide.strokeAlignInside;

double get strokeAlignCenter => BorderSide.strokeAlignCenter;

double get strokeAlignOutside => BorderSide.strokeAlignOutside;

// For Flutter SDK Version 3.7.1 or less.

// StrokeAlign get strokeAlignInside => StrokeAlign.inside;
//
// StrokeAlign get strokeAlignCenter => StrokeAlign.center;
//
// StrokeAlign get strokeAlignOutside => StrokeAlign.outside;
    