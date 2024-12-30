import 'package:flutter/material.dart';

import '../../../Utils/size_utils.dart';
import '../../../theme/app_style.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_messenger.dart';
import '../../widgets/custom_text_form_field.dart';

class ContactUsScreenF extends StatefulWidget {
  const ContactUsScreenF({super.key});

  @override
  State<ContactUsScreenF> createState() => _ContactUsScreenFState();
}

class _ContactUsScreenFState extends State<ContactUsScreenF> {
  final Map<String, dynamic> formData = {};
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
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
                          style: AppStyle.fieldlabel),
                      CustomTextFormField(
                        focusNode: FocusNode(),
                        hintText: "Please Enter Name",
                        onsaved: (value) => formData['name'] = value,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter  Name';
                          }
                          return null;
                        },
                      )
                    ]),
              ),
              Padding(
                padding: getPadding(top: 18),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Email Address",
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: AppStyle.fieldlabel),
                      CustomTextFormField(
                        focusNode: FocusNode(),
                        hintText: "Please Enter Email",
                        onsaved: (value) => formData['email'] = value,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Email';
                          }
                          return null;
                        },
                      )
                    ]),
              ),
              Padding(
                padding: getPadding(top: 18),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Subject",
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: AppStyle.fieldlabel),
                      CustomTextFormField(
                        focusNode: FocusNode(),
                        hintText: "Please Enter Subject",
                        onsaved: (value) => formData['subject'] = value,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Subject';
                          }
                          return null;
                        },
                      )
                    ]),
              ),
              Padding(
                padding: getPadding(top: 18),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Message",
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: AppStyle.fieldlabel),
                      CustomTextFormField(
                        maxLines: 4,
                        focusNode: FocusNode(),
                        hintText: "Please Enter Your Message",
                        onsaved: (value) => formData['message'] = value,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Message';
                          }
                          return null;
                        },
                      )
                    ]),
              ),
              const SizedBox(
                height: 220,
              ),
              CustomButton(
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    ScaffoldMessenger.of(context).showSnackBar(
                        ShowSnackAlert.CustomMessenger(
                            context,
                            Colors.green.shade600,
                            Colors.green.shade900,
                            'You will be Reverted Shortly'));
                    setState(() {
                      _formKey.currentState!.reset();
                    });
                  }
                },
                height: 50,
                text: 'Submit',
              )
            ],
          ),
        ),
      )),
    );
  }
}
