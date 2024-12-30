import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as fs;
import '../../../../../core/utils/image_constant.dart';
import '../../../../../core/utils/size_utils.dart';
import '../../../../../theme/theme_helper.dart';
import '../../../../widgets/custom_drop_down.dart';
import '../../../../widgets/custom_elevated_button.dart';
import '../../../../widgets/custom_floating_button.dart';
import '../../../../widgets/custom_floating_text_field.dart';
import '../../../../widgets/custom_icon_button.dart';
import '../../../../widgets/custom_image_view.dart';

class ProfileEditScreen1 extends StatelessWidget {
  ProfileEditScreen1({Key? key})
      : super(
          key: key,
        );

  TextEditingController fullNameController = TextEditingController();

  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController phoneNumberController = TextEditingController();

  List<String> dropdownItemList = ["India", "Bangladesh", "Pakistan"];

  TextEditingController genderController = TextEditingController();

  TextEditingController addressController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var imgArrowLeftGray90001;
    var imgArrowdropdown;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SizedBox(
            height: SizeUtils.height,
            child: Form(
              key: _formKey,
              child: SizedBox(
                width: double.maxFinite,
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 32.h,
                          vertical: 21.v,
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 30.v),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: 9.v,
                                      bottom: 6.v,
                                    ),
                                    child: CustomIconButton(
                                      height: 32.adaptSize,
                                      width: 32.adaptSize,
                                      // padding: EdgeInsets.all(8.h),
                                      decoration:
                                          IconButtonStyleHelper.outlineIndigo,
                                      onTap: () {
                                        onTapBtnArrowleftone(context);
                                      },
                                      child: CustomImageView(
                                        svgPath:
                                            ImageConstant.imgArrowLeftGray90001,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 18.h),
                                    child: Text(
                                      "Edit  profile",
                                      style: theme.textTheme.headlineLarge,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Spacer(),
                            _buildFullName(context),
                            SizedBox(height: 24.v),
                            _buildName(context),
                            SizedBox(height: 24.v),
                            _buildEmail(context),
                            SizedBox(height: 24.v),
                            _buildPhoneNumber(context),
                            SizedBox(height: 24.v),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 11.h),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.only(right: 8.h),
                                      child: CustomDropDown(
                                        icon: Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 8.h),
                                          child: CustomImageView(
                                            svgPath:
                                                ImageConstant.imgArrowdropdown,
                                            height: 24.adaptSize,
                                            width: 24.adaptSize,
                                          ),
                                        ),
                                        hintText: "Country",
                                        items: dropdownItemList,
                                      ),
                                    ),
                                  ),
                                  _buildGender(context)
                                ],
                              ),
                            ),
                            SizedBox(height: 24.v),
                            _buildAddress(context),
                            SizedBox(height: 24.v),
                            _buildSubmit(context)
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 5.v)
                  ],
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: _buildBottomappbarsea(context),
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
  Widget _buildFullName(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 10.h,
        right: 12.h,
      ),
      child: CustomFloatingTextField(
        controller: fullNameController,
        labelText: "Full name",
        labelStyle: theme.textTheme.bodyMedium!,
        hintText: "Full name",
      ),
    );
  }

  /// Section Widget
  Widget _buildName(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 10.h,
        right: 12.h,
      ),
      child: CustomFloatingTextField(
        controller: nameController,
        labelText: "Nick name",
        labelStyle: theme.textTheme.bodyMedium!,
        hintText: "Nick name",
      ),
    );
  }

  /// Section Widget
  Widget _buildEmail(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 10.h,
        right: 12.h,
      ),
      child: CustomFloatingTextField(
        controller: emailController,
        labelText: "Label",
        labelStyle: theme.textTheme.bodyMedium!,
        hintText: "Label",
      ),
    );
  }

  /// Section Widget
  Widget _buildPhoneNumber(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 10.h,
        right: 12.h,
      ),
      child: CustomFloatingTextField(
        controller: phoneNumberController,
        labelText: "                    Phone number",
        labelStyle: theme.textTheme.bodyMedium!,
        hintText: "                    Phone number",
        textInputType: TextInputType.phone,
      ),
    );
  }

  /// Section Widget
  Widget _buildGender(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(left: 8.h),
        child: CustomFloatingTextField(
          controller: genderController,
          labelText: "Genre",
          labelStyle: theme.textTheme.bodyMedium!,
          hintText: "Genre",
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildAddress(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 10.h,
        right: 12.h,
      ),
      child: CustomFloatingTextField(
        controller: addressController,
        labelText: "Address",
        labelStyle: theme.textTheme.bodyMedium!,
        hintText: "Address",
        textInputAction: TextInputAction.done,
      ),
    );
  }

  /// Section Widget
  Widget _buildSubmit(BuildContext context) {
    return CustomElevatedButton(
      height: 44.v,
      text: "submit".toUpperCase(),
      margin: EdgeInsets.only(
        left: 10.h,
        right: 12.h,
      ),
      // buttonStyle: CustomButtonStyles.fillBlueA,
      // buttonTextStyle: CustomTextStyles.titleMediumRobotoWhiteA700,
    );
  }

  /// Section Widget
  Widget _buildBottomappbarsea(BuildContext context) {
    return SizedBox(
      child: SizedBox(
        height: 115.v,
        width: 409.h,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: 409.h,
                margin: EdgeInsets.only(top: 35.v),
                padding: EdgeInsets.symmetric(
                  horizontal: 13.h,
                  vertical: 15.v,
                ),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: fs.Svg(
                      ImageConstant.imgGroup152,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomIconButton(
                      height: 50.adaptSize,
                      width: 50.adaptSize,
                      // padding: EdgeInsets.all(13.h),
                      child: CustomImageView(
                        svgPath: ImageConstant.imgSearch,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 27.h),
                      child: CustomIconButton(
                        height: 50.adaptSize,
                        width: 50.adaptSize,
                        // padding: EdgeInsets.all(12.h),
                        child: CustomImageView(
                          svgPath: ImageConstant.imgBxCricketBall,
                        ),
                      ),
                    ),
                    Container(
                      width: 126.h,
                      margin: EdgeInsets.only(left: 123.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CustomIconButton(
                            height: 50.adaptSize,
                            width: 50.adaptSize,
                            // padding: EdgeInsets.all(12.h),
                            child: CustomImageView(
                              svgPath: ImageConstant.imgFluentLive24Filled,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 26.h),
                            child: CustomIconButton(
                              height: 50.adaptSize,
                              width: 50.adaptSize,
                              // padding: EdgeInsets.all(10.h),
                              child: CustomImageView(
                                svgPath: ImageConstant.imgNotification,
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            CustomFloatingButton(
              height: 64,
              width: 64,
              alignment: Alignment.topCenter,
              child: CustomImageView(
                svgPath: ImageConstant.imgLocation,
                height: 32.0.v,
                width: 32.0.h,
              ),
            )
          ],
        ),
      ),
    );
  }

  /// Navigates back to the previous screen.
  onTapBtnArrowleftone(BuildContext context) {
    Navigator.pop(context);
  }
}