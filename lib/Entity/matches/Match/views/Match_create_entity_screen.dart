import 'package:cricyard/core/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../Utils/image_constant.dart';
import '../../../../Utils/size_utils.dart';
import '../../../../views/screens/ReuseableWidgets/BottomAppBarWidget.dart';
import '../../../../theme/theme_helper.dart';
import '../../../../views/widgets/custom_icon_button.dart';
import '../../../../views/widgets/custom_image_view.dart';
import 'package:intl/intl.dart';
import 'package:cricyard/Entity/matches/Match/viewmodel/Match_viewmodel.dart';
import '../repository/Match_api_service.dart';
import 'package:flutter/services.dart';

class matchCreateEntityScreen extends StatefulWidget {
  const matchCreateEntityScreen({super.key});

  @override
  _matchCreateEntityScreenState createState() =>
      _matchCreateEntityScreenState();

  //custom input decorration
}

class _matchCreateEntityScreenState extends State<matchCreateEntityScreen> {
  InputDecoration customInputDecoration(String labelText) {
    return InputDecoration(
      labelText: labelText,
      border: const OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFFC0FE53), width: 2.0),
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
      ),
      
    );
  }

//for calander
  InputDecoration customInputDecoration2(String labelText, Widget? suffixIcon) {
    return InputDecoration(
      labelText: labelText,
      suffixIcon: suffixIcon,
      border: const OutlineInputBorder(
        borderSide:
            BorderSide(color: Color(0xFFC0FE53), width: 2.0), // Parrot color
        borderRadius:
            BorderRadius.all(Radius.circular(5.0)), // Rectangular shape
      ),
      
    );
  }

  final MatchApiService apiService = MatchApiService();
  final Map<String, dynamic> formData = {};
  final _formKey = GlobalKey<FormState>();
  // MatchModel match = MatchModel.fromRawJson(response);


  // DateTime selectedDate = DateTime.now();
  // Future<void> selectDate(BuildContext context) async {
  //   final DateTime? picked = await showDatePicker(
  //     context: context,
  //     initialDate: selectedDate,
  //     firstDate: DateTime(2000),
  //     lastDate: DateTime(2101),
  //   );
  //   if (picked != null && picked != selectedDate) {
  //     setState(() {
  //       selectedDate = picked;
  //     });
  //   }
  // }

  // DateTime selectedDateTime = DateTime.now();
  // Future<void> selectDateTime(BuildContext context) async {
  //   final DateTime? picked = await showDatePicker(
  //     context: context,
  //     initialDate: selectedDateTime,
  //     firstDate: DateTime(2000),
  //     lastDate: DateTime(2101),
  //   );

  //   if (picked != null) {
  //     final TimeOfDay? pickedTime = await showTimePicker(
  //       context: context,
  //       initialTime: TimeOfDay.fromDateTime(selectedDateTime),
  //     );
  //     print(pickedTime);
  //     if (pickedTime != null) {
  //       setState(() {
  //         selectedDateTime = DateTime(
  //           picked.year,
  //           picked.month,
  //           picked.day,
  //           pickedTime.hour,
  //           pickedTime.minute,
  //         );
  //       });
  //     }
  //   }
  // }

  // bool isactive = false;

  // final teamsApiService teamapiService = teamsApiService();
  // final MyTournamentApiService tourapiService = MyTournamentApiService();

  // List<Map<String, dynamic>> tournament_nameItems = [];
  // var selectedtournament_nameValue =
  //     ''; // Use nullable type  Future<void> _load
  // Future<void> _loadtournament_nameItems() async {
  //   try {
  //     final selectTdata = await tourapiService.getTournamentName();
  //     print(' tournament_name   data is : $selectTdata');
  //     // Handle null or empty dropdownData
  //     if (selectTdata != null && selectTdata.isNotEmpty) {
  //       setState(() {
  //         tournament_nameItems = selectTdata;
  //       });
  //     } else {
  //       print(' tournament_name   data is null or empty');
  //     }
  //   } catch (e) {
  //     print('Failed to load  tournament_name   items: $e');
  //   }
  // }

  // List<Map<String, dynamic>> teamNameItems = [];
  // var selectedteam1Name = ''; // Use nullable type  Future<void> _load
  // var selectedteam2Name = ''; // Use nullable type  Future<void> _load

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
    WidgetsBinding.instance.addPostFrameCallback((_) {
    final matchProvider = Provider.of<MatchProvider>(context, listen: false);
    matchProvider.loadTeamNameItems();
    matchProvider.loadTournamentNameItems();
  });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(getVerticalSize(49)),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: 9.v,
                  bottom: 6.v,
                ),
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
                child: Text(
                  " Add Schedule ",
                  style: theme.textTheme.headlineLarge,
                ),
              ),
            ],
          ),
        ),
      ),

      //below is  form starts
