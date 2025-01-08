// ignore_for_file: use_build_context_synchronously
import '../../../../Utils/image_constant.dart';
import '../../../../Utils/size_utils.dart';
import '../../../../theme/app_style.dart';
import '../../../../views/widgets/app_bar/appbar_image.dart';
import '../../../../views/widgets/app_bar/appbar_title.dart';
import '../../../../views/widgets/app_bar/custom_app_bar.dart';
import '../../../../views/widgets/custom_button.dart';
import '../../../../views/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import '../repository/LIve_Cricket_api_service.dart';
import '/providers/token_manager.dart';

import 'package:flutter/services.dart';

class live_cricketUpdateEntityScreen extends StatefulWidget {
  final Map<String, dynamic> entity;

  live_cricketUpdateEntityScreen({required this.entity});

  @override
  _live_cricketUpdateEntityScreenState createState() =>
      _live_cricketUpdateEntityScreenState();
}

class _live_cricketUpdateEntityScreenState
    extends State<live_cricketUpdateEntityScreen> {
  final LiveCricketApiService apiService = LiveCricketApiService();
  final _formKey = GlobalKey<FormState>();

  bool isactive = false;

  @override
  void initState() {
    super.initState();

    isactive = widget.entity['active'] ?? false; // Set initial value
  }

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
          title: AppbarTitle(text: "Update LIve_Cricket")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: getPadding(top: 18),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Overs",
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: AppStyle.txtGilroyMedium16Bluegray900),
                        CustomTextFormField(
                            focusNode: FocusNode(),
                            hintText: "Please Enter Overs",
                            initialValue: widget.entity['overs'],

                            // ValidationProperties
                            onsaved: (value) => widget.entity['overs'] = value,
                            margin: getMargin(top: 7))
                      ]),
                ),
                Padding(
                  padding: getPadding(top: 18),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Team Run rate",
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: AppStyle.txtGilroyMedium16Bluegray900),
                        CustomTextFormField(
                            focusNode: FocusNode(),
                            hintText: "Please Enter Team Run rate",
                            initialValue: widget.entity['team_run_rate'],

                            // ValidationProperties
                            onsaved: (value) =>
                                widget.entity['team_run_rate'] = value,
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
                        setState(() {
                          isactive = newValue;
                        });
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
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();

                      widget.entity['active'] = isactive;

                      final token = await TokenManager.getToken();
                      try {
                        await apiService.updateEntity(
                            token!,
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
                              content:
                                  Text('Failed to update LIve_Cricket: $e'),
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
