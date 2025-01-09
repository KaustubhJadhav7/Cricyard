// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../Entity/add_tournament/My_Tournament/repository/My_Tournament_api_service.dart';
import '../../../../../Entity/matches/Match/repository/Match_api_service.dart';
import '../../../../../Entity/team/viewmodels/Teams_api_service.dart';
import '../../../../../Utils/size_utils.dart';
import '../../../Login Screen/view/CustomButton.dart';
import '../../../ReuseableWidgets/BottomAppBarWidget.dart';
import 'package:intl/intl.dart';
import '/providers/token_manager.dart';
import 'package:flutter/services.dart';

class matchCreateEntityScreenById extends StatefulWidget {
  final int tourId;

  const matchCreateEntityScreenById({super.key, required this.tourId});

  @override
  _matchCreateEntityScreenByIdState createState() =>
      _matchCreateEntityScreenByIdState();

//custom input decorration
}

class _matchCreateEntityScreenByIdState
    extends State<matchCreateEntityScreenById> {


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

  bool isLoading = false;

  DateTime selectedDateTime = DateTime.now();
  TextEditingController dateTimeController = TextEditingController();

  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDateTime,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(selectedDateTime),
      );
      if (pickedTime != null) {
        print("Picked time --$pickedTime");
        setState(() {
          selectedDateTime = DateTime(
            picked.year,
            picked.month,
            picked.day,
            pickedTime.hour,
            pickedTime.minute,
          );
          print("Picked date-time --$selectedDateTime");
          dateTimeController.text =
              DateFormat('yyyy-MM-dd HH:mm').format(selectedDateTime);
        });
      }
    }
  }

  bool isactive = false;

  final teamsApiService teamapiService = teamsApiService();
  final MyTournamentApiService tourapiService = MyTournamentApiService();

  List<Map<String, dynamic>> teamNameItems = [];
  var selectedteam1Name = ''; // Use nullable type  Future<void> _load
  var selectedteam2Name = ''; // Use nullable type  Future<void> _load

  Future<void> loadTeamnameItems() async {
    try {
      final selectTdata = await teamapiService.getMyTeamByTourId(widget.tourId);
      // Handle null or empty dropdownData
      if (selectTdata != null && selectTdata.isNotEmpty) {
        setState(() {
          teamNameItems = selectTdata;
          print(' team Data is : $teamNameItems');
        });
      } else {
        print(' team   data is null or empty');
      }
    } catch (e) {
      print('Failed to load  Teams  items: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    // _loadtournament_nameItems();
    loadTeamnameItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        forceMaterialTransparency: true,
        backgroundColor: Colors.grey[200],
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color:const Color(0xFF219ebc),
                  borderRadius: BorderRadius.circular(12)),
              child: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
              ),
            ),
          ),
        ),
        title: Text(
          "Schedule Match",
          style:
          GoogleFonts.getFont('Poppins', fontSize: 20, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 16),

                // selecting team 1
                IconButton(
                  iconSize: 60,
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Select Team 1"),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: teamNameItems
                                .where((team) =>
                                    team['team_name'] !=
                                    selectedteam2Name) // Filter out selected Team 2
                                .map((team) {
                              return ListTile(
                                title: Text(team['team_name'].toString()),
                                onTap: () {
                                  setState(() {
                                    formData['team_1_id'] =
                                        team['team_id'].toString();
                                    selectedteam1Name = team['team_name']
                                        .toString(); // Update selected team name
                                  });
                                  Navigator.pop(context);
                                },
                              );
                            }).toList(),
                          ),
                        );
                      },
                    );
                  },
                  icon: const Icon(Icons.add_circle),
                ),
                Text(
                  selectedteam1Name.isNotEmpty
                      ? "selected $selectedteam1Name"
                      : "Select Team 1",
                  style: GoogleFonts.getFont('Poppins',
                      color: Colors.black, fontSize: 20),
                ),
                const SizedBox(
                  height: 20,
                ),

                // selecting team 2
                IconButton(
                  iconSize: 60,
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Select Team 1"),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: teamNameItems
                                .where((team) =>
                                    team['team_name'] !=
                                    selectedteam1Name) // Filter out selected Team 2
                                .map((team) {
                              return ListTile(
                                title: Text(team['team_name'].toString()),
                                onTap: () {
                                  setState(() {
                                    formData['team_2_id'] =
                                        team['team_id'].toString();
                                    selectedteam2Name = team['team_name']
                                        .toString(); // Update selected team name
                                  });
                                  Navigator.pop(context);
                                },
                              );
                            }).toList(),
                          ),
                        );
                      },
                    );
                  },
                  icon: const Icon(Icons.add_circle),
                ),
                Text(
                  selectedteam2Name.isNotEmpty
                      ? "selected $selectedteam2Name"
                      : "Select Team 2",
                  style: GoogleFonts.getFont('Poppins',
                      color: Colors.black, fontSize: 20),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: getPadding(top: 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextFormField(
                        focusNode: FocusNode(),
                        // autofocus: true,
                        // hintText: "Enter location",
                        // decoration: customInputDecoration('Location'),

                        decoration: const InputDecoration(
                          labelText: 'Location',
                          hintText: "Enter location",
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                // color: Color(0xFFC0FE53),
                                width: 2.0), // Parrot color
                            borderRadius: BorderRadius.all(
                                Radius.circular(5.0)), // Rectangular shape
                          ),
                          // focusedBorder: OutlineInputBorder(
                          //   borderSide: BorderSide(
                          //       color: Color(0xFFC0FE53),
                          //       width: 2.0), // Parrot color
                          //   borderRadius: BorderRadius.all(
                          //       Radius.circular(5.0)), // Rectangular shape
                          // ),
                        ),
                        onSaved: (value) => formData['location'] = value,
                        style: const TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),
                TextFormField(
                  controller: dateTimeController,
                  decoration: customInputDecoration2(
                      'Date And Time', const Icon(Icons.calendar_today)),
                  readOnly: true,
                  onTap: () => _selectDateTime(context),
                  onSaved: (value) {
                    formData['datetime_field'] =
                        DateFormat('yyyy-MM-dd HH:mm').format(selectedDateTime);
                  },
                ),
                const SizedBox(height: 16),

                TextFormField(
                  focusNode: FocusNode(),
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    hintText: "Enter Description",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          // color: Color(0xFFC0FE53),
                          width: 2.0), // Parrot color
                      borderRadius: BorderRadius.all(
                          Radius.circular(5.0)), // Rectangular shape
                    ),
                  ),
                  onSaved: (value) => formData['description'] = value,
                  style: const TextStyle(color: Colors.black),
                ),

                const SizedBox(height: 16),

                Switch(
                  value: isactive,
                  onChanged: (newValue) {
                    setState(() {
                      isactive = newValue;
                    });
                  },
                ),
                const SizedBox(width: 8),
                const Text(
                  'Active',
                  style: TextStyle(color: Colors.black),
                ),
                const SizedBox(height: 16),
                // const SizedBox(width: 8),
                CustomButton(
                  color: const Color(0xFF264653),
                  height: getVerticalSize(50),
                  text: "Submit",
                  // margin: getMargin(top: 24, bottom: 5),
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        isLoading = true;
                      });
                      _formKey.currentState!.save();

                      formData['isactive'] = isactive;
                      formData['tournament_id'] = widget.tourId;

                      final token = await TokenManager.getToken();
                      try {
                        print(formData);
                            await apiService.createEntity(formData).then((value) {
                              setState(() {
                                isLoading = false;
                                Navigator.pop(context);
                              });
                            },);


                      } catch (e) {
                        setState(() {
                          isLoading = false;
                        });
                        // ignore: use_build_context_synchronously
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