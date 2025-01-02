// // ignore_for_file: use_build_context_synchronously
import 'package:cricyard/core/utils/size_utils.dart';
// import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../Utils/image_constant.dart';
import '../../../../Utils/size_utils.dart';
// import '../../../../views/screens/ReuseableWidgets/BottomAppBarWidget.dart';
// import '../../../../theme/theme_helper.dart';
// import '../../../../views/widgets/custom_button.dart';
// import '../../../../views/widgets/custom_icon_button.dart';
// import '../../../../views/widgets/custom_image_view.dart';
// import '../../../../views/widgets/custom_text_form_field.dart';
// import 'package:intl/intl.dart';
// import '../repository/My_Tournament_api_service.dart';
// import '/providers/token_manager.dart';
// import 'package:flutter/services.dart';

// class my_tournamentCreateEntityScreen extends StatefulWidget {
//   const my_tournamentCreateEntityScreen({super.key});

//   @override
//   _my_tournamentCreateEntityScreenState createState() =>
//       _my_tournamentCreateEntityScreenState();
// }

// class _my_tournamentCreateEntityScreenState
//     extends State<my_tournamentCreateEntityScreen> {
//   final MyTournamentApiService apiService = MyTournamentApiService();
//   final Map<String, dynamic> formData = {};
//   final _formKey = GlobalKey<FormState>();
//   var selectedlogo;
//   Uint8List? _logoimageBytes; // Uint8List to store the image data
//   String? _logoimageFileName; // String to store the image file name

//   List<Widget> logoimageUploadRows = [];
//   List<Map<String, dynamic>> selectedlogoImages = [];
//   Widget _logobuildImageUploadRow(Map<String, dynamic> newImage) {
//     return Row(
//       children: [
//         ElevatedButton(
//           onPressed: () async {
//             await _logopickImage(ImageSource.gallery, newImage);
//           },
//           child: const Text('Upload Image'),
//         ),
//         const SizedBox(width: 16),
//         ElevatedButton(
//           onPressed: () async {
//             await _logopickImage(ImageSource.camera, newImage);
//           },
//           child: const Text('Take Photo'),
//         ),
//       ],
//     );
//   }

//   Future<void> _logopickImage(
//       ImageSource source, Map<String, dynamic> newImage) async {
//     final imagePicker = ImagePicker();

//     try {
//       final pickedImage = await imagePicker.pickImage(source: source);

//       if (pickedImage != null) {
//         final imageBytes = await pickedImage.readAsBytes();

//         newImage['imageBytes'] = imageBytes;
//         newImage['imageFileName'] = pickedImage.name;

//         setState(() {});
//       }
//     } catch (e) {
//       print(e);
//     }
//   }

//   void _addlogoUploadRow() {
//     Map<String, dynamic> newImage = {};
//     logoimageUploadRows.add(_logobuildImageUploadRow(newImage));
//     selectedlogoImages.add(newImage);
//     setState(() {});
//   }

//   void _removelogoImageUploadRow(int index) {
//     logoimageUploadRows.removeAt(index);
//     selectedlogoImages.removeAt(index);
//     setState(() {});
//   }

//   Future<void> _uploadlogoImageFile() async {
//     final imagePicker = ImagePicker();

//     try {
//       final pickedImage =
//           await imagePicker.pickImage(source: ImageSource.gallery);

//       if (pickedImage != null) {
//         final imageBytes = await pickedImage.readAsBytes();

//         setState(() {
//           _logoimageBytes = imageBytes;
//           _logoimageFileName = pickedImage.name; // Store the file name
//           selectedlogo = pickedImage.path; // Store the image file path
//           selectedlogoImages.add({
//             'imageBytes': imageBytes,
//             'imageFileName': pickedImage.name,
//           });
//         });
//       }
//     } catch (e) {
//       print(e);
//     }
//   }

// // Modify the _takePhoto function
//   Future<void> _takelogoPhoto() async {
//     final imagePicker = ImagePicker();

