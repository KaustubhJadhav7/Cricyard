// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import '../../../../Utils/image_constant.dart';
import '../../../../Utils/size_utils.dart';
import '../../../../theme/app_style.dart';
import '../../../../views/widgets/app_bar/appbar_image.dart';
import '../../../../views/widgets/app_bar/appbar_title.dart';
import '../../../../views/widgets/app_bar/custom_app_bar.dart';
import '../../../../views/widgets/custom_button.dart';
import '../../../../views/widgets/custom_dropdown_field.dart';
import 'package:intl/intl.dart';

import '../viewmodels/Start_inning_api_service.dart';
import '/providers/token_manager.dart';

class start_inningCreateEntityScreen extends StatefulWidget {
  const start_inningCreateEntityScreen({super.key});

  @override
  _start_inningCreateEntityScreenState createState() =>
      _start_inningCreateEntityScreenState();
}

class _start_inningCreateEntityScreenState
    extends State<start_inningCreateEntityScreen> {
  final start_inningApiService apiService = start_inningApiService();
  final Map<String, dynamic> formData = {};
  final _formKey = GlobalKey<FormState>();

  var selectedselect_match; // Initialize with the default value \n");
  List<String> select_matchList = [
    '  bar_code  ',
    '  qr_code  ',
  ];

  var selectedselect_team; // Initialize with the default value \n");
  List<String> select_teamList = [
    '  bar_code  ',
    '  qr_code  ',
  ];

  var selectedselect_player; // Initialize with the default value \n");
  List<String> select_playerList = [
    '  bar_code  ',
    '  qr_code  ',
  ];

  DateTime selectedDateTime = DateTime.now();
  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDateTime,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(selectedDateTime),
      );
      print(pickedTime);
      if (pickedTime != null) {
        setState(() {
          selectedDateTime = DateTime(
            picked.year,
            picked.month,
            picked.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
    }
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
          title: AppbarTitle(text: "Create Start_inning")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                CustomDropdownFormField(
                  value: selectedselect_match,
                  items: [
                    DropdownMenuItem<String>(
                      value: '',
                      child: Text(
                        'Choose select_match',
                        style: AppStyle.txtGilroyMedium16Bluegray900,
                      ),
                    ),
                    ...select_matchList.map<DropdownMenuItem<String>>((item) {
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
                      var selectedselect_match = value!;
                      formData['select_match'] = value;
                    });
                  },
                  // ValidationProperties

                  onSaved: (value) {
                    if (selectedselect_match.isEmpty) {
                      selectedselect_match = "no value";
                    }
                    formData['select_match'] = selectedselect_match;
                  },
                ),
                const SizedBox(height: 16),
                CustomDropdownFormField(
                  value: selectedselect_team,
                  items: [
                    DropdownMenuItem<String>(
                      value: '',
                      child: Text(
                        'Choose select_team',
                        style: AppStyle.txtGilroyMedium16Bluegray900,
                      ),
                    ),
                    ...select_teamList.map<DropdownMenuItem<String>>((item) {
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
                      var selectedselect_team = value!;
                      formData['select_team'] = value;
                    });
                  },
                  // ValidationProperties

                  onSaved: (value) {
                    if (selectedselect_team.isEmpty) {
                      selectedselect_team = "no value";
                    }
                    formData['select_team'] = selectedselect_team;
                  },
                ),
                const SizedBox(height: 16),
                CustomDropdownFormField(
                  value: selectedselect_player,
                  items: [
                    DropdownMenuItem<String>(
                      value: '',
                      child: Text(
                        'Choose select_player',
                        style: AppStyle.txtGilroyMedium16Bluegray900,
                      ),
                    ),
                    ...select_playerList.map<DropdownMenuItem<String>>((item) {
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
                      var selectedselect_player = value!;
                      formData['select_player'] = value;
                    });
                  },
                  // ValidationProperties

                  onSaved: (value) {
                    if (selectedselect_player.isEmpty) {
                      selectedselect_player = "no value";
                    }
                    formData['select_player'] = selectedselect_player;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  initialValue:
                      DateFormat('yyyy-MM-dd HH:mm').format(selectedDateTime),
                  decoration: const InputDecoration(
                    labelText: 'datetime_field',
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                  readOnly: true,
                  onTap: () => _selectDateTime(context),
                  onSaved: (value) {
                    formData['datetime_field'] =
                        DateFormat('yyyy-MM-dd HH:mm').format(selectedDateTime);
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
                              content:
                                  Text('Failed to create Start_inning: $e'),
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