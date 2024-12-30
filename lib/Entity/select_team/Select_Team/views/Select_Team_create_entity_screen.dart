// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import '../../../../Utils/image_constant.dart';
import '../../../../Utils/size_utils.dart';
import '../../../../theme/app_style.dart';
import '../../../../views/widgets/app_bar/appbar_image.dart';
import '../../../../views/widgets/app_bar/appbar_title.dart';
import '../../../../views/widgets/app_bar/custom_app_bar.dart';
import '../../../../views/widgets/custom_button.dart';
import '../../../../views/widgets/custom_text_form_field.dart';

import '../viewmodel/Select_Team_api_service.dart';
import '/providers/token_manager.dart';
import 'package:flutter/services.dart';

class select_teamCreateEntityScreen extends StatefulWidget {
  const select_teamCreateEntityScreen({super.key});

  @override
  _select_teamCreateEntityScreenState createState() =>
      _select_teamCreateEntityScreenState();
}

class _select_teamCreateEntityScreenState
    extends State<select_teamCreateEntityScreen> {
  final SelectTeamApiService apiService = SelectTeamApiService();
  final Map<String, dynamic> formData = {};
  final _formKey = GlobalKey<FormState>();

  List<Map<String, dynamic>> team_nameItems = [];
  var selectedteam_nameValue = ''; // Use nullable type  Future<void> _load
  Future<void> _loadteam_nameItems() async {
    final token = await TokenManager.getToken();
    try {
      final selectTdata = await apiService.getTeamName(token!);
      print(' team_name   data is : $selectTdata');
      // Handle null or empty dropdownData
      if (selectTdata != null && selectTdata.isNotEmpty) {
        setState(() {
          team_nameItems = selectTdata;
        });
      } else {
        print(' team_name   data is null or empty');
      }
    } catch (e) {
      print('Failed to load  team_name   items: $e');
    }
  }

  @override
  void initState() {
    super.initState();

    _loadteam_nameItems();
  }

  // Future<void> performOCR() async {
  //   try {
  //     final ImagePicker _picker = ImagePicker();

  //     // Show options for gallery or camera using a dialog
  //     await showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           title: const Text('Select Image Source'),
  //           content: SingleChildScrollView(
  //             child: ListBody(
  //               children: <Widget>[
  //                 GestureDetector(
  //                   child: const Text('Gallery'),
  //                   onTap: () async {
  //                     Navigator.of(context).pop();
  //                     final XFile? image =
  //                         await _picker.pickImage(source: ImageSource.gallery);
  //                     processImage(image);
  //                   },
  //                 ),
  //                 const SizedBox(height: 20),
  //                 GestureDetector(
  //                   child: const Text('Camera'),
  //                   onTap: () async {
  //                     Navigator.of(context).pop();
  //                     final XFile? image =
  //                         await _picker.pickImage(source: ImageSource.camera);
  //                     processImage(image);
  //                   },
  //                 ),
  //               ],
  //             ),
  //           ),
  //         );
  //       },
  //     );
  //   } catch (e) {
  //     print("OCR Error: $e");
  //     // Handle OCR errors here
  //   }
  // }

  // final textRecognizer = TextRecognizer();

  // void processImage(XFile? image) async {
  //   if (image == null) return; // User canceled image picking

  //   final file = File(image.path);

  //   final inputImage = InputImage.fromFile(file);
  //   final recognizedText = await textRecognizer.processImage(inputImage);

  //   StringBuffer extractedTextBuffer = StringBuffer();
  //   for (TextBlock block in recognizedText.blocks) {
  //     for (TextLine line in block.lines) {
  //       extractedTextBuffer.write(line.text + ' ');
  //     }
  //   }

  //   textRecognizer.close();

  //   String extractedText = extractedTextBuffer.toString().trim();

  //   // Now you can process the extracted text as needed
  //   // For example, you can update the corresponding TextFormField with the extracted text
  //   setState(() {
  //     formData['description'] = extractedText;
  //   });
  // }

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
          title: AppbarTitle(text: "Create Select_Team")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                    padding: getPadding(top: 19),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Team Name",
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: AppStyle.txtGilroyMedium16Bluegray900),
                          CustomTextFormField(
                              maxLines: 5,
                              focusNode: FocusNode(),
                              hintText: "Enter Team Name",
                              // ValidationProperties

                              onsaved: (value) => formData['team_name'] = value,
                              margin: getMargin(top: 6))
                        ])),

                SizedBox(height: 16),

// DropdownButtonFormField with default value and null check
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: 'Team Name'),
                  value: selectedteam_nameValue,
                  items: [
                    // Add an item with an empty value to represent no selection
                    const DropdownMenuItem<String>(
                      value: '',
                      child: Text('Select option'),
                    ),
                    // Map your dropdownItems as before
                    ...team_nameItems.map<DropdownMenuItem<String>>(
                      (item) {
                        return DropdownMenuItem<String>(
                          value: item['team_name'].toString(),
                          child: Text(item['team_name'].toString()),
                        );
                      },
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      selectedteam_nameValue = value!;
                    });
                  },
                  onSaved: (value) {
                    if (selectedteam_nameValue.isEmpty) {
                      selectedteam_nameValue = "no value";
                    }
                    formData['team_name'] = selectedteam_nameValue;
                  },
                ),
                const SizedBox(height: 16),

                const SizedBox(width: 8),
                CustomButton(
                  height: getVerticalSize(50),
                  text: "Submit",
                  margin: getMargin(top: 24, bottom: 5),
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();

                      final token = await TokenManager.getToken();
                      try {
                        print(formData);
                        Map<String, dynamic> createdEntity =
                            await apiService.createEntity(token!, formData);

                        Navigator.pop(context);
                      } catch (e) {
                        // ignore: use_build_context_synchronously
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Error'),
                              content: Text('Failed to create Select_Team: $e'),
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
        ),
      ),
    );
  }
}