//     try {
//       final pickedImage =
//           await imagePicker.pickImage(source: ImageSource.camera);

//       if (pickedImage != null) {
//         final imageBytes = await pickedImage.readAsBytes();

//         setState(() {
//           _logoimageBytes = imageBytes;
//           _logoimageFileName = pickedImage.name; // Store the file name
//           selectedlogo = pickedImage.path; // Store the image file path
//           selectedlogoImages.add({
//             'imageBytes': imageBytes,
//             'imageFileName': pickedImage.name,
//           });
//         });
//       }
//     } catch (e) {
//       print(e);
//     }
//   }

//   DateTime selectedDate = DateTime.now();
//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: selectedDate,
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2101),
//     );
//     if (picked != null && picked != selectedDate) {
//       setState(() {
//         selectedDate = picked;
//       });
//     }
//   }

//   List<Map<String, dynamic>> tournament_nameItems = [];
//   var selectedtournament_nameValue =
//       ''; // Use nullable type  Future<void> _load
//   Future<void> _loadtournament_nameItems() async {
//     final token = await TokenManager.getToken();
//     try {
//       final selectTdata = await apiService.getTournamentName(token!);
//       print(' tournament_name   data is : $selectTdata');
//       // Handle null or empty dropdownData
//       if (selectTdata != null && selectTdata.isNotEmpty) {
//         setState(() {
//           tournament_nameItems = selectTdata;
//         });
//       } else {
//         print(' tournament_name   data is null or empty');
//       }
//     } catch (e) {
//       print('Failed to load  tournament_name   items: $e');
//     }
//   }

//   @override
//   void initState() {
//     super.initState();

//     _loadtournament_nameItems();
//   }

  

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(getVerticalSize(49)),
//         child: Container(
//           // Adjust the top margin as needed
//           child: Align(
//             alignment: Alignment.centerLeft,
//             child: Row(
//               children: [
//                 Padding(
//                   padding: EdgeInsets.only(
//                     top: 9.v,
//                     bottom: 6.v,
//                   ),
//                   child: CustomIconButton(
//                     height: 32.adaptSize,
//                     width: 32.adaptSize,
//                     decoration: IconButtonStyleHelper.outlineIndigo,
//                     onTap: () {
//                       Navigator.pop(context);
//                     },
//                     child: CustomImageView(
//                       svgPath: ImageConstant.imgArrowleft,
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(left: 18.h),
//                   child: Text(
//                     " Create Tournament ",
//                     style: theme.textTheme.headlineLarge,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               children: [

//                 Column(
//                   children: List.generate(
//                     logoimageUploadRows.length,
//                     (index) => Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 8.0),
//                       child: Row(
//                         children: [
//                           // Existing image upload row
//                           Expanded(
//                             child: logoimageUploadRows[index],
//                           ),
//                           // Remove icon button
//                           IconButton(
//                             icon: const Icon(Icons.remove),
//                             onPressed: () {
//                               _removelogoImageUploadRow(index);
//                             },
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 // Dynamic list to display selected images
//                 selectedlogoImages.isEmpty
//                     ? const Center(
//                         child: Text('Images Not Available'),
//                       )
//                     : SizedBox(
//                         height: 100,
//                         child: ListView.builder(
//                           scrollDirection: Axis.horizontal,
//                           itemCount: selectedlogoImages.length,
//                           itemBuilder: (BuildContext context, int index) {
//                             return Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Image.memory(
//                                 selectedlogoImages[index]['imageBytes'] ??
//                                     Uint8List(0),
//                                 width: 100,
//                                 height: 100,
//                                 fit: BoxFit.cover,
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//                 const SizedBox(height: 16),

//                 IconButton(
//                   icon: const Icon(Icons.add),
//                   onPressed: () {
//                     _addlogoUploadRow();
//                   },
//                 ),

//                 //image upload code ends

