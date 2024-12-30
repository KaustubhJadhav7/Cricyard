import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Utils/image_constant.dart';
import '../../../Utils/size_utils.dart';
import '../../../providers/token_manager.dart';
import '../../../resources/api_constants.dart';
import 'package:http/http.dart' as http;

import '../../../theme/app_style.dart';
import '../../widgets/app_bar/appbar_image.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/custom_app_bar.dart';

import '../../widgets/custom_text_form_field.dart';
import '../Login Screen/view/CustomButton.dart';
import '../Login Screen/view/login_screen_f.dart';
import '../LogoutService/Logoutservice.dart';

class ResetPasswordScreenF extends StatefulWidget {
  ResetPasswordScreenF( {super.key});
  @override
  _ResetPasswordScreenFState createState() => _ResetPasswordScreenFState();
}

class _ResetPasswordScreenFState extends State<ResetPasswordScreenF> {
  Map<String, dynamic> userData = {};

  @override
  void initState() {
    super.initState();
    getUserData();
    print('user data is ..$userData');
  }

  getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userdatastr = prefs.getString('userData');
    if (userdatastr != null) {
      try {
        setState(() {
          userData = json.decode(userdatastr);
        });
      } catch (e) {
        print("error is ..................$e");
      }
    }
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
          title: AppbarTitle(text: "Reset Your Password")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text("You're signed in as -   ${userData['email']}",
                style: AppStyle.txtGilroyMedium16Bluegray800),
            const SizedBox(height: 20),
            ResetPasswordFormF(
                userData: userData, userEmail: userData['email']),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class ResetPasswordFormF extends StatefulWidget {
  final String userEmail;

  final Map<String, dynamic> userData;

  const ResetPasswordFormF(
      {super.key, required this.userEmail, required this.userData});

  @override
  _ResetPasswordFormFState createState() => _ResetPasswordFormFState();
}

class _ResetPasswordFormFState extends State<ResetPasswordFormF> {
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController reEnterNewPasswordController =
      TextEditingController();

  var responseMessage;
  var isVisible = false;
  bool issuccess = false;

  bool isOldPasswordVisible = false;
  bool isNewPasswordVisible = false;
  bool isReEnterNewPasswordVisible = false;

  bool _isPasswordValid1 = true;
  void _validatePassword1(String password) {
    setState(() {
      _isPasswordValid1 = password.isNotEmpty;
    });
  }

  bool _isPasswordValid2 = true;
  void _validatePassword2(String password) {
    setState(() {
      _isPasswordValid2 = password.isNotEmpty;
    });
  }

  bool _isPasswordValid3 = true;
  void _validatePassword3(String password) {
    setState(() {
      _isPasswordValid3 =
          password.isNotEmpty && password == newPasswordController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        isVisible
            ? Text(responseMessage,
                style: TextStyle(
                  color: issuccess
                      ? Colors.green
                      : Colors.red, // Set the text color to red
                ))
            : const Text(''),
        Padding(
            padding: getPadding(top: 19),
            child: const Text("Enter Old Password",
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w700))),
        CustomTextFormField(
            focusNode: FocusNode(),
            controller: oldPasswordController,
            hintText: "Enter Old Password",
            onChanged: _validatePassword1,
            validator: (value) {
              if (value!.isEmpty && _isPasswordValid1) {
                return 'Please enter your old password';
              }
              return null; // Return null to indicate no error
            },
            textInputType: TextInputType.visiblePassword,
            suffix: IconButton(
              icon: Icon(
                isOldPasswordVisible ? Icons.visibility : Icons.visibility_off,
              ),
              onPressed: () {
                setState(() {
                  isOldPasswordVisible = !isOldPasswordVisible;
                });
              },
            ),
            isObscureText: !isOldPasswordVisible),
        Padding(
            padding: getPadding(top: 19),
            child: const Text("Enter New Password",
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w700))),
        CustomTextFormField(
          focusNode: FocusNode(),
          controller: newPasswordController,
          hintText: "Enter New Password",
          suffix: IconButton(
            icon: Icon(
              isNewPasswordVisible ? Icons.visibility : Icons.visibility_off,
            ),
            onPressed: () {
              setState(() {
                isNewPasswordVisible = !isNewPasswordVisible;
              });
            },
          ),
          onChanged: _validatePassword2,
          validator: (value) {
            if (value!.isEmpty && _isPasswordValid2) {
              return 'Please enter your new password';
            }
            return null;
          },
          isObscureText: !isNewPasswordVisible,
        ),
        Padding(
            padding: getPadding(top: 19),
            child: const Text("Re-Enter New Password",
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w700))),
        CustomTextFormField(
          focusNode: FocusNode(),
          controller: reEnterNewPasswordController,
          hintText: "Re-Enter New Password",
          onChanged: _validatePassword3,
          validator: (value) {
            if (value!.isEmpty && _isPasswordValid3) {
              return 'Please re-enter your new password';
            }
            if (value != newPasswordController.text) {
              return 'Passwords do not match';
            }
            return null;
          },
          isObscureText: !isReEnterNewPasswordVisible,
        ),
        const SizedBox(
          height: 280,
        ),
        CustomButton(
          height: getVerticalSize(50),
          text: "Continue",
          onTap: () async {
            if (oldPasswordController.text.isEmpty ||
                newPasswordController.text.isEmpty ||
                reEnterNewPasswordController.text.isEmpty) {
              print(oldPasswordController.text);
              print(newPasswordController.text);
              print(reEnterNewPasswordController.text);
            } else {
              Map<String, dynamic> passwordData = {
                "userId": widget.userData['userId'],
                "oldPassword": oldPasswordController.text,
                "newPassword": newPasswordController.text,
                "confirmPassword": reEnterNewPasswordController.text,
              };
              print(passwordData);
              final token = await TokenManager.getToken();
              const String baseUrl = ApiConstants.baseUrl;
              const String apiUrl = '$baseUrl/api/reset_password';

              try {
                final response = await http.post(Uri.parse(apiUrl),
                    headers: {
                      'Authorization': 'Bearer $token',
                      'Content-Type': 'application/json',
                    },
                    body: json.encode(passwordData));
                if (response.statusCode == 401) {
                  LogoutService.logout();
                }
                if (response.statusCode <= 209) {
                  setState(() {
                    isVisible = true;
                    issuccess = true;
                    responseMessage = "Password Changes Successfully";
                  });
                  print("success");
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreenF(false)),
                    (route) => false,
                  );
                } else {
                  setState(() {
                    isVisible = true;
                    responseMessage = "Incorrect Password";
                  });
                  print(response.statusCode);
                }
              } catch (e) {
                throw Exception('Failed to Update: $e');
              }
            }
          },
        ),
      ],
    );
  }

  @override
  void dispose() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    reEnterNewPasswordController.dispose();
    super.dispose();
  }
}
