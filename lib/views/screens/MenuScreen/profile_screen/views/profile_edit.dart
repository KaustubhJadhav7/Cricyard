import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // For selecting images
import '../../../../../theme/theme_helper.dart';
import '../../../../widgets/custom_elevated_button.dart';
import '../viewmodel/api_service_profile_management.dart'; // Your API service class

class ProfileEditScreen extends StatefulWidget {
  @override
  _ProfileEditScreenState createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  Uint8List? _profileImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildProfileImagePicker(),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an email';
                  }
                  return null;
                },
              ),
              // SizedBox(height: 20),
              // ElevatedButton(
              //   onPressed: _onSubmit,
              //   child: const Text('Save Changes'),
              // ),

                                  const SizedBox(height: 29),
                    CustomElevatedButton(
                      onPressed: _onSubmit,
                      text: "Submit",
                      margin: const EdgeInsets.only(
                        left: 17,
                        right: 6,
                      ),
                      buttonTextStyle: theme.textTheme.titleMedium!,
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileImagePicker() {
    return Column(
      children: [
        if (_profileImage != null)
          CircleAvatar(
            radius: 40,
            backgroundImage: MemoryImage(_profileImage!),
          ),
        TextButton(
          onPressed: _pickImage,
          child: Text('Change Profile Picture'),
        ),
      ],
    );
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      setState(() {
        _profileImage = bytes;
      });
    }
  }

  Future<void> _onSubmit() async {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text;
      final email = _emailController.text;

      // Simulate token retrieval; you'd get this from your authentication flow
      final token = 'YOUR_TOKEN_HERE'; 

      final apiService = ApiServiceProfileManagement();

      if (_profileImage != null) {
        // Upload the profile image
        await apiService.createFile(_profileImage!, 'profile_picture.jpg', token);
      }

      // Perform other actions with name, email, etc.
      // You'd likely send this to your backend as well.
      print('Profile updated with name: $name, email: $email');
    }
  }
}