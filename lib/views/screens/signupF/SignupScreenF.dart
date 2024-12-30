// ignore_for_file: use_build_context_synchronously

import 'package:confetti/confetti.dart';
import 'package:cricyard/core/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:pinput/pinput.dart';
import '../../../Utils/color_constants.dart';
import '../../../Utils/size_utils.dart';
import '../../../core/utils/image_constant.dart';
import '../../../theme/app_style.dart';
import '../../widgets/custom_image_view.dart';
import '../Login Screen/view/CustomButton.dart';
import '../Login Screen/view/login_screen_f.dart';
import '../sign_up_screen/SignUpService.dart';
import '../../widgets/app_bar/appbar_image.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import 'registration_details_f.dart';

enum RegistrationStep {
  SendOTP,
  VerifyOTP,
  EnterUserInfo,
  SelectAccount,
}

class SignupScreenF extends StatefulWidget {
  const SignupScreenF({super.key});

  @override
  State<SignupScreenF> createState() => _SignupState();
}

class _SignupState extends State<SignupScreenF> {
  final SignUpApiService userService = SignUpApiService();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final Map<String, dynamic> formData = {};
  final _formKey = GlobalKey<FormState>();

  var selectedAccount;
  TextEditingController emailcontroller = TextEditingController();
  var email;
  var otp;
  var confirmPassword;

  bool _passwordVisible = false;
  bool _isPasswordValid = true;
  void _validatePassword(String password) {
    setState(() {
      _isPasswordValid = password.isNotEmpty;
    });
  }

  bool agree_tc = false;
  bool agree_userlicence = false;

  RegistrationStep currentStep = RegistrationStep.SendOTP;

  void moveToNextStep() {
    setState(() {
      if (currentStep == RegistrationStep.SendOTP) {
        currentStep = RegistrationStep.VerifyOTP;
      } else if (currentStep == RegistrationStep.VerifyOTP) {
        currentStep = RegistrationStep.EnterUserInfo;
      } else if (currentStep == RegistrationStep.EnterUserInfo) {
        currentStep = RegistrationStep.SelectAccount;
      }
    });
  }

