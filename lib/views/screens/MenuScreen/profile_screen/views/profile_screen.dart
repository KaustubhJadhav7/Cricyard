import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:cricyard/core/app_export.dart';
import 'package:cricyard/views/screens/MenuScreen/profile_screen/views/activity.dart';
import 'package:cricyard/views/screens/MenuScreen/profile_screen/views/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../providers/token_manager.dart';
import '../../../../../resources/api_constants.dart';
import '../../../../widgets/custom_floating_button.dart';
import '../../../../widgets/custom_icon_button.dart';
import '../../../LogoutService/Logoutservice.dart';
import '../../../ReuseableWidgets/BottomAppBarWidget.dart';
import '../../../profileManagement/profile_settings_f.dart';
import 'login_three_page.dart';

// ignore: camel_case_types
class Profile_Screen extends StatefulWidget {
  const Profile_Screen({Key? key})
      : super(
          key: key,
        );

  @override
  Profile_ScreenState createState() => Profile_ScreenState();
}
// ignore_for_file: must_be_immutable
class Profile_ScreenState extends State<Profile_Screen>
    with TickerProviderStateMixin {
  late TabController tabviewController;
  Uint8List? _imageBytes;
  Map<String, dynamic> userData = {};
  bool isLoading = false;

  getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userdatastr = prefs.getString('userData');
    if (userdatastr != null) {
      try {
        setState(() {
          userData = json.decode(userdatastr);
        });
        print(userData['token']);
      } catch (e) {
        print("error is ..................$e");
      }
    }
  }
  Future<void> fetchProfileImageData() async {
    setState(() {
      isLoading = true;
    });
    final token = await TokenManager.getToken();
    const String baseUrl = ApiConstants.baseUrl;
    const String apiUrl = '$baseUrl/api/retrieve-image';

    print('Image URL: $apiUrl');
    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 401) {
        LogoutService.logout();
      }
      if (response.statusCode >= 200 && response.statusCode <= 209) {
        String responseData = response.body.replaceAll('"}', ''); // Remove trailing '"}'
        print("Response: $responseData");
        // Find the index of the comma (",") after the prefix
        final commaIndex = responseData.indexOf(',');
        if (commaIndex != -1) {
          final imageData = responseData.substring(commaIndex + 1);
          // Decode base64-encoded image data
          final bytes = base64Decode(imageData);
          setState(() {
            _imageBytes = bytes;
          });
          print('Image data is decoded.');
        } else {
          print('Invalid image data format');
        }
      } else {
        print('Failed to load image data: ${response.statusCode}');
      }
      setState(() {
        isLoading = false;
      });

    } catch (e) {
      print('Error fetching image data: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchProfileImageData();
    getUserData();

    tabviewController = TabController(length: 3, vsync: this);

    // Listener to detect tab changes and navigate when "Activity" is selected
    tabviewController.addListener(() {
      if (tabviewController.indexIsChanging) {
        if (tabviewController.index == 1) {
          // 1 represents the "Activity" tab index
          Future.microtask(() => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ActivityScreen(userData)),
              ));
        }
      }
    });

    // Listener to detect tab changes and navigate when "Activity" is selected
    tabviewController.addListener(() {
      if (tabviewController.indexIsChanging) {
        if (tabviewController.index == 2) {
          // 1 represents the "Activity" tab index
          Future.microtask(
            () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    // ProfileSettingsScreenF(userData: userData),
                    const SettingScreen(),
              ),
            ),
          );
        }
      }
    });
  }

  String capitalize(String text) {
    if (text.isEmpty) return text;
    return text.split(' ').map((word) {
      if (word.isEmpty) return word;
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).join(' ');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          // width: double.maxFinite,
          child: Column(
            children: [
              Column(
                children: [
                  SizedBox(height: 50.v),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 32.h),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              top: 5.v,
                              bottom: 9.v,
                            ),
                            child: CustomIconButton(
                              height: 32.adaptSize,
                              width: 32.adaptSize,
                              // padding: EdgeInsets.all(8.h),
                              decoration: IconButtonStyleHelper.outlineIndigo,
                              onTap: () {
                                onTapBtnArrowleftone(context);
                              },
                              child: CustomImageView(
                                svgPath: ImageConstant.imgArrowleft,
                                height: 32.adaptSize,
                                width: 32.adaptSize,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 18.h),
                            child: Text(
                              "My Profile",
                              style: theme.textTheme.headlineLarge,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 27.v),
                isLoading ? const Center(child: CircularProgressIndicator()):  Stack(
                    children: [
                      CircleAvatar(
                        radius: 100,
                        backgroundImage: _imageBytes != null ? MemoryImage(_imageBytes!) : AssetImage(ImageConstant.editModel) as ImageProvider,
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: CustomIconButton(
                          height: 32.adaptSize,
                          width: 32.adaptSize,
                          alignment: Alignment.centerRight,
                          onTap: () {
                            onTapBtnEdit(context);
                          },
                          padding_f: EdgeInsets.all(8.h),
                          // decoration: IconButtonStyleHelper.fillPrimary,
                          child: CustomImageView(
                            imagePath: ImageConstant.editIcon,
                            height: 28.adaptSize,
                            width: 28.adaptSize,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 161.h),
                    child: CustomIconButton(
                      height: 32.adaptSize,
                      width: 32.adaptSize,
                      // padding: EdgeInsets.all(8.h),

                      alignment: Alignment.centerRight,
                      onTap: () {
                        onTapBtnEdit(context);
                      },
                      padding_f: EdgeInsets.all(8.h),
                      decoration: IconButtonStyleHelper.fillPrimary,
                      child: CustomImageView(
                        svgPath: ImageConstant.imgEdit,
                        height: 28.adaptSize,
                        width: 28.adaptSize,
                        // decoration: IconButtonStyleHelper.outlineIndigo,
                      ),
                    ),
                  ),
                  SizedBox(height: 2.v),
                  Text(
                    'Hello ${capitalize(userData['fullName'] ?? '')}!',
                    overflow: TextOverflow.clip,
                    style: CustomTextStyles.headlineSmallSemiBold,
                  ),
                  SizedBox(height: 17.v),
                  SizedBox(
                    height: 49.v,
                    width: 298.h,
                    child: TabBar(
                      controller: tabviewController,
                      labelPadding: EdgeInsets.zero,
                      labelColor:
                          theme.colorScheme.onErrorContainer.withOpacity(1),
                      labelStyle: TextStyle(
                        fontSize: 14.fSize,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                      unselectedLabelColor: appTheme.black900,
                      unselectedLabelStyle: TextStyle(
                        fontSize: 14.fSize,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicator: BoxDecoration(
                        color: appTheme.gray700,
                        borderRadius: BorderRadius.circular(
                          11.h,
                        ),
                      ),
                      tabs: const [
                        Tab(
                          child: Text(
                            "My Profile",
                          ),
                        ),
                        Tab(
                          child: Text(
                            "Activity",
                          ),
                        ),
                        Tab(
                          child: Text(
                            "Settings",
                          ),
                        )
                      ],
                    ),
                  ),
                  _buildTabbarview(context)
                ],
              ),
              SizedBox(height: 5.v)
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBarWidget(),
        floatingActionButton: CustomFloatingButton(
          height: 64,
          width: 64,
          alignment: Alignment.topCenter,
          child: CustomImageView(
            svgPath: ImageConstant.imgLocation,
            height: 32.0.v,
            width: 32.0.h,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }

  /// Section Widget
  Widget _buildTabbarview(BuildContext context) {
    return SizedBox(
      height: 430.v,
      child: TabBarView(
        controller: tabviewController,
        children: const [LoginThreePage(), LoginThreePage(), LoginThreePage()],
      ),
    );
  }

  /// Navigates back to the previous screen.
  onTapBtnArrowleftone(BuildContext context) {
    Navigator.pop(context);
  }

  /// Navigates to the Edit screen.
  onTapBtnEdit(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProfileSettingsScreenF(userData: userData),
        // SettingScreen(),
      ),
    );
  }

  /// Navigates to the Setting screen.
  onTapBtnSetting(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.setting_screen);
  }
}