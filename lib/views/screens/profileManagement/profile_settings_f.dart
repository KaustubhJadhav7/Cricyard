import 'dart:convert';
import 'dart:typed_data';
import 'package:cricyard/core/app_export.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

import '../../../core/utils/image_constant.dart';
import '../../../providers/token_manager.dart';
import '../../../resources/api_constants.dart';
import '../../widgets/custom_text_form_field.dart';
import '../Login Screen/view/CustomButton.dart';
import '../Login Screen/view/login_screen_f.dart';
import '../LogoutService/Logoutservice.dart';
import '../ReuseableWidgets/BottomAppBarWidget.dart';
import 'apiserviceprofilemanagement.dart';

class ProfileSettingsScreenF extends StatefulWidget {
  final Map<String, dynamic> userData;

  ProfileSettingsScreenF({required this.userData});

  @override
  _ProfileSettingsScreenFState createState() => _ProfileSettingsScreenFState();
}

class _ProfileSettingsScreenFState extends State<ProfileSettingsScreenF> {
  ApiServiceProfileManagement apiService = ApiServiceProfileManagement();
  Uint8List? _imageBytes;
  String? _imageFileName;
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();

  TextEditingController fullNameController = TextEditingController();
  TextEditingController pronounsController = TextEditingController();
  TextEditingController roleController = TextEditingController();
  TextEditingController departmentController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController aboutMeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchProfileImageData();
    fetchUserProfileData();
  }

  Future<void> _uploadImageFile() async {
    final imagePicker = ImagePicker();
    try {
      final pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        final imageBytes = await pickedImage.readAsBytes();
        setState(() {
          _imageBytes = imageBytes;
          _imageFileName = pickedImage.name;
        });
      }
    } catch (e) {
      print(e);
      _showErrorDialog('Failed to pick image');
    }
  }

  Future<void> fetchUserProfileData() async {
    setState(() {
      isLoading = true;
    });
    final token = await TokenManager.getToken();
    const String baseUrl = ApiConstants.baseUrl;
    const String apiUrl = '$baseUrl/api/user-profile';
    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 401) {
        LogoutService.logout();
      }
      if (response.statusCode >= 200 && response.statusCode <= 209) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        setState(() {
          fullNameController.text = jsonData['fullName'] ?? '';
          pronounsController.text = jsonData['pronouns'] ?? '';
          roleController.text = jsonData['role'] ?? '';
          departmentController.text = jsonData['department'] ?? '';
          emailController.text = jsonData['email'] ?? '';
          aboutMeController.text = jsonData['about'] ?? '';
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      _showErrorDialog('Failed to load profile data: $e');
    }
  }

  Future<void> fetchProfileImageData() async {
    final token = await TokenManager.getToken();
    const String baseUrl = ApiConstants.baseUrl;
    const String apiUrl = '$baseUrl/api/retrieve-image';

    print('Image URL: $apiUrl');
    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 401) {
        LogoutService.logout();
      }
      if (response.statusCode >= 200 && response.statusCode <= 209) {
        String responseData = response.body.replaceAll('"}', ''); // Remove trailing '"}'
        print("Response: $responseData");
        // Find the index of the comma (",") after the prefix
        final commaIndex = responseData.indexOf(',');
        if (commaIndex != -1) {
          final imageData = responseData.substring(commaIndex + 1);
          // Decode base64-encoded image data
          final bytes = base64Decode(imageData);
          setState(() {
            _imageBytes = bytes;
          });
          print('Image data is decoded.');
        } else {
          print('Invalid image data format');
        }
      } else {
        print('Failed to load image data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching image data: $e');
    }
  }

  Future<void> _submitImage() async {
    if (_imageBytes == null || _imageFileName == null) {
      _showErrorDialog('Please select an image first.');
      return;
    }
    try {
      final token = await TokenManager.getToken();
      await apiService.createFile(_imageBytes!, _imageFileName!, token!);
      _showSuccessDialog('Image uploaded successfully');
    } catch (e) {
      _showErrorDialog('Failed to upload image: $e');
    }
  }

  Future<void> _updateProfile() async {
    if (_formKey.currentState!.validate()) {
      final profileData = {
        'fullName': fullNameController.text,
        'email': emailController.text,
      };

      final token = await TokenManager.getToken();
      const String baseUrl = ApiConstants.baseUrl;
      const String apiUrl = '$baseUrl/api/updateAppUser';
      try {
        final response = await http.put(
          Uri.parse(apiUrl),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
          body: json.encode(profileData),
        );
        if (response.statusCode == 401) {
          LogoutService.logout();
        }
        if (response.statusCode <= 209) {
          Navigator.of(context).pop();
        } else {
          print(response.statusCode);
        }
      } catch (e) {
        _showErrorDialog('Failed to update profile: $e');
      }
    }
  }

  Future<void> _logoutUser() async {
    try {
      String logouturl = "${ApiConstants.baseUrl}/token/logout";
      var response = await http.get(Uri.parse(logouturl));
      if (response.statusCode <= 209) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreenF(false)),
              (route) => false,
        );
      } else {
        _showErrorDialog('Failed to logout');
      }
    } catch (error) {
      _showErrorDialog('Error occurred during logout: $error');
    }
  }

  Future<void> _logoutAllSessions() async {
    try {
      String logouturl = "${ApiConstants.baseUrl}/token/logout/allsessions";
      var response = await http.get(Uri.parse(logouturl));
      if (response.statusCode <= 209) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreenF(false)),
              (route) => false,
        );
      } else {
        _showErrorDialog('Failed to logout');
      }
    } catch (error) {
      _showErrorDialog('Error occurred during logout: $error');
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
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

  void _showSuccessDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Success'),
          content: Text(message),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey[200],
        title: Text("Edit Profile",style: CustomTextStyles.titleLargePoppinsBlack,),
        leading:  GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color:const Color(0xFF219ebc),
                  borderRadius: BorderRadius.circular(12)
              ),
              child: const Icon(Icons.arrow_back_ios_new,color: Colors.white,),
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBarWidget(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const SizedBox(height: 24),
            isLoading ? const Center(child: CircularProgressIndicator()) : GestureDetector(
              onTap: _uploadImageFile,
              child: Center(
                child: Stack(

                  children: [
                    CircleAvatar(
                      radius: 100,
                      backgroundImage: _imageBytes != null ? MemoryImage(_imageBytes!) : AssetImage(ImageConstant.editModel) as ImageProvider,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 5,
                      child: IconButton(
                        onPressed: _uploadImageFile,
                        icon: const Icon(Icons.camera_alt),
                        color: Colors.grey[800],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Full Name",style: TextStyle(color: Colors.black),),
                  CustomTextFormField(
                    controller: fullNameController,
                    hintText: 'Full Name',
                    validator: (value) => value!.isEmpty ? 'Please enter your full name' : null,
                  ),
                  const SizedBox(height: 16),
                  const Text("Pronouns",style: TextStyle(color: Colors.black),),
                  CustomTextFormField(
                    controller: pronounsController,
                    hintText: 'Pronouns',
                  ),
                  const SizedBox(height: 16),
                  const Text("Role",style: TextStyle(color: Colors.black),),
                  CustomTextFormField(
                    controller: roleController,
                    hintText: 'Role',
                  ),
                  const SizedBox(height: 16),
                  const Text("Department",style: TextStyle(color: Colors.black),),
                  CustomTextFormField(
                    controller: departmentController,
                    hintText: 'Department',
                  ),
                  const SizedBox(height: 16),
                  const Text("Email",style: TextStyle(color: Colors.black),),
                  CustomTextFormField(
                    controller: emailController,
                    hintText: 'Email',
                    validator: (value) => value!.isEmpty ? 'Please enter your email' : null,
                  ),
                  const SizedBox(height: 16),
                  const Text("About me",style: TextStyle(color: Colors.black),),
                  CustomTextFormField(
                    controller: aboutMeController,
                    hintText: 'About Me',
                    maxLines: 3,
                  ),
                  const SizedBox(height: 24),
                  CustomButton(
                    text: 'Update Profile',
                    onTap: _updateProfile,
                  ),
                  const SizedBox(height: 16),
                  CustomButton(
                    text: 'Upload Image',
                    onTap: _submitImage,
                  ),
                  const SizedBox(height: 16),
                  CustomButton(
                    text: 'Logout',
                    onTap: _logoutUser,
                  ),
                  const SizedBox(height: 16),
                  CustomButton(
                    text: 'Logout All Sessions',
                    onTap: _logoutAllSessions,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}