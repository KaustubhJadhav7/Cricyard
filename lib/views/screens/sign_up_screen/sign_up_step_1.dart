// import 'package:flutter/material.dart';

// import 'package:flutter/services.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:pinput/pinput.dart';

// import '../../Utils/color_constants.dart';
// import '../../Utils/image_constant.dart';
// import '../../Utils/size_utils.dart';
// import '../../theme/app_style.dart';
// import '../../widgets/app_bar/appbar_image.dart';
// import '../../widgets/app_bar/appbar_title.dart';
// import '../../widgets/app_bar/custom_app_bar.dart';
// import '../../widgets/custom_button.dart';
// import '../../widgets/custom_image_view.dart';
// import '../../widgets/custom_text_form_field.dart';
// import 'SignUpService.dart';

// enum RegistrationStep {
//   SendOTP,
//   VerifyOTP,
//   EnterUserInfo,
//   SelectAccount,
// }

// class SignUpUserScreenNew extends StatefulWidget {
//   SignUpUserScreenNew({Key? key}) : super(key: key);

//   @override
//   _SignUpUserScreenState createState() => _SignUpUserScreenState();
// }

// class _SignUpUserScreenState extends State<SignUpUserScreenNew> {
//   final SignUpApiService userService = SignUpApiService();

//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//   final Map<String, dynamic> formData = {};
//   final _formKey = GlobalKey<FormState>();

//   var selectedAccount;
//   TextEditingController emailcontroller = TextEditingController();
//   var email;
//   var otp;
//   var confirmPassword;

//   bool _passwordVisible = false;
//   bool _isPasswordValid = true;
//   void _validatePassword(String password) {
//     setState(() {
//       _isPasswordValid = password.isNotEmpty;
//     });
//   }

//   bool agree_tc = false;
//   bool agree_userlicence = false;

//   RegistrationStep currentStep = RegistrationStep.SendOTP;

//   void moveToNextStep() {
//     setState(() {
//       if (currentStep == RegistrationStep.SendOTP) {
//         currentStep = RegistrationStep.VerifyOTP;
//       } else if (currentStep == RegistrationStep.VerifyOTP) {
//         currentStep = RegistrationStep.EnterUserInfo;
//       } else if (currentStep == RegistrationStep.EnterUserInfo) {
//         currentStep = RegistrationStep.SelectAccount;
//       }
//     });
//   }

//   void showSuccessMessage(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         duration: const Duration(seconds: 2),
//         backgroundColor: Colors.green,
//       ),
//     );
//   }

//   void showErrorMessage(String error) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(error),
//         duration: const Duration(seconds: 2),
//         backgroundColor: Colors.red,
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldKey,
//       appBar: CustomAppBar(
//           height: getVerticalSize(54),
//           leadingWidth: 40,
//           leading: AppbarImage(
//               height: getSize(24),
//               width: getSize(24),
//               svgPath: ImageConstant.imgArrowleft,
//               margin: getMargin(left: 16, top: 13, bottom: 17),
//               onTap: () {
//                 Navigator.pop(context);
//               }),
//           centerTitle: true,
//           title: AppbarTitle(text: "Create User")),
//       body: Builder(
//         builder: (BuildContext context) {
//           return SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.all(16),
//               child: Form(
//                 key: _formKey,
//                 child: SizedBox(
//                   height: MediaQuery.of(context).size.height,
//                   child: ListView.builder(
//                     itemCount: 1,
//                     itemBuilder: (BuildContext context, int index) {
//                       if (currentStep == RegistrationStep.SendOTP) {
//                         return Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               Text("Email",
//                                   overflow: TextOverflow.ellipsis,
//                                   textAlign: TextAlign.left,
//                                   style: AppStyle.txtGilroyMedium16Bluegray900),
//                               CustomTextFormField(
//                                   focusNode: FocusNode(),
//                                   controller: emailcontroller,
//                                   validator: (value) {
//                                     if (value == null || value.isEmpty) {
//                                       return 'Please enter Email';
//                                     }
//                                     return null;
//                                   },
//                                   hintText: "Enter Your Email",
//                                   margin: getMargin(top: 7),
//                                   textInputType: TextInputType.emailAddress),
//                               CustomButton(
//                                 height: getVerticalSize(50),
//                                 width: getHorizontalSize(396),
//                                 text: "Send OTP",
//                                 margin: getMargin(top: 25),
//                                 onTap: () async {
//                                   if (_formKey.currentState!.validate()) {
//                                     _formKey.currentState!.save();
//                                     email = emailcontroller.text;
//                                     formData['usrGrpId'] = 46;
//                                     formData['email'] = emailcontroller.text;
//                                     try {
//                                       print('send email data is $formData');

