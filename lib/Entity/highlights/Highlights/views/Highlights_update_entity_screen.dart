// ignore_for_file: use_build_context_synchronously
import 'package:cricyard/Entity/highlights/Highlights/model/Highlights_model.dart';
import 'package:cricyard/Entity/highlights/Highlights/viewmodel/Highlights_viewmodel.dart';
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
import 'package:flutter/services.dart';

class highlightsUpdateEntityScreen extends StatefulWidget {
  final Map<String, dynamic> entity;

  highlightsUpdateEntityScreen({required this.entity});

  @override
  _highlightsUpdateEntityScreenState createState() =>
      _highlightsUpdateEntityScreenState();
}

class _highlightsUpdateEntityScreenState
    extends State<highlightsUpdateEntityScreen> {
  final HighlightModel _highlightModel = HighlightModel();

  HighlightModel get highlightModel => _highlightModel;

  bool isactive = false;

  @override
  void initState() {
    super.initState();

    isactive = widget.entity['active'] ?? false; // Set initial value
  }

  @override
  Widget build(BuildContext context) {
    final highlightsProvider =
        Provider.of<HighlightsProvider>(context, listen: false);
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
          title: AppbarTitle(text: "Update Highlights")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: highlightsProvider.formKey,
            child: Column(
              children: [
                Padding(
                  padding: getPadding(top: 18),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Highlight Name",
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: AppStyle.txtGilroyMedium16Bluegray900),
                        CustomTextFormField(
                            focusNode: FocusNode(),
                            hintText: "Please Enter Highlight Name",
                            initialValue: widget.entity['highlight_name'],

                            // ValidationProperties
                            onsaved: (value) =>
                                widget.entity['highlight_name'] = value,
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
                Padding(
                    padding: getPadding(top: 19),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Duration",
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: AppStyle.txtGilroyMedium16Bluegray900),
                          CustomTextFormField(
                              focusNode: FocusNode(),
                              hintText: "Enter Duration",
                              initialValue:
                                  widget.entity['duration'].toString(),
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9]'))
                              ],

                              // ValidationProperties

                              onsaved: (value) {
                                widget.entity['duration'] = value;
                              },
                              margin: getMargin(top: 6))
                        ])),
                SizedBox(height: 16),
                Row(
                  children: [
                    Consumer<HighlightsProvider>(
                      builder: (context, provider, child) {
                        return Switch(
                          value: highlightModel.isActive,
                          onChanged: (newValue) {
                            provider.toggleActive(newValue);
                          },
                        );
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
                    if (highlightsProvider.formKey.currentState!.validate()) {
                      highlightsProvider.formKey.currentState!.save();

                      widget.entity['active'] = isactive;

                      // final token = await TokenManager.getToken();
                      try {
                        await highlightsProvider.updateEntity(
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
                              content: Text('Failed to update Highlights: $e'),
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
