// ignore_for_file: constant_identifier_names

import 'package:cricyard/core/app_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

import '../../Utils/color_constants.dart';
import '../../Utils/image_constant.dart';
import '../../Utils/size_utils.dart';
import '../../theme/theme_helper.dart';

extension IconButtonStyleHelper on CustomIconButton {
  static BoxDecoration get fillErrorContainer => BoxDecoration(
        color: theme.colorScheme.errorContainer,
      );

  static BoxDecoration get fillDeepOrangeA => BoxDecoration(
        color: appTheme.deepOrangeA400,
        borderRadius: BorderRadius.circular(26.h),
      );
  static BoxDecoration get fillLightBlue => BoxDecoration(
        color: appTheme.lightBlue900,
        borderRadius: BorderRadius.circular(4.h),
      );
  static BoxDecoration get fillBlue => BoxDecoration(
        color: appTheme.blue400,
        borderRadius: BorderRadius.circular(25.h),
      );
  static BoxDecoration get outlineIndigoTL12 => BoxDecoration(
        color: appTheme.lightGreenA200,
        borderRadius: BorderRadius.circular(12.h),
        border: Border.all(
          color: appTheme.indigo50,
          width: 1.h,
        ),
      );

  static BoxDecoration get fillPrimaryContainer => BoxDecoration(
        color: theme.colorScheme.primaryContainer,
      );
  static BoxDecoration get fillPrimary => BoxDecoration(
        color: theme.colorScheme.primary,
        borderRadius: BorderRadius.circular(16.h),
      );
  static BoxDecoration get outlineIndigo => BoxDecoration(
        color: appTheme.lightGreenA200,
        borderRadius: BorderRadius.circular(12.h),
        border: Border.all(
          color: appTheme.indigo50,
          width: 1.h,
        ),
      );

  static BoxDecoration get fillBlueA => BoxDecoration(
        color: appTheme.blueA20002,
      );

  static BoxDecoration get gradientLightGreenAToLightGreenA => BoxDecoration(
        borderRadius: BorderRadius.circular(32.h),
        gradient: LinearGradient(
          begin: Alignment(0.5, 0),
          end: Alignment(0.5, 1),
          colors: [appTheme.lightGreenA20001, appTheme.lightGreenA20000],
        ),
      );
}

class CustomIconButton extends StatelessWidget {
  final EdgeInsetsGeometry? padding;

  CustomIconButton({
    this.shape,
    this.padding,
    this.variant,
    this.alignment,
    this.margin,
    this.width,
    this.height,
    this.child,
    this.onTap,
    this.decoration,
    this.padding_f,
  });

  // file===green color for all boottom bar
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        padding: padding ?? EdgeInsets.zero,
        decoration: decoration ??
            BoxDecoration(
              color: Color.fromRGBO(253, 202, 101, 1.0),
              borderRadius: BorderRadius.circular(
                // Set borderRadius to half of the smallest dimension
                width! < height! ? width! / 2 : height! / 2,
              ), // Adjust as needed
            ),
        child: Center(child: child), // Ensure child is centered
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return GestureDetector(
  //     onTap: onTap,
  //     child: Container(
  //       height: height,
  //       width: width,
  //       padding: padding ?? EdgeInsets.zero,
  //       decoration: decoration ??
  //           BoxDecoration(
  //             color: Colors.blue,
  //             borderRadius: BorderRadius.circular(16), // Adjust as needed
  //           ),
  //       child: Center(child: child), // Ensure child is centered
  //     ),
  //   );
  // }

  IconButtonShape? shape;

  // IconButtonPadding? padding;

  IconButtonVariant? variant;

  Alignment? alignment;

  EdgeInsetsGeometry? margin;

  double? width;

  double? height;

  Widget? child;

  VoidCallback? onTap;

  final BoxDecoration? decoration;
  final EdgeInsetsGeometry? padding_f;

  // @override
  // Widget build(BuildContext context) {
  //   return alignment != null
  //       ? Align(
  //           alignment: alignment ?? Alignment.center,
  //           child: _buildIconButtonWidget(),
  //         )
  //       : _buildIconButtonWidget();
  // }

  Widget get iconButtonWidget => SizedBox(
        height: height ?? 0,
        width: width ?? 0,
        child: IconButton(
          padding: EdgeInsets.zero,
          icon: Container(
            height: height ?? 0,
            width: width ?? 0,
            padding: padding_f ?? EdgeInsets.zero,
            decoration: decoration ??
                BoxDecoration(
                  color: appTheme.lightGreenA200,
                  borderRadius: BorderRadius.circular(25.h),
                ),
            child: child,
          ),
          onPressed: onTap,
        ),
      );

  _buildIconButtonWidget() {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: IconButton(
        visualDensity: const VisualDensity(
          vertical: -4,
          horizontal: -4,
        ),
        iconSize: getSize(height ?? 0),
        padding: const EdgeInsets.all(0),
        icon: Container(
          alignment: Alignment.center,
          width: getSize(width ?? 0),
          height: getSize(height ?? 0),
          padding: _setPadding(),
          decoration: _buildDecoration(),
          child: child,
        ),
        onPressed: onTap,
      ),
    );
  }

