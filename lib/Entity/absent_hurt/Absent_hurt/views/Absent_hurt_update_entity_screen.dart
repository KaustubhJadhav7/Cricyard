// // ignore_for_file: use_build_context_synchronously
// import '../../../../Utils/image_constant.dart';
// import '../../../../Utils/size_utils.dart';
// import '../../../../theme/app_style.dart';
// import '../../../../views/widgets/app_bar/appbar_image.dart';
// import '../../../../views/widgets/app_bar/appbar_title.dart';
// import '../../../../views/widgets/app_bar/custom_app_bar.dart';
// import '../../../../views/widgets/custom_button.dart';
// import '../../../../views/widgets/custom_text_form_field.dart';
// import 'package:flutter/material.dart';
// import '../repository/Absent_hurt_api_service.dart';
// import '/providers/token_manager.dart';

// class absent_hurtUpdateEntityScreen extends StatefulWidget {
//   final Map<String, dynamic> entity;

//   absent_hurtUpdateEntityScreen({required this.entity});

//   @override
//   _absent_hurtUpdateEntityScreenState createState() =>
//       _absent_hurtUpdateEntityScreenState();
// }

// class _absent_hurtUpdateEntityScreenState
//     extends State<absent_hurtUpdateEntityScreen> {
//   final AbsentHurtApiService apiService = AbsentHurtApiService();
//   final _formKey = GlobalKey<FormState>();

//   bool isactive = false;

//   var selectedplayer_name; // Initialize with the default value \n);
//   List<String> player_nameList = [
//     'bar_code',
//     'qr_code',
//   ];

//   @override
//   void initState() {
//     super.initState();

//     isactive = widget.entity['active'] ?? false; // Set initial value

//     selectedplayer_name =
//         widget.entity['player_name']; // Initialize with the default value
//   }

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
//           title: AppbarTitle(text: "Update Absent_hurt")),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               children: [
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
//                               maxLines: 4,

//                               // ValidationProperties

//                               onsaved: (value) {
//                                 widget.entity['description'] = value;
//                               },
//                               margin: getMargin(top: 6))
//                         ])),
//                 SizedBox(height: 16),
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
//                 DropdownButtonFormField<String>(
//                   decoration:
//                       const InputDecoration(labelText: 'Selectplayer_name'),
//                   value: widget.entity['player_name'],
//                   items: player_nameList
//                       .map((name) => DropdownMenuItem<String>(
//                             value: name,
//                             child: Text(name),
//                           ))
//                       .toList(),
//                   onChanged: (value) {
//                     setState(() {
//                       selectedplayer_name = value!;
//                       widget.entity['player_name'] = value;
//                     });
//                   },
//                 ),
//                 const SizedBox(height: 16),
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
//                               content: Text('Failed to update Absent_hurt: $e'),
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
import 'package:cricyard/Entity/absent_hurt/Absent_hurt/model/Absent_hurt_model.dart';
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
import '../repository/Absent_hurt_api_service.dart';
import '/providers/token_manager.dart';
import 'package:cricyard/Entity/absent_hurt/Absent_hurt/viewmodel/absent_hurt_viewmodel.dart';


class AbsentHurtUpdateEntityScreen extends StatelessWidget {
  final AbsentHurtEntity entity;

  const AbsentHurtUpdateEntityScreen({required this.entity, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final absentHurtProvider = Provider.of<AbsentHurtProvider>(context, listen: false);

    // Initialize provider with entity data
    absentHurtProvider.initialize(entity);

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
        title: AppbarTitle(text: "Update Absent Hurt"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: GlobalKey<FormState>(),
            child: Column(
              children: [
                Padding(
                  padding: getPadding(top: 19),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Description",
                        style: AppStyle.txtGilroyMedium16Bluegray900,
                      ),
                      Consumer<AbsentHurtProvider>(
                        builder: (context, provider, child) {
                          return CustomTextFormField(
                            hintText: "Enter Description",
                            initialValue: provider.description,
                            maxLines: 4,
                            onsaved: (value) {
                              provider.setDescription(value ?? '');
                            },
                            margin: getMargin(top: 6),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Consumer<AbsentHurtProvider>(
                  builder: (context, provider, child) {
                    return Row(
                      children: [
                        Switch(
                          value: provider.isActive,
                          onChanged: provider.setActive,
                        ),
                        const SizedBox(width: 8),
                        const Text('Active'),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 16),
                Consumer<AbsentHurtProvider>(
                  builder: (context, provider, child) {
                    return CustomDropdownFormField(
                      value: provider.selectedPlayerName,
                      items: [
                        DropdownMenuItem<String>(
                          value: '',
                          child: Text(
                            'Choose player_name',
                            style: AppStyle.txtGilroyMedium16Bluegray900,
                          ),
                        ),
                        ...['bar_code', 'qr_code'].map((item) {
                          return DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: AppStyle.txtGilroyMedium16Bluegray900,
                            ),
                          );
                        }).toList(),
                      ],
                      onChanged: provider.setSelectedPlayerName,
                    );
                  },
                ),
                const SizedBox(height: 16),
                CustomButton(
                  height: getVerticalSize(50),
                  text: "Update",
                  margin: getMargin(top: 24, bottom: 5),
                  onTap: () async {
                    final token = await TokenManager.getToken();
                    final apiService = AbsentHurtApiService();
                    final provider = context.read<AbsentHurtProvider>();

                    try {
                      await apiService.updateEntity(
                        token!,
                        provider.entity.id,
                        provider.entity,
                      );
                      Navigator.pop(context);
                    } catch (e) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Error'),
                            content: Text('Failed to update Absent Hurt: $e'),
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
