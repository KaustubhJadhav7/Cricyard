import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import '../../../Utils/image_constant.dart';
import '../../../Utils/size_utils.dart';
import '../../widgets/app_bar/appbar_image.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_dropdownfield.dart';
import '../../widgets/custom_textformfield.dart';
import '../Login Screen/view/CustomButton.dart';
import '../Login Screen/view/login_screen_f.dart';
import '../sign_up_screen/SignUpService.dart';
import '../sign_up_screen/choose_package_screen.dart';
import 'create_account_f.dart';

class RegstrationDetailsF extends StatefulWidget {
  RegstrationDetailsF({super.key, required this.email});
  var email;

  @override
  State<RegstrationDetailsF> createState() => _RegstrationDetailsFState();
}

class _RegstrationDetailsFState extends State<RegstrationDetailsF> {
  final SignUpApiService userService = SignUpApiService();
  final Map<String, dynamic> formData = {};
  final Map<String, dynamic> accountformData = {};
  final _formKey = GlobalKey<FormState>();

  var account_id = null;
  var selectedAccount;
  var newPassword = '';
  var confirmPassword = '';
  bool _newpasswordVisible = false;
  bool _confirmpasswordVisible = false;
  bool _isPasswordValid = true;
  var selectedgender = '';
  var selectedCity = '';
  DateTime selectedDate = DateTime.now();

  final List<String> cityList = [
    // List of some Indian cities for demonstration
    'Pune', 'Mumbai', 'Delhi', 'Bengaluru', 'Hyderabad', 'Ahmedabad', 'Chennai',
    'Kolkata', 'Jaipur', 'Surat', 'Lucknow', 'Kanpur', 'Nagpur',
    'Indore', 'Thane', 'Bhopal', 'Visakhapatnam', 'Pimpri-Chinchwad',
    'Patna', 'Vadodara'
  ];
  String? _validatePasswordMatch(String value) {
    if (value != newPassword) {
      print('value is $value and new is $newPassword');
      return 'Passwords do not match';
    }
    return null;
  }

  void _validatePassword(String password) {
    setState(() {
      _isPasswordValid = password.isNotEmpty;
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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        height: getVerticalSize(54),
        centerTitle: true,
        leading: AppbarImage(
            height: getSize(24),
            width: getSize(24),
            svgPath: ImageConstant.imgArrowleft,
            margin: getMargin(left: 16, top: 13, bottom: 17),
            onTap: () {
              Navigator.pop(context);
            }),
        title: AppbarTitle(text: 'Registration Details'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
              key: _formKey,
              child: Column(children: [
                const SizedBox(
                  width: double.infinity,
                  child: Text(
                    'First Name',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontWeight: FontWeight.w700, color: Colors.black),
                  ),
                ),
                CustomTextField(
                  hintText: 'Enter First Name',
                  onSaved: (value) => formData['first_name'] = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter  First Name';
                    }
                    return null;
                  },
                ),
                Padding(
                  padding: getPadding(top: 22),
                  child: const SizedBox(
                    width: double.infinity,
                    child: Text(
                      "Last Name",
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontWeight: FontWeight.w700, color: Colors.black),
                    ),
                  ),
                ),
                CustomTextField(
                  hintText: 'Enter Last Name',
                  onSaved: (value) => formData['last_name'] = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Last Name';
                    }
                    return null;
                  },
                ),