  _buildDecoration() {
    return BoxDecoration(
      color: _setColor(),
      border: _setBorder(),
      borderRadius: _setBorderRadius(),
      boxShadow: _setBoxShadow(),
    );
  }

  _setPadding() {
    switch (padding) {
      case IconButtonPadding.PaddingAll4:
        return getPadding(
          all: 4,
        );
      case IconButtonPadding.PaddingAll16:
        return getPadding(
          all: 16,
        );
      case IconButtonPadding.PaddingAll8:
        return getPadding(
          all: 8,
        );
      default:
        return getPadding(
          all: 11,
        );
    }
  }

  _setColor() {
    switch (variant) {
      case IconButtonVariant.FillBlueA700:
        return ColorConstant.blueA700;
      case IconButtonVariant.OutlineGray80049:
        return ColorConstant.whiteA700;
      case IconButtonVariant.FillGray300:
        return ColorConstant.gray300;
      case IconButtonVariant.FillGray100:
        return ColorConstant.gray100;
      case IconButtonVariant.FillBlack90001:
        return ColorConstant.black90001;
      case IconButtonVariant.OutlineBluegray400:
        return ColorConstant.whiteA700;
      case IconButtonVariant.FillBlueA200:
        return ColorConstant.blueA200;
      case IconButtonVariant.OutlineBlueA700:
      case IconButtonVariant.OutlineBlue50:
        return null;
      default:
        return ColorConstant.blue50;
    }
  }

  _setBorder() {
    switch (variant) {
      case IconButtonVariant.OutlineBlueA700:
        return Border.all(
          color: ColorConstant.blueA700,
          width: getHorizontalSize(
            1.00,
          ),
        );
      case IconButtonVariant.OutlineGray80049:
        return Border.all(
          color: ColorConstant.gray80049,
          width: getHorizontalSize(
            1.00,
          ),
        );
      case IconButtonVariant.OutlineBlue50:
        return Border.all(
          color: ColorConstant.blue50,
          width: getHorizontalSize(
            1.00,
          ),
        );
      case IconButtonVariant.OutlineBluegray400:
        return Border.all(
          color: ColorConstant.blueGray400,
          width: getHorizontalSize(
            1.00,
          ),
        );
      case IconButtonVariant.FillBlue50:
      case IconButtonVariant.FillBlueA700:
      case IconButtonVariant.FillGray300:
      case IconButtonVariant.FillGray100:
      case IconButtonVariant.FillBlack90001:
      case IconButtonVariant.FillBlueA200:
        return null;
      default:
        return null;
    }
  }

  _setBorderRadius() {
    switch (shape) {
      case IconButtonShape.CircleBorder15:
        return BorderRadius.circular(
          getHorizontalSize(
            15.00,
          ),
        );
      case IconButtonShape.RoundedBorder26:
        return BorderRadius.circular(
          getHorizontalSize(
            26.00,
          ),
        );
      case IconButtonShape.CircleBorder10:
        return BorderRadius.circular(
          getHorizontalSize(
            10.00,
          ),
        );
      case IconButtonShape.CircleBorder30:
        return BorderRadius.circular(
          getHorizontalSize(
            30.00,
          ),
        );
      default:
        return BorderRadius.circular(
          getHorizontalSize(
            6.00,
          ),
        );
    }
  }

  _setBoxShadow() {
    switch (variant) {
      case IconButtonVariant.OutlineBlueA700:
        return [
          BoxShadow(
            color: ColorConstant.indigoA20033,
            spreadRadius: getHorizontalSize(
              2.00,
            ),
            blurRadius: getHorizontalSize(
              2.00,
            ),
            offset: const Offset(
              0,
              4,
            ),
          ),
        ];
      case IconButtonVariant.FillBlue50:
      case IconButtonVariant.FillBlueA700:
      case IconButtonVariant.OutlineGray80049:
      case IconButtonVariant.FillGray300:
      case IconButtonVariant.FillGray100:
      case IconButtonVariant.FillBlack90001:
      case IconButtonVariant.OutlineBlue50:
      case IconButtonVariant.OutlineBluegray400:
      case IconButtonVariant.FillBlueA200:
        return null;
      default:
        return null;
    }
  }
}

enum IconButtonShape {
  RoundedBorder6,
  CircleBorder15,
  RoundedBorder26,
  CircleBorder10,
  CircleBorder30,
}

enum IconButtonPadding {
  PaddingAll4,
  PaddingAll16,
  PaddingAll8,
  PaddingAll11,
}

enum IconButtonVariant {
  FillBlue50,
  FillBlueA700,
  OutlineBlueA700,
  OutlineGray80049,
  FillGray300,
  FillGray100,
  FillBlack90001,
  OutlineBlue50,
  OutlineBluegray400,
  FillBlueA200,
}