  void showSuccessMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.green,
      ),
    );
  }

  void showErrorMessage(String error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(error),
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.red,
      ),
    );
  }

  Future<void> _sendEmail(Map<String, dynamic> formData) async {
    final response = await userService.sendEmail(formData);

    print('response is: $response');

    if (response == 'Otp send successfully') {
      // Update invite status and show snack bar

      _showCustomSnackBar2(context, 'Otp send successfully!', true);
    } else if (response == '${formData['email']} already exist') {
      // Update invite status and show snack bar

      _showCustomSnackBar2(
          context, '${formData['email']} already exist!', false);
    } else {
      // Handle failed invite
      _showCustomSnackBar2(context, 'Failed to send Email.', false);
    }
  }

  void _showCustomSnackBar2(
      BuildContext context, String message, bool isSuccess) {
    final overlay = Overlay.of(context);
    final confettiController =
        ConfettiController(duration: const Duration(seconds: 2));

    final overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          Center(
            child: Material(
              color: Colors.transparent,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                decoration: BoxDecoration(
                  color: isSuccess ? Colors.white : Colors.red.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10.0,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Text(
                  message,
                  style: TextStyle(
                    color: isSuccess ? Colors.black : Colors.white,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
          ),
          if (isSuccess)
            Center(
              child: ConfettiWidget(
                confettiController: confettiController,
                blastDirectionality: BlastDirectionality.explosive,
                shouldLoop: false,
                colors: const [
                  Colors.red,
                  Colors.green,
                  Colors.blue,
                  Colors.yellow,
                  Colors.purple,
                  Colors.orange,
                ],
              ),
            ),
        ],
      ),
    );

    overlay.insert(overlayEntry);

    if (isSuccess) {
      confettiController.play();
    }

    Future.delayed(const Duration(seconds: 3), () {
      overlayEntry.remove();
      confettiController.dispose();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //backgroundColor: Color.fromARGB(255, 233, 229, 249),
        key: _scaffoldKey,
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
            title: AppbarTitle(text: "Create an Account")),
        body: Builder(builder: (ctx) {
          return SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.all(15),
            child: Form(
                key: _formKey,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: ListView.builder(
                      itemCount: 1,
                      itemBuilder: (ctx, index) {
                        if (currentStep == RegistrationStep.SendOTP) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  // Container(
                                  //   height: 170,
                                  //   width: 170,
                                  //   child: Image.asset(
                                  //       'assets/images/Transparent .png'),
                                  // ),
                                  CustomImageView(
                                    imagePath:
                                        ImageConstant.imgImageRemovebgPreview,
                                    height: 59.v,
                                    width: 382.h,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    alignment: Alignment.topCenter,
                                    child: Text('Welcome to CricYard',
                                        style: GoogleFonts.bebasNeue().copyWith(
                                            fontSize: 24,
                                            fontWeight: FontWeight.w300,
                                            color: ColorConstant.black90001)),
                                  ),
                                  const SizedBox(height: 25),
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 25),
                                    alignment: Alignment.centerLeft,
                                    child: const SizedBox(
                                      child: Text(
                                        'Enter Your Email Address',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  InkWell(
                                    child: Container(
                                      height: 50,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 25),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border:
                                              Border.all(color: Colors.white),
                                          color: Colors.white),
                                      child: TextFormField(
                                          controller: emailcontroller,
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          validator: (value) {
                                            if (value!.isEmpty ||
                                                value == null) {
                                              return 'enter email address';
                                            }
                                            return null;
                                          },
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: 'Email Address',
                                              hintStyle: TextStyle(
                                                  color: Colors.black
                                                      .withOpacity(.2)))),
                                    ),
                                  ),
                                  const SizedBox(height: 250),
                                ],
                              ),
                              Column(
                                children: [
                                  CustomButton(
                                    text: 'Send OTP',
                                    textStyle: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                    height: 50,
                                    width: 400,
                                    onTap: () async {
                                      if (_formKey.currentState!.validate()) {
                                        _formKey.currentState!.save();
                                        email = emailcontroller.text;
                                        formData['usrGrpId'] = 1;
                                        formData['email'] =
                                            emailcontroller.text;
                                        try {
                                          print('send email data is $formData');

                                          // await userService.sendEmail(formData);
                                          // _sendEmail(formData);
                                          final response = await userService
                                              .sendEmail(formData);

                                          print('response is: $response');

                                          if (response.statusCode == 200) {
                                            // Update invite status and show snack bar

                                            _showCustomSnackBar2(context,
                                                'Otp send successfully!', true);
                                          } else if (response.statusCode ==
                                              '${formData['email']} already exist') {
                                            // Update invite status and show snack bar

                                            _showCustomSnackBar2(
                                                context,
                                                '${formData['email']} already exist!',
                                                false);
                                          } else if (response.statusCode ==
                                              500) {
                                            // Update invite status and show snack bar

                                            _showCustomSnackBar2(context,
                                                'Invalid Email!', false);
                                          } else {
                                            // Handle failed invite
                                            _showCustomSnackBar2(context,
                                                'Failed to send Email.', false);
                                          }

                                          await Future.delayed(
                                              const Duration(seconds: 2));

                                          if (response.statusCode == 200)
                                            moveToNextStep();
                                        } catch (e) {
                                          showErrorMessage(
                                              'Failed to send OTP: $e');
                                        }
                                      }
                                    },
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('Already Have an Account ?',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black
                                                  .withOpacity(.6))),
                                      InkWell(
                                        child: Text(' Login',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w400,
                                                color:
                                                    ColorConstant.purple211)),
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (ctx) =>
                                                      const LoginScreenF(
                                                          false)));
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          );
                        } else if (currentStep == RegistrationStep.VerifyOTP) {
                          return SingleChildScrollView(
                            child: Form(
                                child: Column(
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                // Container(
                                //   height: 220,
                                //   width: 220,
                                //   child: Image.asset(
                                //       'assets/images/forget-password.png'),
                                // ),
                                const SizedBox(height: 12),
                                Container(
                                  child: Column(
                                    children: [
                                      Text(
                                        'OTP verification',
                                        style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                            color: ColorConstant.black90001),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        style: TextStyle(
                                            color:
                                                Colors.black.withOpacity(.6)),
                                        "A mail with a 6-digit verification code was just sent to $email",
                                        maxLines: null,
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                Row(children: [
                                  Checkbox(
                                    activeColor: ColorConstant.blueA700,
                                    value: agree_tc,
                                    onChanged: (newValue) {
                                      setState(() {
                                        agree_tc = newValue!;
                                      });
                                    },
                                  ),
                                  Text(
                                      "you agree to our Terms and Privacy Policy.",
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                      style: AppStyle
                                          .txtGilroyMedium16Bluegray900),
                                ]),
                                Row(children: [
                                  Checkbox(
                                    activeColor: ColorConstant.blueA700,
                                    value: agree_userlicence,
                                    onChanged: (newValue) {
                                      setState(() {
                                        agree_userlicence = newValue!;
                                      });
                                    },
                                  ),
                                  Text("you agree to our User Licence.",
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                      style: AppStyle
                                          .txtGilroyMedium16Bluegray900),
                                ]),
                                const SizedBox(
                                  height: 20,
                                ),
                                Pinput(
                                  length: 6,
                                  showCursor: true,
                                  defaultPinTheme: PinTheme(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Color.fromARGB(255, 30, 2, 2),
                                        )
                                      ],
                                      color:
                                          const Color.fromARGB(206, 70, 15, 15),
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: Colors.black.withOpacity(.4)),
                                    ),
                                    textStyle: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  onCompleted: (value) {
                                    setState(() {
                                      otp = value;
                                    });
                                  },
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                const Text(
                                  'Your OTP expires in 120 seconds',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.blueAccent,
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        'Didnt Recieve OTP',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: Colors.blueAccent,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          try {
                                            await userService
                                                .resendEmail(email);

                                            await Future.delayed(
                                                const Duration(seconds: 5));
                                            showSuccessMessage('OTP RESEND');
                                          } catch (e) {
                                            showErrorMessage(
                                                'Failed to resend OTP: $e');
                                          }
                                        },
                                        child: Text(
                                          'Resend',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              color: Colors.purple.shade900),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10),
                                CustomButton(
                                  height: 50,
                                  width: 400,
                                  onTap: () async {
                                    if (agree_tc && agree_userlicence) {
                                      try {
                                        print(
                                            'email is $email and otp is $otp');
                                        final response =
                                            await userService.otpVerification(
                                                emailcontroller.text, otp);

                                        if (response.statusCode == 200) {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  RegstrationDetailsF(
                                                      email:
                                                          emailcontroller.text),
                                            ),
                                          );
                                          moveToNextStep();
                                          showSuccessMessage(
                                              'Email verified successfully');
                                        }
                                      } catch (e) {
                                        showErrorMessage(
                                            'Failed to verify OTP: $e');
                                      }
                                    } else {
                                      Fluttertoast.showToast(
                                        msg:
                                            'Please First Agree terms and Conditions',
                                        backgroundColor: Colors.red,
                                      );
                                    }
                                  },
                                  text: 'Submit',
                                  textStyle: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                )
                              ],
                            )),
                          );
                        } else if (currentStep ==
                            RegistrationStep.EnterUserInfo) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CustomButton(
                                text: "Registration Details",
                                height: 50,
                                width: 400,
                                onTap: () async {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => RegstrationDetailsF(
                                          email: emailcontroller.text),
                                    ),
                                  );
                                },
                              )
                            ],
                          );
                        }
                      }),
                )),
          ));
        }));
  }
}
