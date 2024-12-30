import 'package:flutter/material.dart';

import 'package:flutter/services.dart';

import '../../../Utils/image_constant.dart';
import '../../../Utils/size_utils.dart';
import '../../../theme/app_style.dart';
import '../../widgets/app_bar/appbar_image.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_form_field.dart';
import 'SignUpService.dart';

class CreateAccountScreen extends StatefulWidget {
   CreateAccountScreen({Key? key}) : super(key: key);

  @override
  _CreateAccountScreenState createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final SignUpApiService userService = SignUpApiService();

  final Map<String, dynamic> formData = {};
  final _formKey = GlobalKey<FormState>();

  late BuildContext _context; // Store the current context
  late var account_id; // Store the account_id

  bool _isEmailValid = true;
  void _validateEmail(String email) {
    setState(() {
      _isEmailValid =
          RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$').hasMatch(email);
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _context = context; // Store the context

    return Scaffold(
      appBar: CustomAppBar(
          height: getVerticalSize(54),
          leadingWidth: 40,
          leading: AppbarImage(
              height: getSize(24),
              width: getSize(24),
              svgPath: ImageConstant.imgArrowleft,
              margin: getMargin(left: 16, top: 13, bottom: 17),
              onTap: () {
                Navigator.pop(context);
              }),
          centerTitle: true,
          title: AppbarTitle(text: "Create Account")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                    padding: getPadding(top: 19),
                    child: Text("Company Name",
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style:
                        AppStyle.txtGilroyMedium16Bluegray900)),
                CustomTextFormField(
                    focusNode: FocusNode(),
                    onsaved: (value) => formData['companyName'] = value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter  Company Name';
                      }
                      return null;
                    },
                    hintText: "enter  Company Name",
                    margin: getMargin(top: 6),
                    padding: TextFormFieldPadding.PaddingT12,
                    textInputType: TextInputType.text
                ),
                Padding(
                    padding: getPadding(top: 19),
                    child: Text("Email",
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style:
                        AppStyle.txtGilroyMedium16Bluegray900)),
                CustomTextFormField(
                    focusNode: FocusNode(),
                    onsaved: (value) => formData['email'] = value,
                    onChanged: _validateEmail,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Email';
                      }else if(!_isEmailValid){
                         return 'Please enter a valid email';
                      }
                      return null;
                    },
                    hintText: "enter  Email",
                    margin: getMargin(top: 6),
                    padding: TextFormFieldPadding.PaddingT12,
                    textInputType: TextInputType.text
                ),
                Padding(
                    padding: getPadding(top: 19),
                    child: Text("Mobile Number",
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style:
                        AppStyle.txtGilroyMedium16Bluegray900)),
                CustomTextFormField(
                  focusNode: FocusNode(),
                  textInputType: TextInputType.phone,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                  ],
                  onsaved: (value) => formData['mobile'] = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Mob No';
                    }
                    return null;
                  },
                  hintText: "enter Mobile Number",
                  margin: getMargin(top: 6),
                  padding: TextFormFieldPadding.PaddingT12,
                ),
                Padding(
                    padding: getPadding(top: 19),
                    child: Text("Workspace",
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style:
                        AppStyle.txtGilroyMedium16Bluegray900)),
                CustomTextFormField(
                    focusNode: FocusNode(),
                    onsaved: (value) => formData['workspace'] = value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Workspace';
                      }
                      return null;
                    },
                    hintText: "enter Workspace",
                    margin: getMargin(top: 6),
                    padding: TextFormFieldPadding.PaddingT12,
                    textInputType: TextInputType.text
                ),
                Padding(
                    padding: getPadding(top: 19),
                    child: Text("Gst Number",
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style:
                        AppStyle.txtGilroyMedium16Bluegray900)),
                CustomTextFormField(
                    focusNode: FocusNode(),
                    onsaved: (value) => formData['gstNumber'] = value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Gst Number';
                      }
                      return null;
                    },
                    hintText: "enter Gst Number",
                    margin: getMargin(top: 6),
                    padding: TextFormFieldPadding.PaddingT12,
                    textInputType: TextInputType.text
                ),
                Padding(
                    padding: getPadding(top: 19),
                    child: Text("pancard",
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style:
                        AppStyle.txtGilroyMedium16Bluegray900)),
                CustomTextFormField(
                    focusNode: FocusNode(),
                    onsaved: (value) => formData['pancard'] = value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Pancard';
                      }
                      return null;
                    },
                    hintText: "enter pancard",
                    margin: getMargin(top: 6),
                    padding: TextFormFieldPadding.PaddingT12,
                    textInputType: TextInputType.text
                ),
                Padding(
                    padding: getPadding(top: 19),
                    child: Text("Working",
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style:
                        AppStyle.txtGilroyMedium16Bluegray900)),
                CustomTextFormField(
                    focusNode: FocusNode(),
                    onsaved: (value) => formData['working'] = value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Working';
                      }
                      return null;
                    },
                    hintText: "enter Working",
                    margin: getMargin(top: 6),
                    padding: TextFormFieldPadding.PaddingT12,
                    textInputType: TextInputType.text
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 5), // Add margin
                  child: CustomButton(
                    height: getVerticalSize(50),
                    width: getHorizontalSize(396),
                    text: "SUBMIT",
                    margin: getMargin(top: 25),
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        {
                          try {
                            print('form data is $formData');

                            final response =
                            await userService.createAccount(formData);

                            account_id = response['account_id'].toString();
                            print(
                                'after create account account id is $account_id');
                            // ignore: use_build_context_synchronously
                            Navigator.pop(
                                _context, account_id); // Pop with account_id

                            // Navigator.pop(context);
                          } catch (e) {
                            // ignore: use_build_context_synchronously
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Error'),
                                  content: Text('Account Creation Failed: $e'),
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
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
