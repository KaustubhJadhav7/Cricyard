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
import '../viewmodel/Match_Setting_api_service.dart';
import '/providers/token_manager.dart';
import 'package:flutter/services.dart';

class match_settingUpdateEntityScreen extends StatefulWidget {
  final Map<String, dynamic> entity;

  match_settingUpdateEntityScreen({required this.entity});

  @override
  _match_settingUpdateEntityScreenState createState() =>
      _match_settingUpdateEntityScreenState();
}

class _match_settingUpdateEntityScreenState
    extends State<match_settingUpdateEntityScreen> {
  final MatchSettingApiService apiService = MatchSettingApiService();
  final _formKey = GlobalKey<FormState>();

  bool isactive = false;

  bool isdisable_wagon_wheel_for_dot_ball = false;

  bool isdisable_wagon_wheel_for_1s_2s_and_3s = false;

  bool isdisable_shot_selection = false;

  bool iscount_wide_as_a_legal_delivery = false;

  bool iscount_no_ball_as_a_legal_delivery = false;

  @override
  void initState() {
    super.initState();

    isactive = widget.entity['active'] ?? false; // Set initial value

    isdisable_wagon_wheel_for_dot_ball =
        widget.entity['disable_wagon_wheel_for_dot_ball'] ??
            false; // Set initial value

    isdisable_wagon_wheel_for_1s_2s_and_3s =
        widget.entity['disable_wagon_wheel_for_1s_2s_and_3s'] ??
            false; // Set initial value

    isdisable_shot_selection =
        widget.entity['disable_shot_selection'] ?? false; // Set initial value

    iscount_wide_as_a_legal_delivery =
        widget.entity['count_wide_as_a_legal_delivery'] ??
            false; // Set initial value

    iscount_no_ball_as_a_legal_delivery =
        widget.entity['count_no_ball_as_a_legal_delivery'] ??
            false; // Set initial value
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
          title: AppbarTitle(text: "Update Match_Setting")),
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
                              maxLines: 4,

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
                Row(
                  children: [
                    Switch(
                      value: isdisable_wagon_wheel_for_dot_ball,
                      onChanged: (newValue) {
                        setState(() {
                          isdisable_wagon_wheel_for_dot_ball = newValue;
                        });
                      },
                    ),
                    const SizedBox(width: 8),
                    const Text('Disable Wagon wheel for DOT Ball'),
                  ],
                ),
                Row(
                  children: [
                    Switch(
                      value: isdisable_wagon_wheel_for_1s_2s_and_3s,
                      onChanged: (newValue) {
                        setState(() {
                          isdisable_wagon_wheel_for_1s_2s_and_3s = newValue;
                        });
                      },
                    ),
                    const SizedBox(width: 8),
                    const Text('Disable Wagon wheel for 1s 2s and 3s'),
                  ],
                ),
                Row(
                  children: [
                    Switch(
                      value: isdisable_shot_selection,
                      onChanged: (newValue) {
                        setState(() {
                          isdisable_shot_selection = newValue;
                        });
                      },
                    ),
                    const SizedBox(width: 8),
                    const Text('Disable shot selection'),
                  ],
                ),
                Row(
                  children: [
                    Switch(
                      value: iscount_wide_as_a_legal_delivery,
                      onChanged: (newValue) {
                        setState(() {
                          iscount_wide_as_a_legal_delivery = newValue;
                        });
                      },
                    ),
                    const SizedBox(width: 8),
                    const Text('Count wide as a legal delivery'),
                  ],
                ),
                Row(
                  children: [
                    Switch(
                      value: iscount_no_ball_as_a_legal_delivery,
                      onChanged: (newValue) {
                        setState(() {
                          iscount_no_ball_as_a_legal_delivery = newValue;
                        });
                      },
                    ),
                    const SizedBox(width: 8),
                    const Text('Count no Ball as a legal delivery'),
                  ],
                ),
                Padding(
                  padding: getPadding(top: 18),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("For Overs",
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: AppStyle.txtGilroyMedium16Bluegray900),
                        CustomTextFormField(
                            focusNode: FocusNode(),
                            hintText: "Please Enter For Overs",
                            initialValue: widget.entity['for_overs'],

                            // ValidationProperties
                            onsaved: (value) =>
                                widget.entity['for_overs'] = value,
                            margin: getMargin(top: 7))
                      ]),
                ),
                CustomButton(
                  height: getVerticalSize(50),
                  text: "Update",
                  margin: getMargin(top: 24, bottom: 5),
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();

                      widget.entity['active'] = isactive;

                      widget.entity['disable_wagon_wheel_for_dot_ball'] =
                          isdisable_wagon_wheel_for_dot_ball;

                      widget.entity['disable_wagon_wheel_for_1s_2s_and_3s'] =
                          isdisable_wagon_wheel_for_1s_2s_and_3s;

                      widget.entity['disable_shot_selection'] =
                          isdisable_shot_selection;

                      widget.entity['count_wide_as_a_legal_delivery'] =
                          iscount_wide_as_a_legal_delivery;

                      widget.entity['count_no_ball_as_a_legal_delivery'] =
                          iscount_no_ball_as_a_legal_delivery;

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
                                  Text('Failed to update Match_Setting: $e'),
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
