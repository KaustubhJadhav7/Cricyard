import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../Utils/color_constants.dart';
import '../../Utils/size_utils.dart';
import 'custom_text_form_field.dart';

class CustomDropdownFormField extends StatelessWidget {
  CustomDropdownFormField({
    this.shape,
    this.padding,
    this.initialValue,
    this.variant,
    this.fontStyle,
    this.alignment,
    this.width,
    this.margin,
    this.items,
    this.value,
    this.hintText,
    this.onChanged,
    this.validator,
    this.onSaved,
  });

  TextFormFieldShape? shape;

  TextFormFieldPadding? padding;

  String? initialValue;

  TextFormFieldVariant? variant;

  TextFormFieldFontStyle? fontStyle;

  Alignment? alignment;

  double? width;

  EdgeInsetsGeometry? margin;

  List<DropdownMenuItem<String>>? items;

  String? value;

  String? hintText;

  void Function(String?)? onChanged;

  FormFieldValidator<String>? validator;

  void Function(String?)? onSaved;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: _buildDropdownFormFieldWidget(),
          )
        : _buildDropdownFormFieldWidget();
  }

  _buildDropdownFormFieldWidget() {
    return Container(
      width: width ?? double.maxFinite,
      margin: margin,
      child: DropdownButtonFormField<String>(
        value: value,
        items: items,
        onChanged: onChanged,
        validator: validator,
        onSaved: onSaved,
        decoration: _buildDecoration(),
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
      fillColor: _setFillColor(),
      filled: _setFilled(),
      isDense: true,
      contentPadding: _setPadding(),
    );
  }

  _setFontStyle() {
    switch (fontStyle) {
      // Add cases for different font styles if needed
      default:
        return TextStyle(
          color: ColorConstant.blueGray200,
          fontSize: getFontSize(16),
          fontFamily: 'Gilroy',
          fontWeight: FontWeight.w500,
        );
    }
  }

  _setOutlineBorderRadius() {
    switch (shape) {
      case TextFormFieldShape.CircleBorder16:
        return BorderRadius.circular(getHorizontalSize(16.00));
      default:
        return BorderRadius.circular(getHorizontalSize(6.00));
    }
  }

  _setBorderStyle() {
    switch (variant) {
      case TextFormFieldVariant.FillBlue50:
        return OutlineInputBorder(
          borderRadius: _setOutlineBorderRadius(),
          borderSide: BorderSide.none,
        );
      // Add cases for different variants if needed
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
      case TextFormFieldVariant.FillBlue50:
        return ColorConstant.blue50;
      // Add cases for different variants if needed
      default:
        return ColorConstant.whiteA700;
    }
  }

  _setFilled() {
    switch (variant) {
      case TextFormFieldVariant.FillBlue50:
        return true;
      // Add cases for different variants if needed
      default:
        return true;
    }
  }

  _setPadding() {
    switch (padding) {
      case TextFormFieldPadding.PaddingAll11:
        return getPadding(all: 11);
      // Add cases for different paddings if needed
      default:
        return getPadding(all: 11);
    }
  }
}
