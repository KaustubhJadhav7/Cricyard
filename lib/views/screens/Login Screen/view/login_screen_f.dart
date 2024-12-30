// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:cricyard/core/app_export.dart';
import 'package:cricyard/views/screens/MenuScreen/new_dash/Newdashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../Utils/color_constants.dart';
import '../../../../providers/token_manager.dart';
import '../../../../utilities/make_api_request.dart';
import '../../../widgets/custom_messenger.dart';
import '../../forgot_password/forgot_password_f.dart';
import '../../signupF/SignupScreenF.dart';
import 'CustomButton.dart';

class LoginScreenF extends StatefulWidget {
  const LoginScreenF(isLogin, {super.key});
  final bool isLogin = false;

  @override
  State<LoginScreenF> createState() => _LoginScreenFState();
}

class _LoginScreenFState extends State<LoginScreenF> {
  final _formKey = GlobalKey<FormState>();
  String errorMessage1 = "";
  String errorMessage2 = "";
  String userInput = "";
  String password = "";
  bool isPasswordVisible = false;
  bool stayLoggedIn = true;
  bool isLoggingIn = false;

  Map<String, dynamic> userData = {};

  getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userdatastr = prefs.getString('userData');
    if (userdatastr != null) {
      try {
        setState(() {
          userData = json.decode(userdatastr);
        });
        print(userData['token']);
      } catch (e) {
        print("error is ..................$e");
      }
    }
  }

  void initState() {
    // TODO: implement initState
    getUserData();
  }

  Future<bool> _saveLoggedInUserData(
      String loggedInUserAuthKey, Map<String, dynamic> user) async {
    try {
      var userId = user['userId'].toString();
      var firstName = user['firstName'].toString();

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('userData', json.encode(user));
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('token', loggedInUserAuthKey);

      print('userId ....$userId');
      print('firstName ....$firstName');

      if (mounted) {
        debugPrint("user data saved");
      }

      return true;
    } catch (e) {
      return false;
    }
  }

  void errorMessageSetter(int fieldNumber, String message) {
    setState(() {
      if (fieldNumber == 1) {
        errorMessage1 = message;
      } else {
        errorMessage2 = message;
      }
    });
  }

  void tryLoggingIn() async {
    final dataReceived = await sendData(
      urlPath: "/token/session",
      data: {"email": userInput, "password": password},
    );
    print(dataReceived);

    if (dataReceived.containsKey('ClientException')) {
      ScaffoldMessenger.of(context).showSnackBar(ShowSnackAlert.CustomMessenger(
          context,
          Colors.red.shade400,
          Colors.red.shade900,
          'Connection refused ! Start Server'));
      setState(() {
        isLoggingIn = false;
      });
    }
    if (dataReceived.containsValue('ERROR') ||
        dataReceived.containsValue('error') |
            dataReceived.containsKey('error')) {
      setState(() {
        isLoggingIn = false;
      });
      if (dataReceived['item'] == null) {
        ScaffoldMessenger.of(context).showSnackBar(
            ShowSnackAlert.CustomMessenger(context, Colors.red.shade400,
                Colors.red.shade900, 'User Not In Database'));
      }

      var error = dataReceived['operationMessage'].toString();
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            content: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                    padding: const EdgeInsets.all(16),
                    height: 90,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Colors.red),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 48,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Oh Snap!',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                              Text(
                                error,
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.white),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
                Positioned(
                  bottom: 0,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20)),
                    child: SvgPicture.asset('assets/icon/bubbles.svg',
                        height: 48,
                        width: 40,
                        colorFilter: const ColorFilter.mode(
                            Color.fromARGB(255, 136, 15, 6), BlendMode.srcIn)),
                  ),
                ),
                Positioned(
                  top: -20,
                  left: 0,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/icon/fail.svg',
                        height: 40,
                      ),
                      Positioned(
                          top: 10,
                          child: InkWell(
                              onTap: () {
                                ScaffoldMessenger.of(context).clearSnackBars();
                              },
                              child: SvgPicture.asset('assets/icon/close.svg',
                                  height: 16)))
                    ],
                  ),
                )
              ],
            ),
            backgroundColor: Colors.transparent,
          ))
          .closed;
    } else {
      print('Data recieved is $dataReceived');
      var token = dataReceived['item']['token'];
      var userId = dataReceived['item']['userId'];

      final user = await getUser(userId);
      print('user is $user');

      var user_item = dataReceived['item'];

      await TokenManager.setToken(token);

      if (stayLoggedIn) {
        await _saveLoggedInUserData(token, user);
      }
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            content: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                    padding: const EdgeInsets.all(16),
                    height: 90,
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        color: Colors.green.shade300),
                    child: const Row(
                      children: [
                        SizedBox(
                          width: 48,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Text('Oh Snap!', style: TextStyle(fontSize: 18, color: Colors.white),),

                              Text(
                                "successfully logged in",
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
                Positioned(
                  bottom: 0,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20)),
                    child: SvgPicture.asset('assets/icon/bubbles.svg',
                        height: 48,
                        width: 40,
                        colorFilter: const ColorFilter.mode(
                            Color.fromARGB(255, 3, 112, 14), BlendMode.srcIn)),
                  ),
                ),
                Positioned(
                  top: -20,
                  left: 0,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/icon/fail.svg',
                        height: 40,
                      ),
                      Positioned(
                          top: 10,
                          child: InkWell(
                              onTap: () {
                                ScaffoldMessenger.of(context).clearSnackBars();
                              },
                              child: SvgPicture.asset('assets/icon/close.svg',
                                  height: 16)))
                    ],
                  ),
                )
              ],
            ),
            backgroundColor: Colors.transparent,
          ))
          .closed
          .then((value) => Navigator.of(context)
                  .pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => Newdashboard(),
                ),
                (route) => false,
              )
                  .whenComplete(() {
                if (widget.isLogin == true) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      ShowSnackAlert.CustomMessenger(
                          context,
                          Colors.green.shade600,
                          Colors.green.shade900,
                          ' Welcome to Cricyard '));
                }
              }));

      print('after login');
    }
  }

  void _validateLoginDetails() {
    isLoggingIn = true;
    FocusManager.instance.primaryFocus?.unfocus();
    if (_formKey.currentState!.validate()) {
      if (errorMessage1 != "" || errorMessage2 != "") {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please provide all required details'),
            backgroundColor: Colors.red,
          ),
        );
      } else {
        tryLoggingIn();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Color.fromARGB(255, 233, 229, 249),
      body: SingleChildScrollView(
          child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 40,
            ),
            Hero(
              tag: 1,
              child: CustomImageView(
                imagePath: ImageConstant.imgImageRemovebgPreview,
                height: 51.v,
                width: 337.h,
              ),
              // Container(
              //   margin:
              //       const EdgeInsets.symmetric(horizontal: 100, vertical: 10),
              //   height: 200,
              //   width: 200,
              //   child: const Image(
              //       image: AssetImage('assets/images/Transparent .png')),
              // ),
            ),
            SizedBox(height: 54.v),
            Text(
              "Welcome back!",
              style: theme.textTheme.displaySmall,
            ),
            SizedBox(height: 68.v),
            // const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 22),
              alignment: Alignment.centerLeft,
              child: Text(
                textAlign: TextAlign.center,
                'Login to your account',
                style: GoogleFonts.poppins().copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: ColorConstant.black90001),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    child: Text(
                      'Email',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border:
                            Border.all(color: Colors.black.withOpacity(.3))),
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    padding: const EdgeInsets.all(5),
                    child: TextFormField(
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          errorMessageSetter(
                              1, 'You must provide an email or username');
                        } else {
                          errorMessageSetter(1, "");

                          setState(() {
                            userInput = value;
                          });
                        }

                        return null;
                      },
                      autocorrect: false,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.only(
                            left: 15, bottom: 11, top: 11, right: 15),
                        hintText: "Username or email address",
                        hintStyle: TextStyle(
                            fontSize: 16, color: Colors.black.withOpacity(.3)),
                      ),
                      style: TextStyle(
                          fontSize: 16, color: Colors.black.withOpacity(.9)),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Password',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w400),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) => const ForgotPasswordF()));
                        },
                        child: Text(
                          'Forgot?',
                          style: TextStyle(
                              fontSize: 16,
                              color: ColorConstant.black90001,
                              fontWeight: FontWeight.w400),
                        ),
                      )
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border:
                            Border.all(color: Colors.black.withOpacity(.3))),
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    padding: const EdgeInsets.all(5),
                    child: TextFormField(
                      onFieldSubmitted: (value) => _validateLoginDetails(),
                      textInputAction: TextInputAction.done,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          errorMessageSetter(2, 'Password cannot be empty');
                        } else {
                          errorMessageSetter(2, "");
                          setState(() {
                            password = value;
                          });
                        }
                        return null;
                      },
                      obscureText: !isPasswordVisible,
                      autocorrect: false,
                      decoration: InputDecoration(
                        focusColor: Colors.blue,
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isPasswordVisible = !isPasswordVisible;
                            });
                          },
                          icon: Icon(
                            isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          color: Colors.black.withOpacity(.3),
                        ),
                        border: InputBorder.none,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.only(
                            left: 15, bottom: 11, top: 11, right: 15),
                        hintText: "Password",
                        hintStyle: TextStyle(
                            fontSize: 16, color: Colors.black.withOpacity(.3)),
                      ),
                      style: TextStyle(
                          fontSize: 16, color: Colors.black.withOpacity(.9)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 50),
            isLoggingIn
                ? const CircularProgressIndicator()
                : CustomButton(
                    height: 50,
                    width: 350,
                    onTap: _validateLoginDetails,
                    text: 'Login Now',
                    textStyle: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
            // CheckboxListTile(
            //   activeColor: ColorConstant.purple900,
            //   title: const Text('Stay Logged In'),
            //   value: stayLoggedIn,
            //   contentPadding: const EdgeInsets.symmetric(horizontal: 80),
            //   onChanged: (value) {
            //     setState(() {
            //       stayLoggedIn = value!;
            //     });
            //   },
            // ),
            // const SizedBox(
            //   height: 50,
            // ),

            SizedBox(height: 21.v),
            Padding(
              padding: EdgeInsets.only(
                left: 17.h,
                right: 5.h,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.v),
                    child: SizedBox(
                      width: 112.h,
                      child: const Divider(),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 12.h),
                    child: Text(
                      "Or Login with",
                      style: CustomTextStyles.titleSmallGray600,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.v),
                    child: SizedBox(
                      width: 123.h,
                      child: Divider(
                        indent: 12.h,
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 11.v),
            Align(
              alignment: Alignment.center,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 56.v,
                      width: 105.h,
                      padding: EdgeInsets.symmetric(
                        horizontal: 36.h,
                        vertical: 14.v,
                      ),
                      decoration:
                          AppDecoration.outlineOnPrimaryContainer.copyWith(
                        borderRadius: BorderRadiusStyle.roundedBorder8,
                      ),
                      child: CustomImageView(
                        svgPath: ImageConstant.imgFacebookIc,
                        height: 26.adaptSize,
                        width: 26.adaptSize,
                        alignment: Alignment.centerLeft,
                      ),
                    ),
                    Container(
                      height: 56.v,
                      width: 105.h,
                      margin: EdgeInsets.only(left: 28.h),
                      padding: EdgeInsets.symmetric(
                        horizontal: 36.h,
                        vertical: 14.v,
                      ),
                      decoration:
                          AppDecoration.outlineOnPrimaryContainer.copyWith(
                        borderRadius: BorderRadiusStyle.roundedBorder8,
                      ),
                      child: CustomImageView(
                        svgPath: ImageConstant.imgGoogleIc,
                        height: 26.adaptSize,
                        width: 26.adaptSize,
                        alignment: Alignment.topCenter,
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 22.v),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Dont have An Account',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Colors.black.withOpacity(.3)),
                ),
                const SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (ctx) => SignupScreenF()));
                  },
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: ColorConstant.purple900),
                  ),
                )
              ],
            )
          ],
        ),
      )),
    );
  }
}