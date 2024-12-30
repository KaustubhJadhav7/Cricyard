import 'package:flutter/material.dart';

import '../../../../../Utils/size_utils.dart';

// ignore: must_be_immutable
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppBar(
      {required this.height,
      this.leadingWidth,
      this.leading,
      this.title,
      this.bottom,
      this.flexibleSpace,
      this.centerTitle,
      this.actions});

  double height;

  double? leadingWidth;

  Widget? leading;

  Widget? title;

  PreferredSize? flexibleSpace;

  TabBar? bottom;

  bool? centerTitle;

  List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      toolbarHeight: height,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      leadingWidth: leadingWidth ?? 0,
      leading: leading,
      title: title,
      bottom: bottom,
      flexibleSpace: flexibleSpace,
      titleSpacing: 0,
      centerTitle: centerTitle ?? false,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size(
        size.width,
        height,
      );
}