//                 Padding(
//                   padding: getPadding(top: 18),
//                   child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         const Text("Tournament Name",
//                             overflow: TextOverflow.ellipsis,
//                             textAlign: TextAlign.left,
//                             style: TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w700,
//                                 color: Colors.black)),
//                         CustomTextFormField(
//                           focusNode: FocusNode(),
//                           hintText: "Please Enter Tournament Name",
//                           onsaved: (value) =>
//                               formData['tournament_name'] = value,
//                         )
//                       ]),
//                 ),

//                 const SizedBox(height: 16),

//                 Padding(
//                   padding: getPadding(top: 18),
//                   child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         const Text("Venues",
//                             overflow: TextOverflow.ellipsis,
//                             textAlign: TextAlign.left,
//                             style: TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w700,
//                                 color: Colors.black)),
//                         CustomTextFormField(
//                           focusNode: FocusNode(),
//                           hintText: "Please Enter Venues",
//                           onsaved: (value) => formData['venues'] = value,
//                         )
//                       ]),
//                 ),

//                 const SizedBox(height: 16),

//                 Padding(
//                   padding: getPadding(top: 18),
//                   child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         const Text(
//                           "Sponsers",
//                           overflow: TextOverflow.ellipsis,
//                           textAlign: TextAlign.left,
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.w700,
//                             color: Colors.black,
//                           ),
//                         ),
//                         CustomTextFormField(
//                           focusNode: FocusNode(),
//                           hintText: "Please Enter Sponsors",
//                           onsaved: (value) => formData['sponsors'] = value,
//                         )
//                       ]),
//                 ),

//                 const SizedBox(height: 16),

                
//                 //   padding: getPadding(top: 19),
//                 //   child: Column(
//                 //     crossAxisAlignment: CrossAxisAlignment.start,
//                 //     mainAxisAlignment: MainAxisAlignment.start,
//                 //     children: [
//                 //       const Text(
//                 //         "Dates",
//                 //         overflow: TextOverflow.ellipsis,
//                 //         textAlign: TextAlign.left,
//                 //         style: TextStyle(
//                 //           fontSize: 16,
//                 //           fontWeight: FontWeight.w700,
//                 //           color: Colors.black,
//                 //         ),
//                 //       ),
//                 //       CustomTextFormField(
//                 //         controller: TextEditingController(
//                 //           text: DateFormat('yyyy-MM-dd').format(selectedDate),
//                 //           suffixIcon: const Icon(Icons.calendar_today),
//                 //         ),
//                 //         onTap: () => _selectDate(context),
//                 //         onSaved: (value) => formData['dates'] = value,
//                 //       ),
//                 //     ],
//                 //   ),
//                 // ),
//                 Padding(
//                   padding: getPadding(top: 19),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       const Text(
//                         "Dates",
//                         overflow: TextOverflow.ellipsis,
//                         textAlign: TextAlign.left,
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.w700,
//                           color: Colors.black,
//                         ),
//                       ),
//                       Row(
//                         children: [
//                           Expanded(
//                             child: CustomTextFormField(
//                               controller: TextEditingController(
//                                 text: DateFormat('yyyy-MM-dd')
//                                     .format(selectedDate),
//                               ),
//                               onTap: () => _selectDate(context),
//                               onsaved: (value) => formData['dates'] = value,
//                             ),
//                           ),
//                           IconButton(
//                             onPressed: () => _selectDate(context),
//                             icon: Icon(Icons.calendar_today),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),

//                 const SizedBox(height: 16),

//                 Padding(
//                     padding: getPadding(top: 19),
//                     child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           const Text("Description",
//                               overflow: TextOverflow.ellipsis,
//                               textAlign: TextAlign.left,
//                               style: TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.w700,
//                                   color: Colors.black)),
//                           CustomTextFormField(
//                             maxLines: 5,
//                             focusNode: FocusNode(),
//                             hintText: "Enter Description",
//                             onsaved: (value) => formData['description'] = value,
//                             margin: getMargin(top: 6),
//                           )
//                         ])),

