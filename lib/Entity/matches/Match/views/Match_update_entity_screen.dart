// ignore_for_file: use_build_context_synchronously
import 'package:google_fonts/google_fonts.dart';

import '../../../../Utils/image_constant.dart';
import '../../../../Utils/size_utils.dart';
import '../../../../theme/app_style.dart';
import '../../../../views/widgets/app_bar/appbar_image.dart';
import '../../../../views/widgets/app_bar/appbar_title.dart';
import '../../../../views/widgets/app_bar/custom_app_bar.dart';
import '../../../../views/widgets/custom_button.dart';
import '../../../../views/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../repository/Match_api_service.dart';
import '/providers/token_manager.dart';

import 'package:flutter/services.dart';

class matchUpdateEntityScreen extends StatefulWidget {
  final Map<String, dynamic> entity;

  matchUpdateEntityScreen({required this.entity});

  @override
  _matchUpdateEntityScreenState createState() =>
      _matchUpdateEntityScreenState();
}

class _matchUpdateEntityScreenState extends State<matchUpdateEntityScreen> {
  final MatchApiService apiService = MatchApiService();
  final _formKey = GlobalKey<FormState>();

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    print(picked);
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  DateTime selectedDateTime = DateTime.now();

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

  bool isactive = false;

  @override
  void initState() {
    super.initState();

    isactive = widget.entity['active'] ?? false; // Set initial value
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
                  color: const Color(0xFF219ebc),
                  borderRadius: BorderRadius.circular(12)),
              child: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
              ),
            ),
          ),
        ),
        title: Text(
          "Reschedule Match",
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
                Padding(
                  padding: getPadding(top: 18),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Team 1",
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: AppStyle.txtGilroyMedium16Bluegray900),
                        CustomTextFormField(
                            focusNode: FocusNode(),
                            hintText: "Please Enter Team 1",
                            initialValue: widget.entity['team_1'],

                            // ValidationProperties
                            onsaved: (value) => widget.entity['team_1'] = value,
                            margin: getMargin(top: 7))
                      ]),
                ),
                Padding(
                  padding: getPadding(top: 18),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Team 2",
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: AppStyle.txtGilroyMedium16Bluegray900),
                        CustomTextFormField(
                            focusNode: FocusNode(),
                            hintText: "Please Enter Team 2",
                            initialValue: widget.entity['team_2'],

                            // ValidationProperties
                            onsaved: (value) => widget.entity['team_2'] = value,
                            margin: getMargin(top: 7))
                      ]),
                ),
                Padding(
                  padding: getPadding(top: 18),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Location",
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: AppStyle.txtGilroyMedium16Bluegray900),
                        CustomTextFormField(
                            focusNode: FocusNode(),
                            hintText: "Please Enter Location",
                            initialValue: widget.entity['location'],

                            // ValidationProperties
                            onsaved: (value) =>
                                widget.entity['location'] = value,
                            margin: getMargin(top: 7))
                      ]),
                ),
                GestureDetector(
                  onTap: () => _selectDate(context),
                  child: AbsorbPointer(
                    child: TextFormField(
                      initialValue: DateFormat('yyyy-MM-dd')
                          .format(DateTime.parse(widget.entity['datetime_field'])),
                      decoration: const InputDecoration(
                        labelText: 'date_field',
                        suffixIcon: Icon(Icons.calendar_today),
                      ),
                      onSaved: (value) {
                        widget.entity['date_field'] =
                            DateFormat('yyyy-MM-dd').format(selectedDate);
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  initialValue: DateFormat('yyyy-MM-dd HH:mm')
                      .format(DateTime.parse(widget.entity['datetime_field'])),
                  decoration: const InputDecoration(
                    labelText: 'datetime_field',
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                  // readOnly: true, // Set to true to prevent user input
                  onTap: () => _selectDateTime(context),
                  onSaved: (value) {
                    widget.entity['datetime_field'] =
                        DateFormat('yyyy-MM-dd HH:mm').format(selectedDateTime);
                  },
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: getPadding(top: 18),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Name",
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: AppStyle.txtGilroyMedium16Bluegray900),
                        CustomTextFormField(
                            focusNode: FocusNode(),
                            hintText: "Please Enter Name",
                            initialValue: widget.entity['name'],

                            // ValidationProperties
                            onsaved: (value) => widget.entity['name'] = value,
                            margin: getMargin(top: 7))
                      ]),
                ),
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
                              focusNode: FocusNode(),
                              hintText: "Enter Description",
                              initialValue: widget.entity['description'],
                              maxLines: 5,

                              // ValidationProperties

                              onsaved: (value) {
                                widget.entity['description'] = value;
                              },
                              margin: getMargin(top: 6))
                        ])),
                SizedBox(height: 16),
                Row(
                  children: [
                    Switch(
                      value: isactive,
                      onChanged: (newValue) {
                        setState(() {
                          isactive = newValue;
                        });
                      },
                    ),
                    const SizedBox(width: 8),
                    const Text('Active'),
                  ],
                ),
                Padding(
                  padding: getPadding(top: 18),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("User Id",
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: AppStyle.txtGilroyMedium16Bluegray900),
                        CustomTextFormField(
                            focusNode: FocusNode(),
                            hintText: "Please Enter User Id",
                            initialValue: widget.entity['user_id'],

                            // ValidationProperties
                            onsaved: (value) =>
                                widget.entity['user_id'] = value,
                            margin: getMargin(top: 7))
                      ]),
                ),
                CustomButton(
                  height: getVerticalSize(50),
                  text: "Update",
                  margin: getMargin(top: 24, bottom: 5),
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();

                      widget.entity['active'] = isactive;

                      final token = await TokenManager.getToken();
                      try {
                        await apiService.updateEntity(
                            widget.entity[
                                'id'], // Assuming 'id' is the key in your entity map
                            widget.entity);

                        Navigator.pop(context);
                      } catch (e) {
                        // ignore: use_build_context_synchronously
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Error'),
                              content: Text('Failed to update Match: $e'),
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
