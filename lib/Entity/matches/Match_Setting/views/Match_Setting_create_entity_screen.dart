// // ignore_for_file: use_build_context_synchronously
// import 'package:flutter/material.dart';
// import '../../../../Utils/image_constant.dart';
// import '../../../../Utils/size_utils.dart';
// import '../../../../theme/app_style.dart';
// import '../../../../views/widgets/app_bar/appbar_image.dart';
// import '../../../../views/widgets/app_bar/appbar_title.dart';
// import '../../../../views/widgets/app_bar/custom_app_bar.dart';
// import '../../../../views/widgets/custom_button.dart';
// import '../../../../views/widgets/custom_text_form_field.dart';

// import '../repository/Match_Setting_api_service.dart';
// import '/providers/token_manager.dart';
// // import 'package:flutter/services.dart';

// class match_settingCreateEntityScreen extends StatefulWidget {
//   const match_settingCreateEntityScreen({super.key});

//   @override
//   _match_settingCreateEntityScreenState createState() =>
//       _match_settingCreateEntityScreenState();
// }

// class _match_settingCreateEntityScreenState
//     extends State<match_settingCreateEntityScreen> {
//   final MatchSettingApiService apiService = MatchSettingApiService();
//   final Map<String, dynamic> formData = {};
//   final _formKey = GlobalKey<FormState>();

//   bool isactive = false;

//   bool isdisable_wagon_wheel_for_dot_ball = false;

//   bool isdisable_wagon_wheel_for_1s_2s_and_3s = false;

//   bool isdisable_shot_selection = false;

//   bool iscount_wide_as_a_legal_delivery = false;

//   bool iscount_no_ball_as_a_legal_delivery = false;

//   @override
//   void initState() {
//     super.initState();
//   }

//   // Future<void> performOCR() async {
//   //   try {
//   //     final ImagePicker _picker = ImagePicker();

//   //     // Show options for gallery or camera using a dialog
//   //     await showDialog(
//   //       context: context,
//   //       builder: (BuildContext context) {
//   //         return AlertDialog(
//   //           title: const Text('Select Image Source'),
//   //           content: SingleChildScrollView(
//   //             child: ListBody(
//   //               children: <Widget>[
//   //                 GestureDetector(
//   //                   child: const Text('Gallery'),
//   //                   onTap: () async {
//   //                     Navigator.of(context).pop();
//   //                     final XFile? image =
//   //                         await _picker.pickImage(source: ImageSource.gallery);
//   //                     processImage(image);
//   //                   },
//   //                 ),
//   //                 const SizedBox(height: 20),
//   //                 GestureDetector(
//   //                   child: const Text('Camera'),
//   //                   onTap: () async {
//   //                     Navigator.of(context).pop();
//   //                     final XFile? image =
//   //                         await _picker.pickImage(source: ImageSource.camera);
//   //                     processImage(image);
//   //                   },
//   //                 ),
//   //               ],
//   //             ),
//   //           ),
//   //         );
//   //       },
//   //     );
//   //   } catch (e) {
//   //     print("OCR Error: $e");
//   //     // Handle OCR errors here
//   //   }
//   // }

//   // final textRecognizer = TextRecognizer();

//   // void processImage(XFile? image) async {
//   //   if (image == null) return; // User canceled image picking

//   //   final file = File(image.path);

//   //   final inputImage = InputImage.fromFile(file);
//   //   final recognizedText = await textRecognizer.processImage(inputImage);

//   //   StringBuffer extractedTextBuffer = StringBuffer();
//   //   for (TextBlock block in recognizedText.blocks) {
//   //     for (TextLine line in block.lines) {
//   //       extractedTextBuffer.write(line.text + ' ');
//   //     }
//   //   }

//   //   textRecognizer.close();

//   //   String extractedText = extractedTextBuffer.toString().trim();