//                 Padding(
//                     padding: getPadding(top: 19),
//                     child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           const Text("Rules",
//                               overflow: TextOverflow.ellipsis,
//                               textAlign: TextAlign.left,
//                               style: TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.w700,
//                                   color: Colors.black)),
//                           CustomTextFormField(
//                             maxLines: 5,
//                             focusNode: FocusNode(),
//                             hintText: "Enter Rules",
//                             onsaved: (value) => formData['rules'] = value,
//                             margin: getMargin(top: 6),
//                           )
//                         ])),


//                 //   padding: getPadding(top: 18),
//                 //   child: Column(
//                 //       crossAxisAlignment: CrossAxisAlignment.start,
//                 //       mainAxisAlignment: MainAxisAlignment.start,
//                 //       children: [
//                 //         const Text("Venues",
//                 //             overflow: TextOverflow.ellipsis,
//                 //             textAlign: TextAlign.left,
//                 //             style: TextStyle(
//                 //                 fontSize: 16,
//                 //                 fontWeight: FontWeight.w700,
//                 //                 color: Colors.black)),
//                 //         CustomTextFormField(
//                 //           focusNode: FocusNode(),
//                 //           hintText: "Please Enter Venues",
//                 //           onsaved: (value) => formData['venues'] = value,
//                 //         )
//                 //       ]),
//                 // ),
//                 const SizedBox(height: 16),

//                 //   padding: getPadding(top: 18),
//                 //   child: Column(
//                 //       crossAxisAlignment: CrossAxisAlignment.start,
//                 //       mainAxisAlignment: MainAxisAlignment.start,
//                 //       children: [
//                 //         const Text(
//                 //           "Sponsers",
//                 //           overflow: TextOverflow.ellipsis,
//                 //           textAlign: TextAlign.left,
//                 //           style: TextStyle(
//                 //             fontSize: 16,
//                 //             fontWeight: FontWeight.w700,
//                 //             color: Colors.black,
//                 //           ),
//                 //         ),
//                 //         CustomTextFormField(
//                 //           focusNode: FocusNode(),
//                 //           hintText: "Please Enter Sponsors",
//                 //           onsaved: (value) => formData['sponsors'] = value,
//                 //         )
//                 //       ]),
//                 // ),
//                 const SizedBox(height: 16),

//                 const SizedBox(width: 8),
//                 CustomButton(
//                   height: getVerticalSize(50),
//                   text: "Submit",
//                   margin: getMargin(top: 24, bottom: 5),
//                   onTap: () async {
//                     if (_formKey.currentState!.validate()) {
//                       _formKey.currentState!.save();

//                       final token = await TokenManager.getToken();
//                       try {
//                         print(formData);
//                         Map<String, dynamic> createdEntity =
//                             await apiService.createEntity(token!, formData);
//                         for (var selectedImage in selectedlogoImages) {
//                           await apiService.uploadlogoimage(
//                             token!,
//                             createdEntity['id'].toString(),
//                             'My_Tournament',
//                             selectedImage['imageFileName'],
//                             selectedImage['imageBytes'],
//                           );
//                         }

//                         Navigator.pop(context);
//                       } catch (e) {
//                         // ignore: use_build_context_synchronously
//                         showDialog(
//                           context: context,
//                           builder: (BuildContext context) {
//                             return AlertDialog(
//                               title: const Text('Error'),
//                               content:
//                                   Text('Failed to create My_Tournament: $e'),
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
//       bottomNavigationBar: BottomAppBarWidget(),
//     );
//   }
// }
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodel/My_Tournament_viewmodel.dart';
import '../../../../views/widgets/custom_button.dart';
import '../../../../views/widgets/custom_icon_button.dart';
import '../../../../views/widgets/custom_image_view.dart';
import '../../../../views/widgets/custom_text_form_field.dart';
import '../../../../Utils/image_constant.dart';
import '../../../../Utils/size_utils.dart';
import '../../../../views/screens/ReuseableWidgets/BottomAppBarWidget.dart';

