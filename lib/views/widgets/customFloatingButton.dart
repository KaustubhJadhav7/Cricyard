import 'package:flutter/material.dart';

import '../../Utils/color_constants.dart';
import '../../Utils/image_constant.dart';
import '../../Utils/size_utils.dart';

class customFloatingButton extends StatelessWidget {
  customFloatingButton({
    this.shape,
    this.variant,
    this.alignment,
    this.margin,
    this.onTap,
    this.width,
    this.height,
    this.child,
    this.color,
  });

  final FloatingButtonShape? shape;
  final FloatingButtonVariant? variant;
  final Alignment? alignment;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;
  final double? width;
  final double? height;
  final Widget? child;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: _buildFabWidget(),
          )
        : _buildFabWidget();
  }

  Widget _buildFabWidget() {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: FloatingActionButton(
        backgroundColor: _setColor(),
        onPressed: onTap,
        child: child,
      ),
    );
  }

  BoxDecoration _buildDecoration() {
    return BoxDecoration(
      color: _setColor(),
      borderRadius: _setBorderRadius(),
    );
  }

  Color _setColor() {
    if (color != null) {
      return color!;
    }
    switch (variant) {
      case FloatingButtonVariant.FillBlueA700:
        return Color(0xFF1976D2); // Example color for FillBlueA700
      default:
        return Colors.black;
    }
  }

  BorderRadius _setBorderRadius() {
    switch (shape) {
      case FloatingButtonShape.RoundedBorder6:
        return BorderRadius.circular(
          getHorizontalSize(
            6.00,
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
}

enum FloatingButtonShape {
  RoundedBorder6,
}

enum FloatingButtonVariant {
  FillBlueA700,
}