// Define your custom InputDecoration

      // body: SingleChildScrollView(
      //   child: Padding(
      //     padding: const EdgeInsets.all(16),
      //     child: Form(
      //       key: _formKey,
      //       child: Column(
      //         children: [
      //           // DropdownButtonFormField with default value and null check
      //           DropdownButtonFormField<String>(
      //             decoration: customInputDecoration('Tournament Name'),
      //             value: selectedtournament_nameValue,
      //             items: [
      //               // Add an item with an empty value to represent no selection
      //               const DropdownMenuItem<String>(
      //                 value: '',
      //                 child: Text('Select Tournament'),
      //               ),
      //               // Map your dropdownItems as before
      //               ...tournament_nameItems.map<DropdownMenuItem<String>>(
      //                 (item) {
      //                   return DropdownMenuItem<String>(
      //                     value: item['id'].toString(),
      //                     child: Text(item['tournament_name'].toString()),
      //                   );
      //                 },
      //               ),
      //             ],
      //             onChanged: (value) {
      //               setState(() {
      //                 selectedtournament_nameValue = value!;
      //               });
      //             },
      //             onSaved: (value) {
      //               if (selectedtournament_nameValue.isEmpty) {
      //                 selectedtournament_nameValue = "no value";
      //               }
      //               formData['tournament_id'] = selectedtournament_nameValue;
      //             },
      //           ),

      //           const SizedBox(height: 16),
      //           // DropdownButtonFormField For Team
      //           DropdownButtonFormField<String>(
      //             decoration: customInputDecoration('Team 1'),
      //             value: selectedteam1Name,
      //             items: [
      //               // Add an item with an empty value to represent no selection
      //               const DropdownMenuItem<String>(
      //                 value: '',
      //                 child: Text('Select Team 1'),
      //               ),
      //               // Map your dropdownItems as before
      //               ...teamNameItems.map<DropdownMenuItem<String>>(
      //                 (item) {
      //                   return DropdownMenuItem<String>(
      //                     value: item['id'].toString(),
      //                     child: Text(item['team_name'].toString()),
      //                   );
      //                 },
      //               ),
      //             ],
      //             onChanged: (value) {
      //               setState(() {
      //                 selectedteam1Name = value!;
      //               });
      //             },
      //             onSaved: (value) {
      //               if (selectedteam1Name.isEmpty) {
      //                 selectedteam1Name = "no value";
      //               }
      //               formData['team_1_id'] = selectedteam1Name;
      //             },
      //           ),
      //           const SizedBox(height: 16),

      //           // DropdownButtonFormField For Team
      //           DropdownButtonFormField<String>(
      //             decoration: customInputDecoration('Team 2'),
      //             value: selectedteam2Name,
      //             items: [
      //               // Add an item with an empty value to represent no selection
      //               const DropdownMenuItem<String>(
      //                 value: '',
      //                 child: Text('Select Team 2'),
      //               ),
      //               // Map your dropdownItems as before
      //               ...teamNameItems.map<DropdownMenuItem<String>>(
      //                 (item) {
      //                   return DropdownMenuItem<String>(
      //                     value: item['id'].toString(),
      //                     child: Text(item['team_name'].toString()),
      //                   );
      //                 },
      //               ),
      //             ],
      //             onChanged: (value) {
      //               setState(() {
      //                 selectedteam2Name = value!;
      //               });
      //             },
      //             onSaved: (value) {
      //               if (selectedteam2Name.isEmpty) {
      //                 selectedteam2Name = "no value";
      //               }
      //               formData['team_2_id'] = selectedteam2Name;
      //             },
      //           ),
      //           const SizedBox(height: 16),
      //           Padding(
      //             padding: getPadding(top: 18),
      //             child: Column(
      //               crossAxisAlignment: CrossAxisAlignment.start,
      //               mainAxisAlignment: MainAxisAlignment.start,
      //               children: [
      //                 TextFormField(
      //                   focusNode: FocusNode(),

      //                   decoration: const InputDecoration(
      //                     labelText: 'Location',
      //                     hintText: "Enter location",
      //                     border: OutlineInputBorder(
      //                       borderSide: BorderSide(
      //                           width: 2.0), // Parrot color
      //                       borderRadius: BorderRadius.all(
      //                           Radius.circular(5.0)), // Rectangular shape
      //                     ),
                         
      //                   ),
      //                   onSaved: (value) => formData['location'] = value,
      //                   style: const TextStyle(color: Colors.black),
      //                 ),
      //               ],
      //             ),
      //           ),

      //           const SizedBox(height: 16),
      //           TextFormField(
      //             initialValue:
      //                 DateFormat('yyyy-MM-dd HH:mm').format(selectedDateTime),
      //             decoration: customInputDecoration2(
      //                 'Date And Time', const Icon(Icons.calendar_today)),
      //             readOnly: true,
      //             onTap: () => selectDateTime(context),
      //             onSaved: (value) {
      //               formData['datetime_field'] =
      //                   DateFormat('yyyy-MM-dd HH:mm').format(selectedDateTime);
      //             },
      //           ),
      //           const SizedBox(height: 16),

      //           TextFormField(
      //             focusNode: FocusNode(),
      //             decoration: const InputDecoration(
      //               labelText: 'Description',
      //               hintText: "Enter Description",
      //               border: OutlineInputBorder(
      //                 borderSide: BorderSide(
      //                     width: 2.0), // Parrot color
      //                 borderRadius: BorderRadius.all(
      //                     Radius.circular(5.0)), // Rectangular shape
      //               ),
                    
      //             ),
      //             onSaved: (value) => formData['description'] = value,
      //             style: const TextStyle(color: Colors.black),
      //           ),

      //           const SizedBox(height: 16),
      //           Switch(
      //             value: isactive,
      //             onChanged: (newValue) {
      //               setState(() {
      //                 isactive = newValue;
      //               });
      //             },
      //           ),
      //           const SizedBox(width: 8),
      //           const Text(
      //             'Active',
      //             style: TextStyle(color: Colors.black),
      //           ),
                
      //           const SizedBox(height: 16),
      //           CustomButton(
      //             height: getVerticalSize(50),
      //             text: "Submit",
      //             onTap: () async {
      //               if (_formKey.currentState!.validate()) {
      //                 _formKey.currentState!.save();
      //                 formData['isactive'] = isactive;
      //                 try {
      //                   print(formData);
      //                   Map<String, dynamic> createdEntity =
      //                       await apiService.createEntity(formData);

      //                   Navigator.pop(context);
      //                 } catch (e) {
      //                   showDialog(
      //                     context: context,
      //                     builder: (BuildContext context) {
      //                       return AlertDialog(
      //                         title: const Text('Error'),
      //                         content: Text('Failed to create Match: $e'),
      //                         actions: [
      //                           TextButton(
      //                             child: const Text('OK'),
      //                             onPressed: () {
      //                               Navigator.of(context).pop();
      //                             },
      //                           ),
      //                         ],
      //                       );
      //                     },
      //                   );
      //                 }
      //               }
      //             },
      //           ),
      //         ],
      //       ),
      //     ),
      //   ),
      // ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Consumer<MatchProvider>(
            builder: (context, formProvider, child) {
              return Form(
                key: formProvider.formKey,
                child: Column(
                  children: [
                    // DropdownButtonFormField with default value and null check
                    DropdownButtonFormField<String>(
                      decoration: customInputDecoration('Tournament Name'),
                      value: formProvider.selectedTournamentName,
                      items: [
                        const DropdownMenuItem<String>(
                          value: '',
                          child: Text('Select Tournament'),
                        ),
                        ...formProvider.tournamentNameItems.map((item) {
                          return DropdownMenuItem<String>(
                            value: item['id'].toString(),
                            child: Text(item['tournament_name'].toString()),
                          );
                        }).toList(),
                      ],
                      onChanged: (value) {
                        formProvider.selectedTournamentName = value!;
                      },
                      onSaved: (value) {
                        formProvider.updateFormData(
                          'tournament_id',
                          formProvider.selectedTournamentName ?? 'no value',
                        );
                      },
                    ),

                    const SizedBox(height: 16),

                    // DropdownButtonFormField for Team 1
                    DropdownButtonFormField<String>(
                      decoration: customInputDecoration('Team 1'),
                      value: formProvider.selectedTeam1Name,
                      items: [
                        const DropdownMenuItem<String>(
                          value: '',
                          child: Text('Select Team 1'),
                        ),
                        ...formProvider.teamNameItems.map((item) {
                          return DropdownMenuItem<String>(
                            value: item['id'].toString(),
                            child: Text(item['team_name'].toString()),
                          );
                        }).toList(),
                      ],
                      onChanged: (value) {
                        formProvider.selectedTeam1Name = value!;
                      },
                      onSaved: (value) {
                        formProvider.updateFormData(
                          'team_1_id',
                          formProvider.selectedTeam1Name ?? 'no value',
                        );
                      },
                    ),

                    const SizedBox(height: 16),

                    // DropdownButtonFormField for Team 2
                    DropdownButtonFormField<String>(
                      decoration: customInputDecoration('Team 2'),
                      value: formProvider.selectedTeam2Name,
                      items: [
                        const DropdownMenuItem<String>(
                          value: '',
                          child: Text('Select Team 2'),
                        ),
                        ...formProvider.teamNameItems.map((item) {
                          return DropdownMenuItem<String>(
                            value: item['id'].toString(),
                            child: Text(item['team_name'].toString()),
                          );
                        }).toList(),
                      ],
                      onChanged: (value) {
                        formProvider.selectedTeam2Name = value!;
                      },
                      onSaved: (value) {
                        formProvider.updateFormData(
                          'team_2_id',
                          formProvider.selectedTeam2Name ?? 'no value',
                        );
                      },
                    ),

                    const SizedBox(height: 16),

                    // Location TextField
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Location',
                        hintText: "Enter location",
                        border: OutlineInputBorder(),
                      ),
                      onSaved: (value) {
                        formProvider.updateFormData('location', value);
                      },
                    ),

                    const SizedBox(height: 16),

                    // DateTime Picker Field
                    TextFormField(
                      initialValue: DateFormat('yyyy-MM-dd HH:mm')
                          .format(formProvider.selectedDateTime),
                      decoration: customInputDecoration2(
                          'Date And Time', const Icon(Icons.calendar_today)),
                      readOnly: true,
                      onTap: () => formProvider.selectDateTime(context),
                      onSaved: (value) {
                        formProvider.updateFormData(
                          'datetime_field',
                          DateFormat('yyyy-MM-dd HH:mm')
                              .format(formProvider.selectedDateTime),
                        );
                      },
                    ),

                    const SizedBox(height: 16),

                    // Description TextField
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Description',
                        hintText: "Enter Description",
                        border: OutlineInputBorder(),
                      ),
                      onSaved: (value) {
                        formProvider.updateFormData('description', value);
                      },
                    ),

                    const SizedBox(height: 16),

                    // Active Switch
                    Row(
                      children: [
                        Switch(
                          value: formProvider.isActive,
                          onChanged: formProvider.toggleIsActive,
                        ),
                        const SizedBox(width: 8),
                        const Text('Active', style: TextStyle(color: Colors.black)),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Submit Button
                    ElevatedButton(
                      onPressed: () async {
                        if (formProvider.formKey.currentState!.validate()) {
                          formProvider.formKey.currentState!.save();
                          formProvider.updateFormData(
                              'isactive', formProvider.isActive);

                          try {
                            final createdEntity = await formProvider.apiService
                                .createEntity(formProvider.formData);
                            Navigator.pop(context);
                          } catch (e) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Error'),
                                  content: Text('Failed to create Match: $e'),
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
                      child: const Text("Submit"),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    
      
      bottomNavigationBar: BottomAppBarWidget(),
    );
  }
}