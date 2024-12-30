import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import '../../../Utils/image_constant.dart';
import '../../../Utils/size_utils.dart';
import '../../../views/widgets/app_bar/appbar_image.dart';
import '../../../views/widgets/app_bar/appbar_title.dart';
import '../../../views/widgets/app_bar/custom_app_bar.dart';
import '../../../views/widgets/custom_button.dart';
import '../../../views/widgets/custom_text_form_field.dart';

import '../viewmodels/Teams_api_service.dart';
import '/providers/token_manager.dart';
import 'package:flutter/services.dart';

class TeamsCreateEntityScreen extends StatefulWidget {
  const TeamsCreateEntityScreen({super.key});

  @override
  _TeamsCreateEntityScreenState createState() =>
      _TeamsCreateEntityScreenState();
}

class _TeamsCreateEntityScreenState extends State<TeamsCreateEntityScreen> {
  final teamsApiService apiService = teamsApiService();
  final Map<String, dynamic> formData = {};
  final _formKey = GlobalKey<FormState>();

  Uint8List? _logoImageBytes; // Uint8List to store the image data
  String? _logoImageFileName; // String to store the image file name
  bool isActive = false;
  bool _addMyself = false; // Track the state of the "Add myself" checkbox

  @override
  void initState() {
    super.initState();
  }

  Future<void> _pickImage(ImageSource source) async {
    final imagePicker = ImagePicker();

    try {
      final pickedImage = await imagePicker.pickImage(source: source);

      if (pickedImage != null) {
        final imageBytes = await pickedImage.readAsBytes();

        setState(() {
          _logoImageBytes = imageBytes;
          _logoImageFileName = pickedImage.name; // Store the file name
        });
      }
    } catch (e) {
      print(e);
    }
  }

  void _showImageSourceDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Choose Image Source'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _pickImage(ImageSource.gallery);
              },
              child: const Text('Gallery'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _pickImage(ImageSource.camera);
              },
              child: const Text('Camera'),
            ),
          ],
        );
      },
    );
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
          title: AppbarTitle(text: "Create Team")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: getPadding(top: 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Center(
                        child: Stack(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.grey,
                              radius: 100,
                              backgroundImage: _logoImageBytes != null
                                  ? MemoryImage(_logoImageBytes!)
                                  : null,
                              child: _logoImageBytes == null
                                  ? const Text(
                                'Logo Not Available',
                                style: TextStyle(color: Colors.black),
                              )
                                  : null,
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: IconButton(
                                icon: const Icon(Icons.add_a_photo),
                                onPressed: _showImageSourceDialog,
                              ),
                            ),
                          ],
                        ),
                      ),
                       Center(
                        child: Text(
                          "Team Logo",
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: GoogleFonts.getFont('Poppins',color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),
                        ),
                      ),
                      const SizedBox(height: 16),
                       Text(
                        "Team Name",
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style:GoogleFonts.getFont('Poppins',color: Colors.black,fontWeight: FontWeight.w500,fontSize: 16),
                      ),
                      CustomTextFormField(
                        focusNode: FocusNode(),
                        hintText: "Please Enter Team Name",
                        onsaved: (value) => formData['team_name'] = value,
                      ),
                      const SizedBox(height: 16),
                       Text(
                        "Description",
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: GoogleFonts.getFont('Poppins',color: Colors.black,fontWeight: FontWeight.w500,fontSize: 16),
                      ),
                      CustomTextFormField(
                        maxLines: 5,
                        focusNode: FocusNode(),
                        hintText: "Enter Description",
                        onsaved: (value) => formData['description'] = value,
                        margin: getMargin(top: 6),
                      ),
                      const SizedBox(height: 16),
                      CheckboxListTile(
                        title:  Text("Add myself",style: GoogleFonts.getFont('Poppins',color: Colors.black,fontWeight: FontWeight.w500,fontSize: 18),),
                        value: _addMyself,
                        onChanged: (bool? value) {
                          setState(() {
                            _addMyself = value!;
                          });
                        },
                      ),
                      Switch(
                        value: isActive,
                        onChanged: (newValue) {
                          setState(() {
                            isActive = newValue;
                          });
                        },
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Active',
                        style: TextStyle(color: Colors.black),
                      ),
                      const SizedBox(height: 16),
                      CustomButton(
                        height: getVerticalSize(50),
                        text: "Submit",
                        margin: getMargin(top: 24, bottom: 5),
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();

                            formData['active'] = isActive;
                            formData['add_myself'] = _addMyself; // Include the checkbox state

                            final token = await TokenManager.getToken();
                            try {
                              print(formData);
                              Map<String, dynamic> createdEntity =
                              await apiService.createEntity(token!, formData);

                              if (_logoImageBytes != null && _logoImageFileName != null) {
                                await apiService.uploadLogoImage(
                                  token,
                                  createdEntity['id'].toString(),
                                  'Teams',
                                  _logoImageFileName!,
                                  _logoImageBytes!,
                                );
                              }

                              Navigator.pop(context);
                            } catch (e) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Error'),
                                    content: Text('Failed to create Teams: $e',style: const TextStyle(color: Colors.black),),
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
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
