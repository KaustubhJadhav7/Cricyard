// ignore_for_file: use_build_context_synchronously
import 'package:cricyard/Entity/team/Teams/model/Teams_model.dart';
import 'package:cricyard/Entity/team/Teams/viewmodels/Teams_viewmodel.dart';
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

class teamsUpdateEntityScreen extends StatefulWidget {
  final TeamsModel entity;

  teamsUpdateEntityScreen({required this.entity});

  @override
  _teamsUpdateEntityScreenState createState() =>
      _teamsUpdateEntityScreenState();
}

class _teamsUpdateEntityScreenState extends State<teamsUpdateEntityScreen> {
  final _formKey = GlobalKey<FormState>();

  bool isActive = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TeamsProvider>(context, listen: false);
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
          title: AppbarTitle(text: "Update Teams")),
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
                        Text("Team Name",
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: AppStyle.txtGilroyMedium16Bluegray900),
                        CustomTextFormField(
                            focusNode: FocusNode(),
                            hintText: "Please Enter Team Name",
                            initialValue: widget.entity.teamName,

                            // ValidationProperties
                            onsaved: (value) =>
                                widget.entity.teamName = value,
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
                              initialValue: widget.entity.description,
                              maxLines: 5,

                              // ValidationProperties

                              onsaved: (value) {
                                widget.entity.description = value;
                              },
                              margin: getMargin(top: 6))
                        ])),
                SizedBox(height: 16),
                Padding(
                  padding: getPadding(top: 18),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Members",
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: AppStyle.txtGilroyMedium16Bluegray900),
                        CustomTextFormField(
                            focusNode: FocusNode(),
                            hintText: "Please Enter Members",
                            initialValue: widget.entity.members.toString(),

                            // ValidationProperties
                            onsaved: (value) =>
                                widget.entity.members = int.tryParse(value ?? '') ?? 0,
                            margin: getMargin(top: 7))
                      ]),
                ),
                Padding(
                  padding: getPadding(top: 18),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Matches",
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: AppStyle.txtGilroyMedium16Bluegray900),
                        CustomTextFormField(
                            focusNode: FocusNode(),
                            hintText: "Please Enter Matches",
                            initialValue: widget.entity.matches.toString(),

                            // ValidationProperties
                            onsaved: (value) =>
                                widget.entity.matches = int.tryParse(value ?? '') ?? 0,
                            margin: getMargin(top: 7))
                      ]),
                ),
                Row(
                  children: [
                    Switch(
                      value: isActive,
                      onChanged: (newValue) {
                        setState(() {
                          isActive = newValue;
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

                      widget.entity.active = isActive;

                      await provider.updateEntity(
                          widget.entity, isActive, context);

                      Navigator.pop(context);
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
