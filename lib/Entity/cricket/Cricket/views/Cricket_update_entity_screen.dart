// ignore_for_file: use_build_context_synchronously
import '../../../../Utils/image_constant.dart';
import '../../../../Utils/size_utils.dart';
import '../../../../theme/app_style.dart';
import '../../../../views/widgets/app_bar/appbar_image.dart';
import '../../../../views/widgets/app_bar/appbar_title.dart';
import '../../../../views/widgets/app_bar/custom_app_bar.dart';
import '../../../../views/widgets/custom_button.dart';
import '../../../../views/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import '../repository/Cricket_api_service.dart';
import '/providers/token_manager.dart';
import '../viewmodel/Cricket_viewmodel.dart';
import 'package:provider/provider.dart';


// class cricketUpdateEntityScreen extends StatefulWidget {
//   final Map<String, dynamic> entity;
  
  

//   cricketUpdateEntityScreen({required this.entity});

//   @override
//   _cricketUpdateEntityScreenState createState() =>
//       _cricketUpdateEntityScreenState();
      
      
// }

// class _cricketUpdateEntityScreenState extends State<cricketUpdateEntityScreen> {
//   final CricketApiService apiService = CricketApiService();
//   final _formKey = GlobalKey<FormState>();
  

//   var selectedaudio_language; // Initialize with the default value \n);
//   List<String> audio_languageList = [
//     'bar_code',
//     'qr_code',
//   ];

//   bool isactive = false;

//   @override
//   void initState() {
//     super.initState();
//     selectedaudio_language =
//         widget.entity['audio_language']; // Initialize with the default value

//     isactive = widget.entity['active'] ?? false; // Set initial value
//   }

//   @override
//   Widget build(BuildContext context) {
//     final cricketProvider = Provider.of<CricketProvider>(context);
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
//           title: AppbarTitle(text: "Update Cricket")),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               children: [
//                 DropdownButtonFormField<String>(
//                   decoration:
//                       const InputDecoration(labelText: 'Selectaudio_language'),
//                   value: widget.entity['audio_language'],
//                   items: audio_languageList
//                       .map((name) => DropdownMenuItem<String>(
//                             value: name,
//                             child: Text(name),
//                           ))
//                       .toList(),
//                   onChanged: (value) {
//                     setState(() {
//                       selectedaudio_language = value!;
//                       widget.entity['audio_language'] = value;
//                     });
//                   },
//                 ),
//                 const SizedBox(height: 16),
//                 Padding(
//                   padding: getPadding(top: 18),
//                   child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         Text("Name",
//                             overflow: TextOverflow.ellipsis,
//                             textAlign: TextAlign.left,
//                             style: AppStyle.txtGilroyMedium16Bluegray900),
//                         CustomTextFormField(
//                             focusNode: FocusNode(),
//                             hintText: "Please Enter Name",
//                             initialValue: widget.entity['name'],

//                             // ValidationProperties
//                             onsaved: (value) => widget.entity['name'] = value,
//                             margin: getMargin(top: 7))
//                       ]),
//                 ),
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
//                               focusNode: FocusNode(),
//                               hintText: "Enter Description",
//                               initialValue: widget.entity['description'],
//                               maxLines: 5,
//                               onsaved: (value) {
//                                 widget.entity['description'] = value;
//                               },
//                               margin: getMargin(top: 6))
//                         ])),
//                 const SizedBox(height: 16),
//                 Row(
//                   children: [
//                     Switch(
//                       value: isactive,
//                       onChanged: (newValue) {
//                         setState(() {
//                           isactive = newValue;
//                         });
//                       },
//                     ),
//                     const SizedBox(width: 8),
//                     const Text('Active'),
//                   ],
//                 ),
//                 CustomButton(
//                   height: getVerticalSize(50),
//                   text: "Update",
//                   margin: getMargin(top: 24, bottom: 5),
//                   onTap: () async {
//                     if (_formKey.currentState!.validate()) {
//                       _formKey.currentState!.save();

//                       widget.entity['active'] = isactive;

//                       final token = await TokenManager.getToken();
//                       try {
//                         await apiService.updateEntity(
//                             token!,
//                             widget.entity[
//                                 'id'], // Assuming 'id' is the key in your entity map
//                             widget.entity);

//                         Navigator.pop(context);
//                       } catch (e) {
//                         // ignore: use_build_context_synchronously
//                         showDialog(
//                           context: context,
//                           builder: (BuildContext context) {
//                             return AlertDialog(
//                               title: const Text('Error'),
//                               content: Text('Failed to update Cricket: $e'),
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
class CricketUpdateEntityScreen extends StatelessWidget {
  final Map<String, dynamic> entity;

  CricketUpdateEntityScreen({required this.entity});

  @override
  Widget build(BuildContext context) {
    final cricketProvider = Provider.of<CricketProvider>(context, listen: false);
    final CricketApiService apiService = CricketApiService();
    // Initialize provider with the current entity data
    // cricketProvider.initializeEntity(entity);

    return Scaffold(
      appBar: CustomAppBar(
        height: getVerticalSize(49),
        leadingWidth: 40,
        leading: AppbarImage(
          height: getSize(24),
          width: getSize(24),
          svgPath: ImageConstant.imgArrowleftBlueGray900,
          margin: getMargin(left: 16, top: 12, bottom: 13),
          onTap: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: AppbarTitle(text: "Update Cricket"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: GlobalKey<FormState>(),
            child: Column(
              children: [
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: 'Select Audio Language'),
                  value: cricketProvider.selectedAudioLanguage,
                  items: cricketProvider.audioLanguageList
                      .map((name) => DropdownMenuItem<String>(
                            value: name,
                            child: Text(name),
                          ))
                      .toList(),
                  onChanged: cricketProvider.updateAudioLanguage,
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: getPadding(top: 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Name", style: AppStyle.txtGilroyMedium16Bluegray900),
                      CustomTextFormField(
                        focusNode: FocusNode(),
                        hintText: "Please Enter Name",
                        initialValue: cricketProvider.formData['name'],
                        onsaved: (value) => cricketProvider.updateFormData('name', value),
                        margin: getMargin(top: 7),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: getPadding(top: 19),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Description", style: AppStyle.txtGilroyMedium16Bluegray900),
                      CustomTextFormField(
                        focusNode: FocusNode(),
                        hintText: "Enter Description",
                        initialValue: cricketProvider.formData['description'],
                        maxLines: 5,
                        onsaved: (value) => cricketProvider.updateFormData('description', value),
                        margin: getMargin(top: 6),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Switch(
                      value: cricketProvider.isActive,
                      onChanged: cricketProvider.updateIsActive,
                    ),
                    const SizedBox(width: 8),
                    const Text('Active'),
                  ],
                ),
                CustomButton(
                  height: getVerticalSize(50),
                  text: "Update",
                  margin: getMargin(top: 24, bottom: 5),
                  onTap: () async {
                    if (GlobalKey<FormState>().currentState!.validate()) {
                      await cricketProvider.updateEntity(context);
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
