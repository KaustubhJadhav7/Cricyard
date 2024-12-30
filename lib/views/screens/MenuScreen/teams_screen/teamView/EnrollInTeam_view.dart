// ignore_for_file: use_build_context_synchronously
import 'package:cricyard/views/screens/MenuScreen/teams_screen/teamViewModel/team_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../Utils/size_utils.dart';
import '../../../../../core/utils/image_constant.dart';
import '../../../../widgets/app_bar/appbar_image.dart';
import '../../../../widgets/app_bar/appbar_title.dart';
import '../../../../widgets/custom_button.dart';
import '../../profile_screen/views/custom_app_bar.dart';

class EnrollInTeamView extends StatefulWidget {
  const EnrollInTeamView({super.key});

  @override
  _EnrollInTeamViewState createState() => _EnrollInTeamViewState();
}

class _EnrollInTeamViewState extends State<EnrollInTeamView> {
  // final teamsApiService teamapiService = teamsApiService();

  final Map<String, dynamic> formData = {};
  final _formKey = GlobalKey<FormState>();
//  String to store the image file name

  DateTime selectedDate = DateTime.now();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  // List<Map<String, dynamic>> teamNameItems = [];
  var selectedteamName = ''; // Use nullable type  Future<void> _load

  // Future<void> loadTeamnameItems() async {
  //   try {
  //     final selectTdata = await teamapiService.getMyTeam();
  //     // Handle null or empty dropdownData
  //     if (selectTdata != null && selectTdata.isNotEmpty) {
  //       setState(() {
  //         teamNameItems = selectTdata;
  //         print(' team Data is : $teamNameItems');
  //       });
  //     } else {
  //       print(' team   data is null or empty');
  //     }
  //   } catch (e) {
  //     print('Failed to load  Teams  items: $e');
  //   }
  // }

  @override
  void initState() {
    super.initState();
    Provider.of<TeamViewModel>(context, listen: false).teamNameItems;

    // loadTeamnameItems();
  }

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
            title: AppbarTitle(text: "Enroll In Team")),
        body: Consumer<TeamViewModel>(builder: (context, value, child) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
// DropdownButtonFormField For Team
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(labelText: 'Team Name'),
                      value: selectedteamName,
                      items: [
                        // Add an item with an empty value to represent no selection
                        const DropdownMenuItem<String>(
                          value: '',
                          child: Text('Select option'),
                        ),
                        // Map your dropdownItems as before
                        ...value.teamNameItems.map<DropdownMenuItem<String>>(
                          (item) {
                            return DropdownMenuItem<String>(
                              value: item['id'].toString(),
                              child: Text(item['team_name'].toString()),
                            );
                          },
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          selectedteamName = value!;
                        });
                      },
                      onSaved: (value) {
                        if (selectedteamName.isEmpty) {
                          selectedteamName = "no value";
                        }
                        formData['team_id'] = selectedteamName;
                      },
                    ),

                    // const SizedBox(height: 16),
                    // GestureDetector(
                    //   onTap: () => _selectDate(context),
                    //   child: AbsorbPointer(
                    //     child: TextFormField(
                    //       decoration: const InputDecoration(
                    //         labelText: 'dates',
                    //         suffixIcon: Icon(Icons.calendar_today),
                    //       ),
                    //       controller: TextEditingController(
                    //         text: DateFormat('yyyy-MM-dd').format(selectedDate),
                    //       ),
                    //       onSaved: (value) => formData['dates'] =
                    //           DateFormat('yyyy-MM-dd').format(selectedDate),
                    //     ),
                    //   ),
                    // ),
                    const SizedBox(height: 16),

                    CustomButton(
                      height: getVerticalSize(50),
                      text: "Submit",
                      margin: getMargin(top: 24, bottom: 5),
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();

                          try {
                            print(formData);
                            value.enrollInTeam(formData);

                            // await teamapiService.enrollInTeam(formData);

                            Navigator.pop(context);
                          } catch (e) {
                            // ignore: use_build_context_synchronously
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Error'),
                                  content: Text(
                                      'Failed to create My_Tournament: $e'),
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
          );
        }));
  }
}