//   //   // Now you can process the extracted text as needed
//   //   // For example, you can update the corresponding TextFormField with the extracted text
//   //   setState(() {
//   //     formData['description'] = extractedText;
//   //   });
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppBar(
//           height: getVerticalSize(49),
//           leadingWidth: 40,
//           leading: AppbarImage(
//               height: getSize(24),
//               width: getSize(24),
//               svgPath: ImageConstant.imgArrowleftBlueGray900,
//               margin: getMargin(left: 16, top: 12, bottom: 13),
//               onTap: () {
//                 Navigator.pop(context);
//               }),
//           centerTitle: true,
//           title: AppbarTitle(text: "Create Match_Setting")),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               children: [
//                 Padding(
//                   padding: getPadding(top: 18),
//                   child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         Text("Name",
//                             overflow: TextOverflow.ellipsis,
//                             textAlign: TextAlign.left,
//                             style: AppStyle.fieldlabel),
//                         CustomTextFormField(
//                           focusNode: FocusNode(),
//                           hintText: "Please Enter Name",
//                           onsaved: (value) => formData['name'] = value,
//                         )
//                       ]),
//                 ),
//                 const SizedBox(height: 16),
//                 Padding(
//                     padding: getPadding(top: 19),
//                     child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           Text("Description",
//                               overflow: TextOverflow.ellipsis,
//                               textAlign: TextAlign.left,
//                               style: AppStyle.txtGilroyMedium16Bluegray900),
//                           CustomTextFormField(
//                               maxLines: 5,
//                               focusNode: FocusNode(),
//                               hintText: "Enter Description",
//                               // ValidationProperties

//                               onsaved: (value) =>
//                                   formData['description'] = value,
//                               margin: getMargin(top: 6))
//                         ])),
//                 SizedBox(height: 16),
//                 Switch(
//                   value: isactive,
//                   onChanged: (newValue) {
//                     setState(() {
//                       isactive = newValue;
//                     });
//                   },
//                 ),
//                 const SizedBox(width: 8),
//                 const Text('Active'),
//                 Switch(
//                   value: isdisable_wagon_wheel_for_dot_ball,
//                   onChanged: (newValue) {
//                     setState(() {
//                       isdisable_wagon_wheel_for_dot_ball = newValue;
//                     });
//                   },
//                 ),
//                 const SizedBox(width: 8),
//                 const Text('Disable Wagon wheel for DOT Ball'),
//                 Switch(
//                   value: isdisable_wagon_wheel_for_1s_2s_and_3s,
//                   onChanged: (newValue) {
//                     setState(() {
//                       isdisable_wagon_wheel_for_1s_2s_and_3s = newValue;
//                     });
//                   },
//                 ),
//                 const SizedBox(width: 8),
//                 const Text('Disable Wagon wheel for 1s 2s and 3s'),
//                 Switch(
//                   value: isdisable_shot_selection,
//                   onChanged: (newValue) {
//                     setState(() {
//                       isdisable_shot_selection = newValue;
//                     });
//                   },
//                 ),
//                 const SizedBox(width: 8),
//                 const Text('Disable shot selection'),
//                 Switch(
//                   value: iscount_wide_as_a_legal_delivery,
//                   onChanged: (newValue) {
//                     setState(() {
//                       iscount_wide_as_a_legal_delivery = newValue;
//                     });
//                   },
//                 ),
//                 const SizedBox(width: 8),
//                 const Text('Count wide as a legal delivery'),
//                 Switch(
//                   value: iscount_no_ball_as_a_legal_delivery,
//                   onChanged: (newValue) {
//                     setState(() {
//                       iscount_no_ball_as_a_legal_delivery = newValue;
//                     });
//                   },
//                 ),
//                 const SizedBox(width: 8),
//                 const Text('Count no Ball as a legal delivery'),
//                 Padding(
//                   padding: getPadding(top: 18),
//                   child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         Text("For Overs",
//                             overflow: TextOverflow.ellipsis,
//                             textAlign: TextAlign.left,
//                             style: AppStyle.fieldlabel),
//                         CustomTextFormField(
//                           focusNode: FocusNode(),
//                           hintText: "Please Enter For Overs",
//                           onsaved: (value) => formData['for_overs'] = value,
//                         )
//                       ]),
//                 ),
//                 const SizedBox(height: 16),
//                 const SizedBox(width: 8),
//                 CustomButton(
//                   height: getVerticalSize(50),
//                   text: "Submit",
//                   margin: getMargin(top: 24, bottom: 5),
//                   onTap: () async {
//                     if (_formKey.currentState!.validate()) {
//                       _formKey.currentState!.save();

//                       formData['active'] = isactive;

//                       formData['disable_wagon_wheel_for_dot_ball'] =
//                           isdisable_wagon_wheel_for_dot_ball;

//                       formData['disable_wagon_wheel_for_1s_2s_and_3s'] =
//                           isdisable_wagon_wheel_for_1s_2s_and_3s;

//                       formData['disable_shot_selection'] =
//                           isdisable_shot_selection;

//                       formData['count_wide_as_a_legal_delivery'] =
//                           iscount_wide_as_a_legal_delivery;

//                       formData['count_no_ball_as_a_legal_delivery'] =
//                           iscount_no_ball_as_a_legal_delivery;

//                       try {
//                         print(formData);
//                         Map<String, dynamic> createdEntity =
//                             await apiService.createEntity(formData);

//                         Navigator.pop(context);
//                       } catch (e) {
//                         // ignore: use_build_context_synchronously
//                         showDialog(
//                           context: context,
//                           builder: (BuildContext context) {
//                             return AlertDialog(
//                               title: const Text('Error'),
//                               content:
//                                   Text('Failed to create Match_Setting: $e'),
//                               actions: [
//                                 TextButton(
//                                   child: const Text('OK'),
//                                   onPressed: () {
//                                     Navigator.of(context).pop();
//                                   },
//                                 ),
//                               ],
//                             );
//                           },
//                         );
//                       }
//                     }
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:cricyard/Entity/matches/Match_Setting/viewmodel/Match_Setting_viewmodel.dart';
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

class MatchSettingCreateEntityScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final matchSettingProvider = Provider.of<MatchSettingProvider>(context);
    final matchSetting = matchSettingProvider.matchSetting;

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
          },
        ),
        centerTitle: true,
        title: AppbarTitle(text: "Create Match Setting"),
      ),
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
                      Text("Name",
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: AppStyle.fieldlabel),
                      CustomTextFormField(
                        focusNode: FocusNode(),
                        hintText: "Please Enter Name",
                        onsaved: (value) => matchSettingProvider.updateName(value),
                      ),
                    ],
                  ),
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
                            matchSettingProvider.updateDescription(value),
                        margin: getMargin(top: 6),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                SwitchListTile(
                  title: Text('Active'),
                  value: matchSetting.isActive,
                  onChanged: matchSettingProvider.toggleActive,
                ),
                SwitchListTile(
                  title: Text('Disable Wagon wheel for DOT Ball'),
                  value: matchSetting.isDisableWagonWheelForDotBall,
                  onChanged: matchSettingProvider.toggleDisableWagonWheelForDotBall,
                ),
                SwitchListTile(
                  title: Text('Disable Wagon wheel for 1s 2s and 3s'),
                  value: matchSetting.isDisableWagonWheelFor1s2sAnd3s,
                  onChanged: matchSettingProvider.toggleDisableWagonWheelFor1s2sAnd3s,
                ),
                SwitchListTile(
                  title: Text('Disable shot selection'),
                  value: matchSetting.isDisableShotSelection,
                  onChanged: matchSettingProvider.toggleDisableShotSelection,
                ),
                SwitchListTile(
                  title: Text('Count wide as a legal delivery'),
                  value: matchSetting.isCountWideAsLegalDelivery,
                  onChanged: matchSettingProvider.toggleCountWideAsLegalDelivery,
                ),
                SwitchListTile(
                  title: Text('Count no Ball as a legal delivery'),
                  value: matchSetting.isCountNoBallAsLegalDelivery,
                  onChanged: matchSettingProvider.toggleCountNoBallAsLegalDelivery,
                ),
                Padding(
                  padding: getPadding(top: 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("For Overs",
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: AppStyle.fieldlabel),
                      CustomTextFormField(
                        focusNode: FocusNode(),
                        hintText: "Please Enter For Overs",
                        onsaved: (value) =>
                            matchSettingProvider.updateForOvers(value),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                CustomButton(
                  height: getVerticalSize(50),
                  text: "Submit",
                  margin: getMargin(top: 24, bottom: 5),
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      try {
                        await matchSettingProvider.submitForm();
                        Navigator.pop(context);
                      } catch (e) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Error'),
                              content: Text('Failed to create Match Setting: $e'),
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
