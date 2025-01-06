// ignore_for_file: use_build_context_synchronously
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
import '../repository/FeedBack_Form_api_service.dart';
import '../viewmodel/FeedBack_Form_viewmodel.dart';

import 'package:flutter/services.dart';

class feedback_formUpdateEntityScreen extends StatefulWidget {
  final Map<String, dynamic> entity;

  feedback_formUpdateEntityScreen({required this.entity});

  @override
  _feedback_formUpdateEntityScreenState createState() =>
      _feedback_formUpdateEntityScreenState();
}

class _feedback_formUpdateEntityScreenState
    extends State<feedback_formUpdateEntityScreen> {
  final FeedbackFormApiService apiService = FeedbackFormApiService();
  // final _formKey = GlobalKey<FormState>();

  // bool _isemail_fieldEmailValid = true;

  // void _validateemail_fieldEmail(String email) {
  //   setState(() {
  //     _isemail_fieldEmailValid =
  //         RegExp(r'^[\\w-]+(\\.[\\w-]+)*@[\\w-]+(\\.[\\w-]+)+$')
  //             .hasMatch(email);
  //   });
  // }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final feedbackProvider =
        Provider.of<FeedbackProvider>(context, listen: false);
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
          title: AppbarTitle(text: "Update FeedBack_Form")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: feedbackProvider.formKey,
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
                          Text("Phone Number",
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: AppStyle.txtGilroyMedium16Bluegray900),
                          CustomTextFormField(
                              focusNode: FocusNode(),
                              hintText: "Enter Phone Number",
                              initialValue: widget.entity['phone_number'],
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              keyboardType: TextInputType.number,
                              maxLength: 10,

                              // ValidationProperties

                              onsaved: (value) {
                                widget.entity['phone_number'] = value;
                              },
                              margin: getMargin(top: 6))
                        ])),
                const SizedBox(height: 16),
                Padding(
                    padding: getPadding(top: 19),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Email Field",
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: AppStyle.txtGilroyMedium16Bluegray900),
                          CustomTextFormField(
                              focusNode: FocusNode(),
                              hintText: "Enter Email Field",
                              initialValue: widget.entity['email_field'],
                              keyboardType: TextInputType.emailAddress,
                              errorText: feedbackProvider.isEmailFieldEmailValid
                                  ? null
                                  : 'Please enter a valid email',
                              onChanged:
                                  feedbackProvider.validateEmailFieldEmail,

                              // ValidationProperties

                              onsaved: (value) {
                                widget.entity['email_field'] = value;
                              },
                              margin: getMargin(top: 6))
                        ])),
                const SizedBox(height: 16),
                Padding(
                    padding: getPadding(top: 19),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Share Your Experience",
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: AppStyle.txtGilroyMedium16Bluegray900),
                          CustomTextFormField(
                              focusNode: FocusNode(),
                              hintText: "Enter Share Your Experience",
                              initialValue:
                                  widget.entity['share_your_experience'],
                              maxLines: 5,

                              // ValidationProperties

                              onsaved: (value) {
                                widget.entity['share_your_experience'] = value;
                              },
                              margin: getMargin(top: 6))
                        ])),
                SizedBox(height: 16),
                CustomButton(
                  height: getVerticalSize(50),
                  text: "Update",
                  margin: getMargin(top: 24, bottom: 5),
                  onTap: () async {
                    if (feedbackProvider.formKey.currentState!.validate()) {
                      feedbackProvider.formKey.currentState!.save();

                      // final token = await TokenManager.getToken();
                      try {
                        await apiService.updateEntity(
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
                                  Text('Failed to update FeedBack_Form: $e'),
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
