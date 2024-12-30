import 'package:flutter/material.dart';

import '../../../providers/token_manager.dart';
import '../../../resources/api_constants.dart';
import 'package:http/http.dart' as http;
import '../Login Screen/view/CustomButton.dart';
import '../Login Screen/view/login_screen_f.dart';

class ForgotPasswordF extends StatefulWidget {
  const ForgotPasswordF({super.key});

  @override
  State<ForgotPasswordF> createState() => _ForgotPasswordFState();
}

class _ForgotPasswordFState extends State<ForgotPasswordF> {
  final TextEditingController emailController = TextEditingController();
  String message = '';
  bool isLoading = false; // Added to track loading state

  Future<void> sendForgotPasswordRequest() async {
    setState(() {
      isLoading = true; // Show loading indicator when sending request
    });

    final email = emailController.text;
    final token = await TokenManager.getToken();
    const String baseUrl = ApiConstants.baseUrl;

    try {
      print('sending');

      final response = await http.post(
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        Uri.parse('$baseUrl/token/resources/forgotpassword?email=$email'),
      );
      //
      if (response.statusCode == 200) {
        print('email sent');
        setState(() {
          message = 'An email with a reset link has been sent to $email.';
        });

        // Delay for 3 seconds and then navigate to the login page
        Future.delayed(const Duration(seconds: 3), () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const LoginScreenF(false)));
        });
      } else {
        print(response.statusCode);
        setState(() {
          message = 'Failed to send the reset link. Please try again.';
        });
      }
    } catch (e) {
      throw Exception('error is $e');
    }

    setState(() {
      isLoading = false; // Hide loading indicator when the request is complete
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 233, 229, 249),
      body: SingleChildScrollView(
        child: Form(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 50,
            ),
            // image container
            // Container(
            //   alignment: Alignment.center,
            //   margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            //   height: 290,
            //   width: 330,
            //   child: const Image(
            //     image: AssetImage('assets/images/forget-password.png'),
            //   ),
            // ),
            const SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 135,
                    child: const Text(
                      overflow: TextOverflow.clip,
                      'Forgot Password?',
                      style: TextStyle(
                          fontSize: 26,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 9,
                  ),
                  Container(
                    width: 300,
                    child: Text(
                      overflow: TextOverflow.clip,
                      'Don’t worry ! It happens. Please enter the phone number we will send the OTP in this phone number.',
                      style: TextStyle(
                          fontSize: 16, color: Colors.black.withOpacity(.5)),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    child: Text(
                      'Enter your email',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black.withOpacity(.7),
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.white),
                          color: Colors.white),
                      child: TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Email Address',
                            hintStyle:
                                TextStyle(color: Colors.black.withOpacity(.2))),
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Text(
                        textAlign: TextAlign.right,
                        ' Already have an account?,',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                            color: Colors.black.withOpacity(.4)),
                      ),
                      InkWell(
                        child: const Text(
                          textAlign: TextAlign.right,
                          ' Login',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                              color: Colors.blue),
                        ),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) => const LoginScreenF(false)));
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 60),
                  isLoading == false
                      ? CustomButton(
                          text: 'Continue',
                          height: 60,
                          width: 370,
                          onTap: () {
                            sendForgotPasswordRequest();
                          },
                        )
                      : const Center(child: CircularProgressIndicator())
                ],
              ),
            )
          ],
        )),
      ),
    );
  }
}