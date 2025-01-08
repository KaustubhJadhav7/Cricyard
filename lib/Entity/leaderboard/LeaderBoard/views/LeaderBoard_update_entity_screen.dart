// ignore_for_file: use_build_context_synchronously
import 'package:cricyard/Entity/leaderboard/LeaderBoard/viewmodel/LeaderBoard_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../../../Utils/image_constant.dart';
import '../../../../Utils/size_utils.dart';
import '../../../../theme/app_style.dart';
import '../../../../views/widgets/app_bar/appbar_image.dart';
import '../../../../views/widgets/app_bar/appbar_title.dart';
import '../../../../views/widgets/app_bar/custom_app_bar.dart';
import '../../../../views/widgets/custom_button.dart';
import '../../../../views/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import '../repository/LeaderBoard_api_service.dart';
import '/providers/token_manager.dart';

class leaderboardUpdateEntityScreen extends StatefulWidget {
  final Map<String, dynamic> entity;

  leaderboardUpdateEntityScreen({required this.entity});

  @override
  _leaderboardUpdateEntityScreenState createState() =>
      _leaderboardUpdateEntityScreenState();
}

class _leaderboardUpdateEntityScreenState
    extends State<leaderboardUpdateEntityScreen> {
  final formKey = GlobalKey<FormState>();

  bool isactive = false;

  @override
  void initState() {
    super.initState();

    isactive = widget.entity['active'] ?? false; // Set initial value
  }

  @override
  Widget build(BuildContext context) {
    final leaderboardProvider =
        Provider.of<LeaderboardProvider>(context, listen: false);
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
          title: AppbarTitle(text: "Update LeaderBoard")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Padding(
                  padding: getPadding(top: 18),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Location",
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: AppStyle.txtGilroyMedium16Bluegray900),
                        CustomTextFormField(
                            focusNode: FocusNode(),
                            hintText: "Please Enter Location",
                            initialValue: widget.entity['location'],

                            // ValidationProperties
                            onsaved: (value) =>
                                widget.entity['location'] = value,
                            margin: getMargin(top: 7))
                      ]),
                ),
                Padding(
                  padding: getPadding(top: 18),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Format",
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: AppStyle.txtGilroyMedium16Bluegray900),
                        CustomTextFormField(
                            focusNode: FocusNode(),
                            hintText: "Please Enter Format",
                            initialValue: widget.entity['format'],

                            // ValidationProperties
                            onsaved: (value) => widget.entity['format'] = value,
                            margin: getMargin(top: 7))
                      ]),
                ),
                Padding(
                  padding: getPadding(top: 18),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Team",
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: AppStyle.txtGilroyMedium16Bluegray900),
                        CustomTextFormField(
                            focusNode: FocusNode(),
                            hintText: "Please Enter Team",
                            initialValue: widget.entity['team'],

                            // ValidationProperties
                            onsaved: (value) => widget.entity['team'] = value,
                            margin: getMargin(top: 7))
                      ]),
                ),
                Padding(
                  padding: getPadding(top: 18),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Tournament",
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: AppStyle.txtGilroyMedium16Bluegray900),
                        CustomTextFormField(
                            focusNode: FocusNode(),
                            hintText: "Please Enter Tournament",
                            initialValue: widget.entity['tournament'],

                            // ValidationProperties
                            onsaved: (value) =>
                                widget.entity['tournament'] = value,
                            margin: getMargin(top: 7))
                      ]),
                ),
                Padding(
                  padding: getPadding(top: 18),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("league",
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: AppStyle.txtGilroyMedium16Bluegray900),
                        CustomTextFormField(
                            focusNode: FocusNode(),
                            hintText: "Please Enter league",
                            initialValue: widget.entity['league'],

                            // ValidationProperties
                            onsaved: (value) => widget.entity['league'] = value,
                            margin: getMargin(top: 7))
                      ]),
                ),
                Padding(
                  padding: getPadding(top: 18),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Name",
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: AppStyle.txtGilroyMedium16Bluegray900),
                        CustomTextFormField(
                            focusNode: FocusNode(),
                            hintText: "Please Enter Name",
                            initialValue: widget.entity['name'],

                            // ValidationProperties
                            onsaved: (value) => widget.entity['name'] = value,
                            margin: getMargin(top: 7))
                      ]),
                ),
                Padding(
                    padding: getPadding(top: 19),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Description",
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: AppStyle.txtGilroyMedium16Bluegray900),
                          CustomTextFormField(
                              focusNode: FocusNode(),
                              hintText: "Enter Description",
                              initialValue: widget.entity['description'],
                              maxLines: 5,

                              // ValidationProperties

                              onsaved: (value) {
                                widget.entity['description'] = value;
                              },
                              margin: getMargin(top: 6))
                        ])),
                SizedBox(height: 16),
                Row(
                  children: [
                    Switch(
                      value: isactive,
                      onChanged: (newValue) {
                        leaderboardProvider.toggleActive(newValue);
                      },
                    ),
                    const SizedBox(width: 8),
                    const Text('Active'),
                  ],
                ),
                CustomButton(
                  height: getVerticalSize(50),
                  text: "Update",
                  margin: getMargin(top: 24, bottom: 5),
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();

                      widget.entity['active'] = isactive;

                      try {
                        await leaderboardProvider.updateEntity(
                            widget.entity[
                                'id'], // Assuming 'id' is the key in your entity map
                            widget.entity);

                        Navigator.pop(context);
                      } catch (e) {
                        // ignore: use_build_context_synchronously
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Error'),
                              content: Text('Failed to update LeaderBoard: $e'),
                              actions: [
                                TextButton(
                                  child: const Text('OK'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
