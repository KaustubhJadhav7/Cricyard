// ignore_for_file: use_build_context_synchronously
import 'package:cricyard/core/utils/size_utils.dart';
import 'package:flutter/material.dart';
import '../../../../../Entity/add_tournament/My_Tournament/repository/My_Tournament_api_service.dart';
import '../../../../../Entity/team/Teams/repository/Teams_api_service.dart';
import '../../../../../Utils/image_constant.dart';
import '../../../../../Utils/size_utils.dart';
import '../../../../../theme/theme_helper.dart';
import '../../../../widgets/custom_button.dart';
import 'package:intl/intl.dart';
import '../../../../widgets/custom_icon_button.dart';
import '../../../../widgets/custom_image_view.dart';
import '../../../ReuseableWidgets/BottomAppBarWidget.dart';
import '/providers/token_manager.dart';

class RegisterTournament extends StatefulWidget {
  const RegisterTournament({super.key});

  @override
  _RegisterTournamentState createState() => _RegisterTournamentState();
}

class _RegisterTournamentState extends State<RegisterTournament> {
  final MyTournamentApiService apiService = MyTournamentApiService();
  final teamsApiService teamapiService = teamsApiService();

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

  List<Map<String, dynamic>> tournament_nameItems = [];
  var selectedtournament_nameValue =
      ''; // Use nullable type  Future<void> _load
  Future<void> _loadtournament_nameItems() async {
    final token = await TokenManager.getToken();
    try {
      final selectTdata = await apiService.getTournamentName();
      print(' tournament_name   data is : $selectTdata');
      // Handle null or empty dropdownData
      if (selectTdata != null && selectTdata.isNotEmpty) {
        setState(() {
          tournament_nameItems = selectTdata;
          // print('Tournament Items Set: $tournament_nameItems');
        });
      } else {
        print('Tournament Data is null or empty.');
      }
    } catch (e) {
      print('Failed to load  tournament_name   items: $e');
    }
  }

  List<Map<String, dynamic>> teamNameItems = [];
  var selectedteamName = ''; // Use nullable type  Future<void> _load

  Future<void> loadTeamnameItems() async {
    try {
      final selectTdata = await teamapiService.getMyTeam();
      // Handle null or empty dropdownData
      if (selectTdata != null && selectTdata.isNotEmpty) {
        setState(() {
          teamNameItems = selectTdata;
          // print('Team Items Set: $teamNameItems');
        });
      } else {
        print('Team Data is null or empty.');
      }
    } catch (e) {
      print('Failed to load  Teams  items: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _loadtournament_nameItems();
    loadTeamnameItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(getVerticalSize(49)),
        child: Container(
          // Adjust the top margin as needed
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
                    " Register Tournament ",
                    style: theme.textTheme.headlineLarge,
                  ),
                ),
              ],
            ),
          ),
        ),
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
                      const Text(
                        "Tournament Name",
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              8.0), // Adjust border radius as needed
                          border: Border.all(
                            color: Colors.grey, // Adjust border color as needed
                            width: 1.0, // Adjust border width as needed
                          ),
                        ),
                        child: DropdownButtonFormField<String>(
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 16.0,
                                vertical: 8.0), // Adjust padding as needed
                            hintText:
                                'Please select Tournament Name', // Adjust hint text as needed
                            border: InputBorder
                                .none, // Hide the default dropdown border
                          ),
                          value: selectedtournament_nameValue.isNotEmpty
                              ? selectedtournament_nameValue
                              : null,
                          items: [
                            // Add an item with an empty value to represent no selection
                            const DropdownMenuItem<String>(
                              value: '',
                              child: Text('Select option'),
                            ),
                            // Map your dropdownItems as before
                            ...tournament_nameItems
                                .map<DropdownMenuItem<String>>(
                              (item) {
                                return DropdownMenuItem<String>(
                                  value: item['id'].toString(),
                                  child:
                                      Text(item['tournament_name'].toString()),
                                );
                              },
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              selectedtournament_nameValue = value!;
                            });
                          },
                          onSaved: (value) {
                            if (selectedtournament_nameValue.isEmpty) {
                              selectedtournament_nameValue = "no value";
                            }
                            formData['tournament_id'] =
                                selectedtournament_nameValue;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: getPadding(top: 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        "Team Name",
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              8.0), // Adjust border radius as needed
                          border: Border.all(
                            color: Colors.grey, // Adjust border color as needed
                            width: 1.0, // Adjust border width as needed
                          ),
                        ),
                        child: DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 16.0,
                                vertical: 8.0), // Adjust padding as needed
                            hintText:
                                'Please select Team Name', // Adjust hint text as needed
                            border: InputBorder
                                .none, // Hide the default dropdown border
                          ),
                          value: selectedteamName,
                          items: [
                            // Add an item with an empty value to represent no selection
                            DropdownMenuItem<String>(
                              value: '',
                              child: Text('Select option'),
                            ),
                            // Map your dropdownItems as before
                            ...teamNameItems.map<DropdownMenuItem<String>>(
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
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: getPadding(top: 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        "Dates",
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              8.0), // Adjust border radius as needed
                          border: Border.all(
                            color: Colors.grey, // Adjust border color as needed
                            width: 1.0, // Adjust border width as needed
                          ),
                        ),
                        child: GestureDetector(
                          onTap: () => _selectDate(context),
                          child: AbsorbPointer(
                            child: TextFormField(
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16.0,
                                    vertical: 12.0), // Adjust padding as needed
                                // labelText:
                                //     'dates', // Adjust label text as needed
                                suffixIcon: Icon(Icons.calendar_today),
                                border: InputBorder
                                    .none, // Hide the default text field border
                              ),
                              controller: TextEditingController(
                                text: DateFormat('yyyy-MM-dd')
                                    .format(selectedDate),
                              ),
                              onSaved: (value) => formData['dates'] =
                                  DateFormat('yyyy-MM-dd').format(selectedDate),
                            ),
                          ),
                        ),
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
                        print(
                            "This is my formdata in register tournament $formData");
                        Map<String, dynamic> createdEntity =
                            await apiService.registerTournament(formData);

                        Navigator.pop(context);
                      } catch (e) {
                        print('$e');
                        String errorMessage =
                            e.toString().contains('Team Already Registered!')
                                ? 'Team Already Registered!'
                                : 'Failed to register tournament: $e';
                        // ignore: use_build_context_synchronously
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Error'),
                              content: Text(
                                // 'Failed to create My_Tournament: $e',
                                errorMessage,
                                style: const TextStyle(color: Colors.black),
                              ),
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
      bottomNavigationBar: BottomAppBarWidget(),
    );
  }
}
