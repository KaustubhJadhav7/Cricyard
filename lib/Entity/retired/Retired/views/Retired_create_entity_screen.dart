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
import '../../../../views/widgets/custom_dropdown_field.dart';

import '../viewmodels/Retired_api_service.dart';
import '/providers/token_manager.dart';
import 'package:flutter/services.dart';

class retiredCreateEntityScreen extends StatefulWidget {
  const retiredCreateEntityScreen({super.key});

  @override
  _retiredCreateEntityScreenState createState() =>
      _retiredCreateEntityScreenState();
}

class _retiredCreateEntityScreenState extends State<retiredCreateEntityScreen> {
  final RetiredApiService apiService = RetiredApiService();
  final Map<String, dynamic> formData = {};
  final _formKey = GlobalKey<FormState>();

  bool isactive = false;

  var selectedplayer_name; // Initialize with the default value \n");
  List<String> player_nameList = [
    '  bar_code  ',
    '  qr_code  ',
  ];

  String? selectedcan_batter_bat_again;
  Future<void> _showcan_batter_bat_againSelectionDialog(
      BuildContext context) async {
    final result = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Select can_batter_bat_again'),
          children: [
            RadioListTile<String>(
              title: const Text('bar_code'),
              value: 'bar_code',
              groupValue: selectedcan_batter_bat_again,
              onChanged: (value) {
                setState(() {
                  selectedcan_batter_bat_again = value;
                  Navigator.pop(context, value);
                });
              },
            ),
            RadioListTile<String>(
              title: const Text('qr_code'),
              value: 'qr_code',
              groupValue: selectedcan_batter_bat_again,
              onChanged: (value) {
                setState(() {
                  selectedcan_batter_bat_again = value;
                  Navigator.pop(context, value);
                });
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
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
          title: AppbarTitle(text: "Create Retired")),
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
                          Text("Description",
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: AppStyle.txtGilroyMedium16Bluegray900),
                          CustomTextFormField(
                              maxLines: 5,
                              focusNode: FocusNode(),
                              hintText: "Enter Description",
                              // ValidationProperties

                              onsaved: (value) =>
                                  formData['description'] = value,
                              margin: getMargin(top: 6))
                        ])),
                SizedBox(height: 16),
                Switch(
                  value: isactive,
                  onChanged: (newValue) {
                    setState(() {
                      isactive = newValue;
                    });
                  },
                ),
                const SizedBox(width: 8),
                const Text('Active'),
                CustomDropdownFormField(
                  value: selectedplayer_name,
                  items: [
                    DropdownMenuItem<String>(
                      value: '',
                      child: Text(
                        'Choose player_name',
                        style: AppStyle.txtGilroyMedium16Bluegray900,
                      ),
                    ),
                    ...player_nameList.map<DropdownMenuItem<String>>((item) {
                      return DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: AppStyle.txtGilroyMedium16Bluegray900,
                        ),
                      );
                    }),
                  ],
                  onChanged: (value) {
                    setState(() {
                      var selectedplayer_name = value!;
                      formData['player_name'] = value;
                    });
                  },
                  // ValidationProperties

                  onSaved: (value) {
                    if (selectedplayer_name.isEmpty) {
                      selectedplayer_name = "no value";
                    }
                    formData['player_name'] = selectedplayer_name;
                  },
                ),
                const SizedBox(height: 16),
                Padding(
                    padding: getPadding(top: 19),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Can Batter bat again",
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: AppStyle.txtGilroyMedium16Bluegray900),
                          CustomTextFormField(
                              focusNode: FocusNode(),
                              hintText: "Enter Can Batter bat again",
                              readOnly: true,
                              controller: TextEditingController(
                                  text: selectedcan_batter_bat_again),
                              onTap: () =>
                                  _showcan_batter_bat_againSelectionDialog(
                                      context),

// ValidationProperties
                              onsaved: (value) {
                                formData['can_batter_bat_again'] = value;
                              },
                              margin: getMargin(top: 6))
                        ])),
                const SizedBox(height: 16),
                const SizedBox(width: 8),
                CustomButton(
                  height: getVerticalSize(50),
                  text: "Submit",
                  margin: getMargin(top: 24, bottom: 5),
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();

                      formData['active'] = isactive;

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
                              content: Text('Failed to create Retired: $e'),
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