//                                       await userService.sendEmail(formData);

//                                       await Future.delayed(
//                                           const Duration(seconds: 2));

//                                       moveToNextStep();
//                                     } catch (e) {
//                                       showErrorMessage(
//                                           'Failed to send OTP: $e');
//                                     }
//                                   }
//                                 },
//                               ),
//                               Align(
//                                   alignment: Alignment.center,
//                                   child: Padding(
//                                       padding: getPadding(top: 28, bottom: 5),
//                                       child: RichText(
//                                           text: TextSpan(children: [
//                                             TextSpan(
//                                                 text: "",
//                                                 style: TextStyle(
//                                                     color:
//                                                         ColorConstant.fromHex(
//                                                             "#ff12282a"),
//                                                     fontSize: getFontSize(16),
//                                                     fontFamily: 'Gilroy',
//                                                     fontWeight:
//                                                         FontWeight.w400)),
//                                             TextSpan(
//                                                 text: " ",
//                                                 style: TextStyle(
//                                                     color:
//                                                         ColorConstant.fromHex(
//                                                             "#ff12282a"),
//                                                     fontSize: getFontSize(16),
//                                                     fontFamily: 'Gilroy',
//                                                     fontWeight:
//                                                         FontWeight.w700)),
//                                             TextSpan(
//                                                 text: "",
//                                                 style: TextStyle(
//                                                     color:
//                                                         ColorConstant.fromHex(
//                                                             "#ff0061ff"),
//                                                     fontSize: getFontSize(16),
//                                                     fontFamily: 'Gilroy',
//                                                     fontWeight: FontWeight.w700,
//                                                     decoration: TextDecoration
//                                                         .underline))
//                                           ]),
//                                           textAlign: TextAlign.left)))
//                             ]);
//                       } else if (currentStep == RegistrationStep.VerifyOTP) {
//                         return SingleChildScrollView(
//                           child: Container(
//                             width: double.maxFinite,
//                             padding: getPadding(
//                               left: 16,
//                               top: 76,
//                               right: 16,
//                             ),
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               children: [
//                                 CustomImageView(
//                                   svgPath: ImageConstant.imgMobile,
//                                   height: getVerticalSize(
//                                     82,
//                                   ),
//                                   width: getHorizontalSize(
//                                     51,
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: getPadding(
//                                     top: 29,
//                                   ),
//                                   child: Text(
//                                     "Email Verification",
//                                     overflow: TextOverflow.ellipsis,
//                                     textAlign: TextAlign.left,
//                                     style: AppStyle.txtGilroySemiBold24,
//                                   ),
//                                 ),
//                                 Container(
//                                   width: getHorizontalSize(
//                                     302,
//                                   ),
//                                   margin: getMargin(
//                                     left: 46,
//                                     top: 19,
//                                     right: 46,
//                                   ),
//                                   child: Text(
//                                     "A mail with a 6-digit verification code was just sent to ${email}",
//                                     maxLines: null,
//                                     textAlign: TextAlign.center,
//                                     style: AppStyle.txtGilroyMedium16,
//                                   ),
//                                 ),
//                                 Pinput(
//                                   length: 6,
//                                   showCursor: true,
//                                   defaultPinTheme: PinTheme(
//                                     width: 50,
//                                     height: 50,
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(10),
//                                       border: Border.all(
//                                         color: ColorConstant.blue50,
//                                       ),
//                                     ),
//                                     textStyle: const TextStyle(
//                                       fontSize: 20,
//                                       fontWeight: FontWeight.w600,
//                                     ),
//                                   ),
//                                   onCompleted: (value) {
//                                     setState(() {
//                                       otp = value;
//                                     });
//                                   },
//                                 ),
//                                 Row(children: [
//                                   Checkbox(
//                                     activeColor: ColorConstant.blueA700,
//                                     value: agree_tc,
//                                     onChanged: (newValue) {
//                                       setState(() {
//                                         agree_tc = newValue!;
//                                       });
//                                     },
//                                   ),
//                                   Text(
//                                       "you agree to our Terms and Privacy Policy.",
//                                       overflow: TextOverflow.ellipsis,
//                                       textAlign: TextAlign.left,
//                                       style: AppStyle
//                                           .txtGilroyMedium16Bluegray900),
//                                 ]),
//                                 Row(children: [
//                                   Checkbox(
//                                     activeColor: ColorConstant.blueA700,
//                                     value: agree_userlicence,
//                                     onChanged: (newValue) {
//                                       setState(() {
//                                         agree_userlicence = newValue!;
//                                       });
//                                     },
//                                   ),
//                                   Text("you agree to our User Licence.",
//                                       overflow: TextOverflow.ellipsis,
//                                       textAlign: TextAlign.left,
//                                       style: AppStyle
//                                           .txtGilroyMedium16Bluegray900),
//                                 ]),
//                                 //bool agree_userlicence = false;
//                                 CustomButton(
//                                   height: getVerticalSize(
//                                     50,
//                                   ),
//                                   text: "Next",
//                                   margin: getMargin(
//                                     top: 40,
//                                   ),
//                                   onTap: () async {
//                                     if (agree_tc && agree_userlicence) {
//                                       try {
//                                         print(
//                                             'email is $email and otp is $otp');
//                                         await userService.otpverification(
//                                             emailcontroller.text, otp);

//                                         moveToNextStep();
//                                         showSuccessMessage(
//                                             'Email verified successfully');
//                                       } catch (e) {
//                                         showErrorMessage(
//                                             'Failed to verify OTP: $e');
//                                       }
//                                     } else {
//                                       Fluttertoast.showToast(
//                                         msg:
//                                             'Please First Agree terms and Conditions',
//                                         backgroundColor: Colors.red,
//                                       );
//                                     }
//                                   },
//                                 ),

//                                 Padding(
//                                     padding: getPadding(top: 3),
//                                     child: GestureDetector(
//                                       onTap: () async {
//                                         try {
//                                           print('tapped');
//                                           Navigator.of(context).push(
//                                               MaterialPageRoute(
//                                                   builder: (ctx) =>
//                                                       ForgotPasswordPage()));
//                                           //
//                                         } catch (e) {
//                                           ScaffoldMessenger.of(context)
//                                               .showSnackBar(SnackBar(
//                                                   content: Text('Failed')));
//                                         }
//                                       },
//                                       child: Text("Forgot Password?",
//                                           overflow: TextOverflow.ellipsis,
//                                           textAlign: TextAlign.left,
//                                           style: AppStyle
//                                               .txtGilroyMedium14BlueA700),
//                                     )),

//                                 Align(
//                                   alignment: Alignment.centerLeft,
//                                   child: Padding(
//                                     padding: getPadding(
//                                       top: 18,
//                                       bottom: 5,
//                                     ),
//                                     child: Row(
//                                       children: [
//                                         Padding(
//                                           padding: getPadding(
//                                             top: 2,
//                                           ),
//                                           child: Text(
//                                             "Didn’t get the code?",
//                                             overflow: TextOverflow.ellipsis,
//                                             textAlign: TextAlign.left,
//                                             style: AppStyle.txtGilroyMedium16,
//                                           ),
//                                         ),
//                                         Padding(
//                                           padding: getPadding(
//                                             left: 12,
//                                             bottom: 1,
//                                           ),
//                                           child: GestureDetector(
//                                             onTap: () async {
//                                               try {
//                                                 await userService
//                                                     .resendEmail(email);

//                                                 await Future.delayed(
//                                                     const Duration(seconds: 5));
//                                                 showSuccessMessage(
//                                                     'OTP RESEND');
//                                               } catch (e) {
//                                                 showErrorMessage(
//                                                     'Failed to resend OTP: $e');
//                                               }
//                                             },
//                                             child: Text(
//                                               "Resend",
//                                               overflow: TextOverflow.ellipsis,
//                                               textAlign: TextAlign.left,
//                                               style: AppStyle
//                                                   .txtGilroySemiBold16BlueA700,
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         );
//                       } else if (currentStep ==
//                           RegistrationStep.EnterUserInfo) {
//                         return Column(
//                           children: [
//                             CustomButton(
//                               height: getVerticalSize(
//                                 50,
//                               ),
//                               text: "Go to Registration Details",
//                               margin: getMargin(
//                                 top: 40,
//                               ),
//                               onTap: () async {
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) =>
//                                         RegistrationDetailsScreen(
//                                             email: emailcontroller.text),
//                                   ),
//                                 );
//                               },
//                             ),
//                           ],
//                         );
//                       } else {
//                         return Container();
//                       }
//                     },
//                   ),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