class MyTournamentCreateEntityScreen extends StatefulWidget {
  const MyTournamentCreateEntityScreen({super.key});

  @override
  _MyTournamentCreateEntityScreenState createState() =>
      _MyTournamentCreateEntityScreenState();
}

class _MyTournamentCreateEntityScreenState
    extends State<MyTournamentCreateEntityScreen> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> formData = {};

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<MyTournamentProvider>(context, listen: false);
      provider.fetchtournament_nameItems();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MyTournamentProvider>(context);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(getVerticalSize(49)),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 9.v, bottom: 6.v),
              child: CustomIconButton(
                height: 32.adaptSize,
                width: 32.adaptSize,
                decoration: IconButtonStyleHelper.outlineIndigo,
                onTap: () {
                  Navigator.pop(context);
                },
                child: CustomImageView(
                  svgPath: ImageConstant.imgArrowleft,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 18.h),
              child: const Text(
                "Create Tournament",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // Logo upload rows
                Column(
                  children: List.generate(
                    provider.selectedLogoImages.length,
                    (index) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        children: [
                          // Existing image upload row
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () => provider.pickImage(
                                ImageSource.gallery,
                                provider.selectedLogoImages[index],
                              ),
                              child: const Text('Upload Image'),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed: () => provider.removelogoImageUploadRow(index),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Display selected images
                provider.selectedLogoImages.isEmpty
                    ? const Center(child: Text('Images Not Available'))
                    : SizedBox(
                        height: 100,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: provider.selectedLogoImages.length,
                          itemBuilder: (context, index) {
                            final image = provider.selectedLogoImages[index];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.memory(
                                image['imageBytes'] ?? Uint8List(0),
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            );
                          },
                        ),
                      ),
                const SizedBox(height: 16),

                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: provider.addlogoUploadRow,
                ),

                // Tournament name field
                CustomTextFormField(
                  hintText: "Please Enter Tournament Name",
                  onsaved: (value) => formData['tournament_name'] = value,
                ),

                const SizedBox(height: 16),

                // Venues field
                CustomTextFormField(
                  hintText: "Please Enter Venues",
                  onsaved: (value) => formData['venues'] = value,
                ),

                const SizedBox(height: 16),

                // Sponsors field
                CustomTextFormField(
                  hintText: "Please Enter Sponsors",
                  onsaved: (value) => formData['sponsors'] = value,
                ),

                const SizedBox(height: 16),

                // Dates field
                Row(
                  children: [
                    Expanded(
                      child: CustomTextFormField(
                        controller: TextEditingController(
                          text: provider.selectedDate
                              .toIso8601String()
                              .split('T')[0],
                        ),
                        onTap: () async {
                          DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: provider.selectedDate,
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101),
                          );
                          if (picked != null) {
                            provider.setSelectedDate(picked);
                          }
                        },
                        onsaved: (value) => formData['dates'] =
                            provider.selectedDate.toIso8601String(),
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: provider.selectedDate,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                        );
                        if (picked != null) {
                          provider.setSelectedDate(picked);
                        }
                      },
                      icon: const Icon(Icons.calendar_today),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Description field
                CustomTextFormField(
                  maxLines: 5,
                  hintText: "Enter Description",
                  onsaved: (value) => formData['description'] = value,
                ),

                const SizedBox(height: 16),

                // Rules field
                CustomTextFormField(
                  maxLines: 5,
                  hintText: "Enter Rules",
                  onsaved: (value) => formData['rules'] = value,
                ),

                const SizedBox(height: 16),

                // Submit button
                CustomButton(
                  text: "Submit",
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      await provider.createTournamentEntity(formData);
                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBarWidget(),
    );
  }
}
