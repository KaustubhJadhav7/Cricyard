// ignore_for_file: use_build_context_synchronously
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
import '../../../../views/widgets/custom_dropdown_field.dart';

import '../repository/Find_Friends_api_service.dart';
import '../viewmodel/Find_Friends_viewmodel.dart';
import '/providers/token_manager.dart';
import 'package:flutter/services.dart';

class find_friendsCreateEntityScreen extends StatefulWidget {
  const find_friendsCreateEntityScreen({super.key});

  @override
  _find_friendsCreateEntityScreenState createState() =>
      _find_friendsCreateEntityScreenState();
}

class _find_friendsCreateEntityScreenState
    extends State<find_friendsCreateEntityScreen> {
  final FindFriendsApiService apiService = FindFriendsApiService();
  // final Map<String, dynamic> formData = {};
  // final _formKey = GlobalKey<FormState>();

  var selectedfind_friends; // Initialize with the default value \n");
  List<String> find_friendsList = [
    '  bar_code  ',
    '  qr_code  ',
  ];

  bool isactive = false;

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
    final friendsProvider =
        Provider.of<FindFriendsProvider>(context, listen: false);
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
          title: AppbarTitle(text: "Create Find_Friends")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: friendsProvider.model.formKey,
            child: Column(
              children: [
                CustomDropdownFormField(
                  value: selectedfind_friends,
                  items: [
                    DropdownMenuItem<String>(
                      value: '',
                      child: Text(
                        'Choose find_friends',
                        style: AppStyle.txtGilroyMedium16Bluegray900,
                      ),
                    ),
                    ...find_friendsList.map<DropdownMenuItem<String>>((item) {
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
                      var selectedfind_friends = value!;
                      friendsProvider.model.formData['find_friends'] = value;
                    });
                  },
                  // ValidationProperties

                  onSaved: (value) {
                    if (selectedfind_friends.isEmpty) {
                      selectedfind_friends = "no value";
                    }
                    friendsProvider.model.formData['find_friends'] = selectedfind_friends;
                  },
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: getPadding(top: 18),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Name",
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: AppStyle.fieldlabel),
                        CustomTextFormField(
                          focusNode: FocusNode(),
                          hintText: "Please Enter Name",
                          onsaved: (value) => friendsProvider.model.formData['name'] = value,
                        )
                      ]),
                ),
                const SizedBox(height: 16),
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
                              onsaved: (value) =>
                                  friendsProvider.model.formData['description'] = value,
                              margin: getMargin(top: 6))
                        ])),
                Switch(
                  value: friendsProvider.isActive,
                  onChanged: (newValue) {
                    friendsProvider.toggleIsActive(newValue);
                  },
                ),
                const SizedBox(width: 8),
                const Text('Active'),
                const SizedBox(width: 8),
                CustomButton(
                  height: getVerticalSize(50),
                  text: "Submit",
                  margin: getMargin(top: 24, bottom: 5),
                  onTap: () async {
                    if (friendsProvider.model.formKey.currentState!.validate()) {
                      friendsProvider.model.formKey.currentState!.save();

                      friendsProvider.model.formData['active'] = isactive;

                      // final token = await TokenManager.getToken();
                      try {
                        print(friendsProvider.model.formData);
                        Map<String, dynamic> createdEntity =
                            await apiService.createEntity(friendsProvider.model.formData);

                        Navigator.pop(context);
                      } catch (e) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Error'),
                              content:
                                  Text('Failed to create Find_Friends: $e'),
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