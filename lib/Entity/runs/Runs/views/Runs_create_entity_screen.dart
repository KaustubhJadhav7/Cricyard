// ignore_for_file: use_build_context_synchronously
import 'package:cricyard/Entity/runs/Runs/model/Runs_model.dart';
import 'package:cricyard/Entity/runs/Runs/viewmodel/Runs_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../Utils/image_constant.dart';
import '../../../../Utils/size_utils.dart';
import '../../../../theme/app_style.dart';
import '../../../../views/widgets/app_bar/appbar_image.dart';
import '../../../../views/widgets/app_bar/appbar_title.dart';
import '../../../../views/widgets/app_bar/custom_app_bar.dart';
import '../../../../views/widgets/custom_button.dart';
import '../../../../views/widgets/custom_text_form_field.dart';

import '../repository/Runs_api_service.dart';
import '/providers/token_manager.dart';
import 'package:flutter/services.dart';

class runsCreateEntityScreen extends StatefulWidget {
  const runsCreateEntityScreen({super.key});

  @override
  _runsCreateEntityScreenState createState() => _runsCreateEntityScreenState();
}

class _runsCreateEntityScreenState extends State<runsCreateEntityScreen> {
  final runsApiService apiService = runsApiService();
  final RunsEntity formData = RunsEntity(
    id: 0, // Or any default value
    description: '',
    active: false,
    numberOfRuns: 0,
    selectField: '',
  );
  final _formKey = GlobalKey<FormState>();

  bool isactive = false;

  List<Map<String, dynamic>> select_fieldItems = [];
  var selectedselect_fieldValue = ''; // Use nullable type  Future<void> _load
  Future<void> _loadselect_fieldItems() async {
    final token = await TokenManager.getToken();
    try {
      final selectTdata = await apiService.getselectField();
      print(' select_field   data is : $selectTdata');
      // Handle null or empty dropdownData
      if (selectTdata != null && selectTdata.isNotEmpty) {
        setState(() {
          select_fieldItems = selectTdata;
        });
      } else {
        print(' select_field   data is null or empty');
      }
    } catch (e) {
      print('Failed to load  select_field   items: $e');
    }
  }

  @override
  void initState() {
    super.initState();

    _loadselect_fieldItems();
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
    final provider = Provider.of<RunsEntitiesProvider>(context, listen: false);
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
          title: AppbarTitle(text: "Create Runs")),
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

                              onsaved: (value) => formData.description = value,
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

                Padding(
                    padding: getPadding(top: 19),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Number of Runs",
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: AppStyle.txtGilroyMedium16Bluegray900),
                          CustomTextFormField(
                              focusNode: FocusNode(),
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9]'))
                              ],
// ValidationProperties

                              hintText: "Enter Number of Runs",
                              onsaved: (value) {
                                if (value != null && value.isNotEmpty) {
                                  formData.numberOfRuns = int.parse(
                                      value); // Parse the string to int
                                }
                              },
                              margin: getMargin(top: 6))
                        ])),

                SizedBox(height: 16),

// DropdownButtonFormField with default value and null check
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: 'select Field'),
                  value: selectedselect_fieldValue,
                  items: [
                    // Add an item with an empty value to represent no selection
                    const DropdownMenuItem<String>(
                      value: '',
                      child: Text('Select option'),
                    ),
                    // Map your dropdownItems as before
                    ...select_fieldItems.map<DropdownMenuItem<String>>(
                      (item) {
                        return DropdownMenuItem<String>(
                          value: item['player_name'].toString(),
                          child: Text(item['player_name'].toString()),
                        );
                      },
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      selectedselect_fieldValue = value!;
                    });
                  },
                  onSaved: (value) {
                    if (selectedselect_fieldValue.isEmpty) {
                      selectedselect_fieldValue = "no value";
                    }
                    formData.selectField = selectedselect_fieldValue;
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

                      formData.active = isactive;

                      try {
                        print(formData);
                        await provider.createEntity(formData);

                        Navigator.pop(context);
                      } catch (e) {
                        // ignore: use_build_context_synchronously
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Error'),
                              content: Text('Failed to create Runs: $e'),
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
