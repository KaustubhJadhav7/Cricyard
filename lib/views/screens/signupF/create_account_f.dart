import 'package:flutter/material.dart';

import '../../../Utils/image_constant.dart';
import '../../../Utils/size_utils.dart';
import '../../widgets/app_bar/appbar_image.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_textformfield.dart';
import '../Login Screen/view/CustomButton.dart';
import '../sign_up_screen/SignUpService.dart';

class CreateAccountF extends StatefulWidget {
  const CreateAccountF({super.key});

  @override
  State<CreateAccountF> createState() => _CreateAccountFState();
}

class _CreateAccountFState extends State<CreateAccountF> {
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
    _context = context;
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
          padding: const EdgeInsets.all(20.0),
          child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                      padding: getPadding(top: 19),
                      child: const SizedBox(
                        width: double.infinity,
                        child: Text(
                          "Company Name",
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontWeight: FontWeight.w700, color: Colors.black),
                        ),
                      )),
                  CustomTextField(
                    hintText: 'Enter Company Name',
                    onSaved: (value) => formData['companyName'] = value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter  Company Name';
                      }
                      return null;
                    },
                  ),
                  Padding(
                      padding: getPadding(top: 19),
                      child: const SizedBox(
                        width: double.infinity,
                        child: Text(
                          "Email",
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontWeight: FontWeight.w700, color: Colors.black),
                        ),
                      )),
                  CustomTextField(
                    hintText: 'Enter Email',
                    onSaved: (value) => formData['email'] = value,
                    onChanged: _validateEmail,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Email';
                      } else if (!_isEmailValid) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                  Padding(
                      padding: getPadding(top: 19),
                      child: const SizedBox(
                        width: double.infinity,
                        child: Text(
                          "Mobile Number",
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontWeight: FontWeight.w700, color: Colors.black),
                        ),
                      )),
                  CustomTextField(
                    hintText: 'Enter Mobile Number',
                    onSaved: (value) => formData['mobile'] = value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Mob No';
                      }
                      return null;
                    },
                  ),
                  Padding(
                      padding: getPadding(top: 19),
                      child: const SizedBox(
                        width: double.infinity,
                        child: Text(
                          "Workspace",
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontWeight: FontWeight.w700, color: Colors.black),
                        ),
                      )),
                  CustomTextField(
                    onSaved: (value) => formData['workspace'] = value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Workspace';
                      }
                      return null;
                    },
                    hintText: "enter Workspace",
                  ),
                  Padding(
                      padding: getPadding(top: 19),
                      child: const SizedBox(
                        width: double.infinity,
                        child: Text(
                          "GST no.",
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontWeight: FontWeight.w700, color: Colors.black),
                        ),
                      )),
                  CustomTextField(
                    onSaved: (value) => formData['gstNumber'] = value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Gst Number';
                      }
                      return null;
                    },
                    hintText: "enter Gst Number",
                  ),
                  Padding(
                      padding: getPadding(top: 19),
                      child: const SizedBox(
                        width: double.infinity,
                        child: Text(
                          "PAN card ",
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontWeight: FontWeight.w700, color: Colors.black),
                        ),
                      )),
                  CustomTextField(
                    onSaved: (value) => formData['pancard'] = value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Pancard';
                      }
                      return null;
                    },
                    hintText: "enter pancard",
                  ),
                  Padding(
                      padding: getPadding(top: 19),
                      child: const SizedBox(
                        width: double.infinity,
                        child: Text(
                          "Country",
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontWeight: FontWeight.w700, color: Colors.black),
                        ),
                      )),
                  CustomTextField(
                    onSaved: (value) => formData['country'] = value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Country';
                      }
                      return null;
                    },
                    hintText: "enter Country",
                  ),
                  Padding(
                      padding: getPadding(top: 19),
                      child: const SizedBox(
                        width: double.infinity,
                        child: Text(
                          "State/Province",
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontWeight: FontWeight.w700, color: Colors.black),
                        ),
                      )),
                  CustomTextField(
                    onSaved: (value) => formData['state'] = value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter State';
                      }
                      return null;
                    },
                    hintText: "Enter State",
                  ),
                  Padding(
                      padding: getPadding(top: 19),
                      child: const SizedBox(
                        width: double.infinity,
                        child: Text(
                          "City",
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontWeight: FontWeight.w700, color: Colors.black),
                        ),
                      )),
                  CustomTextField(
                    onSaved: (value) => formData['city'] = value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter City';
                      }
                      return null;
                    },
                    hintText: "Enter City",
                  ),
                  Padding(
                      padding: getPadding(top: 19),
                      child: const SizedBox(
                        width: double.infinity,
                        child: Text(
                          "Working ",
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontWeight: FontWeight.w700, color: Colors.black),
                        ),
                      )),
                  CustomTextField(
                    onSaved: (value) => formData['working'] = value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Working';
                      }
                      return null;
                    },
                    hintText: "enter Working",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                    height: 50,
                    width: 400,
                    text: 'Submit',
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
                                  content: Text('Account Creation Failed: $e',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black)),
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
                  )
                ],
              )),
        ),
      ),
    );
  }
}