                Padding(
                  padding: getPadding(top: 22),
                  child: const SizedBox(
                    width: double.infinity,
                    child: Text(
                      "Father Name",
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontWeight: FontWeight.w700, color: Colors.black),
                    ),
                  ),
                ),
                CustomTextField(
                  hintText: 'Enter Father Name',
                  onSaved: (value) => formData['father_name'] = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Father Name';
                    }
                    return null;
                  },
                ),

                Padding(
                  padding: getPadding(top: 22),
                  child: const SizedBox(
                    width: double.infinity,
                    child: Text(
                      "Mother Name",
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontWeight: FontWeight.w700, color: Colors.black),
                    ),
                  ),
                ),
                CustomTextField(
                  hintText: 'Enter Mother Name',
                  onSaved: (value) => formData['mother_name'] = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Mother Name';
                    }
                    return null;
                  },
                ),
                Padding(
                    padding: getPadding(top: 22),
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
                  textInputType: TextInputType.number,
                  hintText: 'Enter Mobile Number',
                  onSaved: (value) => formData['mob_no'] = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Mobile Number';
                    }
                    return null;
                  },
                ),
                Padding(
                  padding: getPadding(top: 22),
                  child: const SizedBox(
                    width: double.infinity,
                    child: Text(
                      "Gender",
                      style: TextStyle(
                          fontWeight: FontWeight.w700, color: Colors.black),
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                CustomDropdownField(
                  value: selectedgender,
                  items: [
                    const DropdownMenuItem<String>(
                      value: '',
                      child: Text(
                        'Select Gender',
                      ),
                    ),
                    ...['Male', 'Female', 'Other']
                        .map<DropdownMenuItem<String>>((item) {
                      return DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                        ),
                      );
                    }),
                  ],
                  onChanged: (value) {
                    setState(() {
                      selectedgender = value!;
                    });
                  },
                  onSaved: (value) {
                    if (selectedgender.isEmpty) {
                      selectedgender = '';
                    }
                    formData['gender'] = selectedgender;
                  },
                ),
                Padding(
                  padding: getPadding(top: 22),
                  child: const SizedBox(
                    width: double.infinity,
                    child: Text(
                      "Location",
                      style: TextStyle(
                          fontWeight: FontWeight.w700, color: Colors.black),
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                DropdownSearch<String>(
                  popupProps: const PopupProps.menu(
                    showSelectedItems: true,
                    // disabledItemFn: (String s) => s.startsWith('I'),
                  ),
                  dropdownDecoratorProps: const DropDownDecoratorProps(
                    dropdownSearchDecoration: InputDecoration(
                      labelText: "City",
                      hintText: "Select City",
                      hintStyle:
                          TextStyle(color: Colors.black), // Set hint text color
                      labelStyle: TextStyle(
                          color: Colors.black), // Set label text color
                    ),
                  ),
                  items: cityList,
                  onChanged: (value) {
                    setState(() {
                      selectedCity = value!;
                    });
                  },
                  selectedItem: selectedCity,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a city';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    formData['location'] = value!;
                  },
                ),
                Padding(
                    padding: getPadding(top: 22),
                    child: const SizedBox(
                      width: double.infinity,
                      child: Text(
                        "Date of Birth",
                        style: TextStyle(
                            fontWeight: FontWeight.w700, color: Colors.black),
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                      ),
                    )),
                CustomTextField(
                  hintText: "${selectedDate.toLocal()}".split(' ')[0],
                  onTap: () => _selectDate(context),
                  onSaved: (value) =>
                      formData['date_of_birth'] = selectedDate.toString(),
                ),
                Padding(
                    padding: getPadding(top: 22),
                    child: const SizedBox(
                      width: double.infinity,
                      child: Text(
                        "Enter Password",
                        style: TextStyle(
                            fontWeight: FontWeight.w700, color: Colors.black),
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                      ),
                    )),
                CustomTextField(
                    suffixIcon: IconButton(
                      icon: Icon(
                        _newpasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _newpasswordVisible = !_newpasswordVisible;
                        });
                      },
                    ),
                    hintText: 'Enter Password',
                    onSaved: (value) => formData['new_password'] = value,
                    onChanged: (value) {
                      setState(() {
                        newPassword = value!;
                      });
                      _validatePassword;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Password';
                      } else if (!_isPasswordValid) {
                        return 'Please enter a valid password';
                      }
                      return null;
                    },
                    isObscureText: !_newpasswordVisible),
                Padding(
                    padding: getPadding(top: 22),
                    child: const SizedBox(
                      width: double.infinity,
                      child: Text(
                        "Confirm Password",
                        style: TextStyle(
                            fontWeight: FontWeight.w700, color: Colors.black),
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                      ),
                    )),
                CustomTextField(
                  hintText: "Confirm Password",
                  textInputType: TextInputType.visiblePassword,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Password';
                    }
                    return _validatePasswordMatch(confirmPassword);
                  },
                  onSaved: (value) => formData['confirm_password'] = value,
                  onChanged: (value) {
                    setState(() {
                      confirmPassword = value!; // Update confirmPassword
                    });
                  },
                  suffixIcon: IconButton(
                    icon: Icon(
                      _confirmpasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _confirmpasswordVisible = !_confirmpasswordVisible;
                      });
                    },
                  ),
                  isObscureText: !_confirmpasswordVisible,
                ),
                const SizedBox(height: 20),

                // CustomButton(
                //   height: 50,
                //   width: 400,
                //   onTap: () async {
                //     final accountId = await Navigator.push(
                //       context,
                //       MaterialPageRoute(
                // builder: (context) => const CreateAccountF()
                //           //CreateAccountScreen(),
                //           ),
                //     );

                //     if (accountId != null) {
                //       setState(() {
                //         selectedAccount = accountId;
                //         formData['account_id'] = accountId;
                //         account_id = accountId; // Update the account_id here
                //       });
                //     }
                //   },
                //   text: 'Add account',
                // ),
                // if (account_id != null)
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 5), // Add margin
                  child: CustomButton(
                    height: getVerticalSize(50),
                    width: getHorizontalSize(396),
                    text: "SUBMIT",
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();

                        print('formdata is $formData');

                        accountformData['email'] = widget.email;

                        final response =
                            await userService.createAccount(accountformData);

                        account_id = response['account_id'].toString();

                        formData['usrGrpId'] = 1;
                        formData['account_id'] = account_id;
                        formData['email'] = widget.email;
                        try {
                          print('working');
                          await userService.createuser(formData).then((_) => {
                                const LoginScreenF(false),
                              });
                          await Future.delayed(const Duration(seconds: 5));

                          //showSuccessMessage('User created successfully');
                          // ignore: use_build_context_synchronously
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const PlanSelectionScreen()));
                          //moveToNextStep();
                        } catch (e) {
                          print(e);
                          showErrorMessage('Failed to create User: $e');
                        }
                      }
                    },
                  ),
                ),
              ])),
        ),
      ),
    );
  }
}
