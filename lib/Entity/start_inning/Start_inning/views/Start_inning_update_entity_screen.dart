// ignore_for_file: use_build_context_synchronously
import 'package:cricyard/Entity/start_inning/Start_inning/model/Start_inning_model.dart';
import 'package:cricyard/Entity/start_inning/Start_inning/viewmodels/Start_inning_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../../../Utils/image_constant.dart';
import '../../../../Utils/size_utils.dart';
import '../../../../views/widgets/app_bar/appbar_image.dart';
import '../../../../views/widgets/app_bar/appbar_title.dart';
import '../../../../views/widgets/app_bar/custom_app_bar.dart';
import '../../../../views/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../repository/Start_inning_api_service.dart';

class start_inningUpdateEntityScreen extends StatefulWidget {
  final StartInningModel entity;

  start_inningUpdateEntityScreen({required this.entity});

  @override
  _start_inningUpdateEntityScreenState createState() =>
      _start_inningUpdateEntityScreenState();
}

class _start_inningUpdateEntityScreenState
    extends State<start_inningUpdateEntityScreen> {
  final start_inningApiService apiService = start_inningApiService();
  final _formKey = GlobalKey<FormState>();

  var selectedselect_match; // Initialize with the default value \n);
  List<String> select_matchList = [
    'bar_code',
    'qr_code',
  ];

  var selectedselect_team; // Initialize with the default value \n);
  List<String> select_teamList = [
    'bar_code',
    'qr_code',
  ];

  var selectedselect_player; // Initialize with the default value \n);
  List<String> select_playerList = [
    'bar_code',
    'qr_code',
  ];

  DateTime selectedDateTime = DateTime.now();

  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDateTime,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(selectedDateTime),
      );
      print(pickedTime);
      if (pickedTime != null) {
        setState(() {
          selectedDateTime = DateTime(
            picked.year,
            picked.month,
            picked.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    selectedselect_match =
        widget.entity.selectMatch; // Initialize with the default value

    selectedselect_team =
        widget.entity.selectTeam; // Initialize with the default value

    selectedselect_player =
        widget.entity.selectPlayer; // Initialize with the default value
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<StartInningProvider>(context, listen: false);
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
          title: AppbarTitle(text: "Update Start_inning")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                DropdownButtonFormField<String>(
                  decoration:
                      const InputDecoration(labelText: 'Selectselect_match'),
                  value: widget.entity.selectMatch,
                  items: select_matchList
                      .map((name) => DropdownMenuItem<String>(
                            value: name,
                            child: Text(name),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedselect_match = value!;
                      widget.entity.selectMatch = value;
                    });
                  },
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  decoration:
                      const InputDecoration(labelText: 'Selectselect_team'),
                  value: widget.entity.selectTeam,
                  items: select_teamList
                      .map((name) => DropdownMenuItem<String>(
                            value: name,
                            child: Text(name),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedselect_team = value!;
                      widget.entity.selectTeam = value;
                    });
                  },
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  decoration:
                      const InputDecoration(labelText: 'Selectselect_player'),
                  value: widget.entity.selectPlayer,
                  items: select_playerList
                      .map((name) => DropdownMenuItem<String>(
                            value: name,
                            child: Text(name),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedselect_player = value!;
                      widget.entity.selectPlayer = value;
                    });
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  initialValue: DateFormat('yyyy-MM-dd HH:mm')
                      .format(DateTime.parse(widget.entity.datetimeField)),
                  decoration: const InputDecoration(
                    labelText: 'datetime_field',
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                  // readOnly: true, // Set to true to prevent user input
                  onTap: () => _selectDateTime(context),
                  onSaved: (value) {
                    widget.entity.datetimeField =
                        DateFormat('yyyy-MM-dd HH:mm').format(selectedDateTime);
                  },
                ),
                const SizedBox(height: 16),
                CustomButton(
                  height: getVerticalSize(50),
                  text: "Update",
                  margin: getMargin(top: 24, bottom: 5),
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      
                        // await apiService.updateEntity(
                        //     widget.entity[
                        //         'id'], // Assuming 'id' is the key in your entity map
                        //     widget.entity);
                        await provider.updateEntity(widget.entity, context);

                        Navigator.pop(context);
                      
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
