import 'custom_image_view.dart';
import 'package:flutter/material.dart';

import '../../Utils/color_constants.dart';
import '../../Utils/image_constant.dart';
import '../../Utils/size_utils.dart';

class CustomBottomBar extends StatefulWidget {
  CustomBottomBar({this.onChanged});

  Function(BottomBarEnum)? onChanged;

  @override
  _CustomBottomBarState createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {
  int selectedIndex = 0;

  List<BottomMenuModel> bottomMenuList = [
    BottomMenuModel(
      icon: ImageConstant.imgFire,
      type: BottomBarEnum.Fire,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgSearchWhiteA70020x20,
      type: BottomBarEnum.Searchwhitea70020x20,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgMenu,
      type: BottomBarEnum.Menu,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgOverflowmenuWhiteA700,
      type: BottomBarEnum.Overflowmenuwhitea700,
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: getMargin(
        left: 16,
        right: 16,
      ),
      decoration: BoxDecoration(
        color: ColorConstant.blueA700,
        borderRadius: BorderRadius.circular(
          getHorizontalSize(
            14,
          ),
        ),
      ),
      child: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        elevation: 0,
        currentIndex: selectedIndex,
        type: BottomNavigationBarType.fixed,
        items: List.generate(bottomMenuList.length, (index) {
          return BottomNavigationBarItem(
            icon: CustomImageView(
              svgPath: bottomMenuList[index].icon,
              height: getSize(
                24,
              ),
              width: getSize(
                24,
              ),
              color: ColorConstant.whiteA700,
            ),
            activeIcon: CustomImageView(
              svgPath: bottomMenuList[index].icon,
              height: getSize(
                24,
              ),
              width: getSize(
                24,
              ),
              color: ColorConstant.whiteA700,
            ),
            label: '',
          );
        }),
        onTap: (index) {
          selectedIndex = index;
          widget.onChanged?.call(bottomMenuList[index].type);
          setState(() {});
        },
      ),
    );
  }
}

enum BottomBarEnum {
  Fire,
  Searchwhitea70020x20,
  Menu,
  Overflowmenuwhitea700,
}

class BottomMenuModel {
  BottomMenuModel({required this.icon, required this.type});

  String icon;

  BottomBarEnum type;
}

class DefaultWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(10),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Please replace the respective Widget here',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
