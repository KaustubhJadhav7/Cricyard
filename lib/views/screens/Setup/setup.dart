import 'package:flutter/material.dart';
import '../../../Utils/image_constant.dart';
import '../../../Utils/size_utils.dart';
import '../../widgets/app_bar/appbar_image.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../SysParameters/SystemParameterScreen.dart';

class SetupScreen extends StatelessWidget {
  const SetupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          height: getVerticalSize(49),
          leadingWidth: 40,
          leading: AppbarImage(
              height: getSize(24),
              width: getSize(24),
              svgPath: ImageConstant.imgArrowleftBlueGray900,
              margin: getMargin(left: 16, top: 12, bottom: 13),
              onTap: () {
                Navigator.pop(context);
              }),
          centerTitle: true,
          title: AppbarTitle(text: "Setup Screen")),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildSetupBlock(context, 'User Maintenance', SysParameter()),
              buildSetupBlock(context, 'User Group Maintenance', SysParameter()),
              buildSetupBlock(context, 'Menu Maintenance', SysParameter()),
              buildSetupBlock(context, 'Menu Access', SysParameter()),
              buildSetupBlock(context, 'System Parameter', SysParameter()),
              buildSetupBlock(context, 'Access Type', SysParameter()),
              // buildSetupBlock(context, 'Report', ReportPage()),
              buildSetupBlock(context, 'Dashboard', SysParameter()),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSetupBlock(BuildContext context, String title, Widget screen) {
    return  GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => screen),
        );
      },
      child: Card(
        color: Colors.white,
        elevation: 0.0,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 40, 20, 40),
          child: Column(
            children: [
              // Container(
              //   height: getSize(
              //     55,
              //   ),
              //   width: getSize(
              //     55,
              //   ),
              //   margin: getMargin(
              //     top: 2,
              //   ),
              //   child: Stack(
              //     alignment: Alignment.center,
              //     children: [
              //       Align(
              //         alignment: Alignment.center,
              //         child: Container(
              //           height: getSize(
              //             55,
              //           ),
              //           width: getSize(
              //             55,
              //           ),
              //           child: CircularProgressIndicator(
              //             value: 0.5,
              //             backgroundColor: ColorConstant.gray30099,
              //             color: ColorConstant.blueA700,
              //           ),
              //         ),
              //       ),
              //       Align(
              //         alignment: Alignment.center,
              //         child: Text(
              //           myProjectcount.toString(),
              //           overflow: TextOverflow.ellipsis,
              //           textAlign: TextAlign.left,
              //           style: AppStyle.txtGilroyBold18,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // Text(
              //   myProjectcount.toString(),
              //   style: const TextStyle(
              //     color: Colors.black,
              //     fontSize: 12,
              //   ),
              // ),
              const SizedBox(height: 3,),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


