import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Utils/image_constant.dart';
import '../../../Utils/size_utils.dart';
import '../../widgets/app_bar/appbar_image.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/custom_app_bar.dart';

import '../../widgets/custom_messenger.dart';
import '../Login Screen/view/CustomButton.dart';
import '../Login Screen/view/login_screen_f.dart';

class SuccessScreenF extends StatefulWidget {
  final String packageName;

  SuccessScreenF({required this.packageName});

  @override
  State<SuccessScreenF> createState() => _SuccessScreenFState();
}

class _SuccessScreenFState extends State<SuccessScreenF> {
  List<String> selectedWorkButtons = [];

  List<String> selectedRoleButtons = [];

  List<String> selectedSourceButtons = [];

  List<String> selectedBuildingPurpose = [];
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          height: getVerticalSize(49),
          leadingWidth: 40,
          centerTitle: true,
          title: AppbarTitle(
            text: "Welcome to CricYard!",
          )),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'How do you know about us',
                style: GoogleFonts.poppins()
                    .copyWith(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              // buildQuestion(
              //   'Where do you work?*',
              //   [
              //     'Startup',
              //     'Freelancer',
              //     'Design Agency',
              //     'Large Company',
              //     'Dev Shop',
              //     'Small/Medium Company',
              //     'Other'
              //   ],
              //   selectedWorkButtons,
              // ),
              // buildQuestion(
              //   'What is your primary role?*',
              //   [
              //     'Executive',
              //     'Founder',
              //     'Developer',
              //     'Product Manager',
              //     'Designer',
              //     'Other'
              //   ],
              //   selectedRoleButtons,
              // ),
              buildQuestion(
                'How did you hear about us?*',
                [
                  'LinkedIn',
                  'YouTube',
                  'Twitter',
                  'Flutter Forword',
                  'Search',
                  'TikTok',
                  'Friend/Coworker',
                  'Other'
                ],
                selectedSourceButtons,
              ),
              // buildQuestion(
              //   'Are you building the app for yourself or for your job?*',
              //   ['Myself', 'My Job'],
              //   selectedBuildingPurpose,
              // ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomButton(
                  height: getVerticalSize(50),
                  text: "Continue",
                  width: 400,
                  onTap: () async {
                    print('Work: $selectedWorkButtons');
                    print('Role: $selectedRoleButtons');
                    print('Source: $selectedSourceButtons');
                    print('Building Purpose: $selectedBuildingPurpose');
                    ScaffoldMessenger.of(context).showSnackBar(
                        ShowSnackAlert.CustomMessenger(
                            context,
                            Colors.green.shade600,
                            Colors.green.shade900,
                            'User Created Successfully '));
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) =>
                    //         const LoginScreen()));
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreenF(true)),
                      (Route<dynamic> route) => false,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
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

  Widget buildQuestion(
      String heading, List<String> options, List<String> selectedButtons) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(50.0, 10, 50, 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16),
          Text(
            heading,
            style: GoogleFonts.poppins().copyWith(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: options.map((option) {
              bool isSelected = selectedButtons.contains(option);
              return ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (isSelected) {
                      selectedButtons.remove(option);
                    } else {
                      selectedButtons.add(option);
                    }
                  });
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(isSelected
                      ? Color.fromARGB(255, 147, 78, 225)
                      : Color.fromARGB(255, 222, 199, 240)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          15.0), // Adjust the value as needed
                    ),
                  ),
                ),
                child: Text(
                  option,
                  style: GoogleFonts.poppins().copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: isSelected ? Colors.white : Colors.black),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
