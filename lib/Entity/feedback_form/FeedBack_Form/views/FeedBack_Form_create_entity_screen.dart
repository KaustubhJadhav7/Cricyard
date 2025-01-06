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

import '../repository/FeedBack_Form_api_service.dart';
import '../viewmodel/FeedBack_Form_viewmodel.dart';
import 'package:flutter/services.dart';

class feedback_formCreateEntityScreen extends StatefulWidget {
  const feedback_formCreateEntityScreen({super.key});

  @override
  _feedback_formCreateEntityScreenState createState() =>
      _feedback_formCreateEntityScreenState();
}

class _feedback_formCreateEntityScreenState
    extends State<feedback_formCreateEntityScreen> {
  final FeedbackFormApiService apiService = FeedbackFormApiService();
  // final Map<String, dynamic> formData = {};
  // final _formKey = GlobalKey<FormState>();

  // bool isemail_fieldEmailValid = true;
  // void validateemail_fieldEmail(String email) {
  //   setState(() {
  //     isemail_fieldEmailValid =
  //         RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$').hasMatch(email);
  //   });
  // }

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
    final feedbackProvider = Provider.of<FeedbackProvider>(context, listen: false);
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
          title: AppbarTitle(text: "Create FeedBack_Form")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: feedbackProvider.formKey,
            child: Column(
              children: [
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
                          onsaved: (value) => feedbackProvider.formData['name'] = value,
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
                          Text("Phone Number",
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: AppStyle.txtGilroyMedium16Bluegray900),
                          CustomTextFormField(
                              focusNode: FocusNode(),
                              hintText: "Enter Phone Number",
                              onsaved: (value) =>
                                  feedbackProvider.formData['phone_number'] = value,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              keyboardType: TextInputType.number,
                              maxLength: 10,
                              margin: getMargin(top: 6))
                        ])),
                Padding(
                    padding: getPadding(top: 19),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Email Field",
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: AppStyle.txtGilroyMedium16Bluegray900),
                          CustomTextFormField(
                              focusNode: FocusNode(),
                              hintText: "Enter Email Field",
                              errorText: feedbackProvider.isEmailFieldEmailValid
                                  ? null
                                  : 'Please enter a valid email',
                              onsaved: (value) =>
                                  feedbackProvider.formData['email_field'] = value,
                              onChanged: (value) {
                                feedbackProvider.validateEmailFieldEmail(value);
                              },
                              margin: getMargin(top: 6))
                        ])),
                Padding(
                    padding: getPadding(top: 19),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Share Your Experience",
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: AppStyle.txtGilroyMedium16Bluegray900),
                          CustomTextFormField(
                              maxLines: 5,
                              focusNode: FocusNode(),
                              hintText: "Enter Share Your Experience",
                              onsaved: (value) =>
                                  feedbackProvider.formData['share_your_experience'] = value,
                              margin: getMargin(top: 6))
                        ])),
                const SizedBox(width: 8),
                CustomButton(
                  height: getVerticalSize(50),
                  text: "Submit",
                  margin: getMargin(top: 24, bottom: 5),
                  onTap: () async {
                    if (feedbackProvider.formKey.currentState!.validate()) {
                      feedbackProvider.formKey.currentState!.save();

                      // final token = await TokenManager.getToken();
                      try {
                        print(feedbackProvider.formData);
                        Map<String, dynamic> createdEntity =
                          await apiService.createEntity(feedbackProvider.formData);

                        Navigator.pop(context);
                      } catch (e) {
                        // ignore: use_build_context_synchronously
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Error'),
                              content:
                                  Text('Failed to create FeedBack_Form: $e'),
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