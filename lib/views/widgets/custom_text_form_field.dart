import 'package:cricyard/core/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../Utils/color_constants.dart';
import '../../Utils/image_constant.dart';
import '../../Utils/size_utils.dart';
import '../../theme/custom_text_style.dart';
import '../../theme/theme_helper.dart';

extension TextFormFieldStyleHelper on CustomTextFormField {
  static OutlineInputBorder get outlineLightGreenA => OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.h),
        borderSide: BorderSide(
          color: appTheme.lightGreenA20001,
          width: 1,
        ),
      );
  static OutlineInputBorder get outlineLimeA => OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.h),
        borderSide: BorderSide(
          color: appTheme.limeA200,
          width: 1,
        ),
      );
  static OutlineInputBorder get outlineYellow => OutlineInputBorder(
        borderRadius: BorderRadius.circular(5.h),
      );
  static OutlineInputBorder get outlineLightGreenATL8 => OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.h),
        borderSide: BorderSide(
          color: appTheme.lightGreenA20001,
          width: 1,
        ),
      );
  static OutlineInputBorder get outlineCyan => OutlineInputBorder(
        borderRadius: BorderRadius.circular(9.h),
        borderSide: BorderSide(
          color: appTheme.cyan900,
          width: 1,
        ),
      );

  static OutlineInputBorder get outlineOnPrimaryContainer => OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.h),
        borderSide: BorderSide(
          color: theme.colorScheme.onPrimaryContainer,
          width: 1,
        ),
      );
  static OutlineInputBorder get outlineOnPrimaryContainerTL8 =>
      OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.h),
        borderSide: BorderSide(
          color: theme.colorScheme.onPrimaryContainer,
          width: 1,
        ),
      );
}

class CustomTextFormField extends StatelessWidget {
  TextFormFieldShape? shape;
  TextFormFieldPadding? padding;
  void Function(String?)? onsaved;
  void Function(String)? onChanged;
  void Function()? onTap;
  String? initialValue;
  bool? readOnly;
  List<TextInputFormatter>? inputFormatters;
  TextFormFieldVariant? variant;
  TextFormFieldFontStyle? fontStyle;
  Alignment? alignment;
  double? width;
  EdgeInsetsGeometry? margin;
  TextEditingController? controller;
  FocusNode? focusNode;
  String? errorText;
  bool? isObscureText;
  TextInputAction? textInputAction;
  TextInputType? textInputType;
  int? maxLines;
  int? maxLength; // Added this line
  String? hintText;
  Widget? prefix;
  BoxConstraints? prefixConstraints;
  Widget? suffix;
  BoxConstraints? suffixConstraints;
  FormFieldValidator<String>? validator;
  TextInputType? keyboardType; // Add this line
  final InputBorder? borderDecoration;
  final TextStyle? hintStyle;
  final EdgeInsets? contentPadding;
  final Color? fillColor;
  final bool? filled;

  CustomTextFormField({
    this.shape,
    this.padding,
    this.initialValue,
    this.variant,
    this.fontStyle,
    this.readOnly,
    this.alignment,
    this.onChanged,
    this.onTap,
    this.width,
    this.margin,
    this.controller,
    this.inputFormatters,
    this.focusNode,
    this.isObscureText = false,
    this.textInputAction = TextInputAction.next,
    this.textInputType,
    this.maxLines,
    this.maxLength, // Added this line
    this.hintText,
    this.prefix,
    this.errorText,
    this.onsaved,
    this.prefixConstraints,
    this.suffix,
    this.suffixConstraints,
    this.validator,
    this.keyboardType, // Add this line
    this.borderDecoration,
    this.hintStyle,
    this.contentPadding,
    this.fillColor,
    this.filled = true,
  });

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: _buildTextFormFieldWidget(),
          )
        : _buildTextFormFieldWidget();
  }

  _buildTextFormFieldWidget() {
    return Container(
      width: width ?? double.maxFinite,
      margin: margin,
      child: TextFormField(
        readOnly: readOnly ?? false,
        onSaved: onsaved,
        onChanged: onChanged,
        controller: controller,
        onTap: onTap,
        focusNode: focusNode,
        style: _setFontStyle(),
        obscureText: isObscureText!,
        textInputAction: textInputAction,
        keyboardType: textInputType,
        maxLines: maxLines ?? 1,
        maxLength: maxLength, // Added this line
        decoration: _buildDecoration(),
        validator: validator,
        initialValue: initialValue,
        inputFormatters: inputFormatters,
      ),
    );
  }

  _buildDecoration() {
    return InputDecoration(
      hintText: hintText ?? "",
      hintStyle: _setFontStyle(),
      border: _setBorderStyle(),
      enabledBorder: _setBorderStyle(),
      focusedBorder: _setBorderStyle(),
      disabledBorder: _setBorderStyle(),
      prefixIcon: prefix,
      errorText: errorText,
      prefixIconConstraints: prefixConstraints,
      suffixIcon: suffix,
      suffixIconConstraints: suffixConstraints,
      fillColor: _setFillColor(),
      filled: _setFilled(),
      isDense: true,
      contentPadding: _setPadding(),
    );
  }

  _setFontStyle() {
    switch (fontStyle) {
      // Existing cases...
      case TextFormFieldFontStyle.RobotoMedium18:
        return TextStyle(
          color: ColorConstant.black900,
          fontSize: getFontSize(18),
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w500,
        );
      default:
        return TextStyle(
          color: Colors.black,
          fontSize: getFontSize(16),
          fontFamily: 'Gilroy',
          fontWeight: FontWeight.w500,
        );
    }
  }

  _setOutlineBorderRadius() {
    switch (shape) {
      // Existing cases...
      default:
        return BorderRadius.circular(getHorizontalSize(6.00));
    }
  }

  _setBorderStyle() {
    switch (variant) {
      // Existing cases...
      default:
        return OutlineInputBorder(
          borderRadius: _setOutlineBorderRadius(),
          borderSide: BorderSide(
            color: ColorConstant.blueGray100,
            width: 1,
          ),
        );
    }
  }

  _setFillColor() {
    switch (variant) {
      // Existing cases...
      default:
        return ColorConstant.whiteA700;
    }
  }

  _setFilled() {
    switch (variant) {
      // Existing cases...
      default:
        return true;
    }
  }

  _setPadding() {
    switch (padding) {
      // Existing cases...
      default:
        return getPadding(all: 11);
    }
  }
}

enum TextFormFieldShape {
  RoundedBorder6,
  CircleBorder16,
}

enum TextFormFieldPadding {
  PaddingAll11,
  PaddingT12,
  PaddingT16,
  PaddingT20,
  PaddingAll8,
  PaddingT6,
  PaddingT25,
}

enum TextFormFieldVariant {
  None,
  OutlineBluegray100,
  FillBlue50,
  OutlineBluegray400,
  OutlineBlack9003f,
  FillBlueA200,
}

enum TextFormFieldFontStyle {
  GilroyMedium16,
  GilroyMedium16BlueA700,
  GilroyMedium16Bluegray400,
  GilroySemiBold14,
  RobotoMedium18,
}
