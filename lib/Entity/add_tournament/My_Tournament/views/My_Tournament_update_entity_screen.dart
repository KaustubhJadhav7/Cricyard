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
import 'package:intl/intl.dart';

import '../viewmodel/My_Tournament_api_service.dart';
import '/providers/token_manager.dart';

class my_tournamentUpdateEntityScreen extends StatefulWidget {
  final Map<String, dynamic> entity;

  my_tournamentUpdateEntityScreen({required this.entity});

  @override
  _my_tournamentUpdateEntityScreenState createState() =>
      _my_tournamentUpdateEntityScreenState();
}

class _my_tournamentUpdateEntityScreenState
    extends State<my_tournamentUpdateEntityScreen> {
  final MyTournamentApiService apiService = MyTournamentApiService();
  final _formKey = GlobalKey<FormState>();

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    print(picked);
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  List<Map<String, dynamic>> tournament_nameItems = [];
  var selectedtournament_nameValue;
  Future<void> fetchtournament_nameItems() async {
    final token = await TokenManager.getToken();
    try {
      final selectTdata = await apiService.getTournamentName(token!);
      print('tournament_name data is : $selectTdata');
      // Handle null or empty dropdownData
      if (selectTdata != null && selectTdata.isNotEmpty) {
        setState(() {
          tournament_nameItems = selectTdata;
          // Set the initial value of selectedselect_tValue based on the entity's value
          selectedtournament_nameValue =
              widget.entity['tournament_name'] ?? null;
        });
      } else {
        print('tournament_name data is null or empty');
      }
    } catch (e) {
      print('Failed to load tournament_name items: $e');
    }
  }

  @override
  void initState() {
    super.initState();

    fetchtournament_nameItems(); // Fetch dropdown items when the screen initializes
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
          title: AppbarTitle(text: "Update My_Tournament")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
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
                Padding(
                    padding: getPadding(top: 19),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Rules",
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: AppStyle.txtGilroyMedium16Bluegray900),
                          CustomTextFormField(
                              focusNode: FocusNode(),
                              hintText: "Enter Rules",
                              initialValue: widget.entity['rules'],
                              maxLines: 5,

                              // ValidationProperties

                              onsaved: (value) {
                                widget.entity['rules'] = value;
                              },
                              margin: getMargin(top: 6))
                        ])),
                SizedBox(height: 16),
                Padding(
                  padding: getPadding(top: 18),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Venues",
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: AppStyle.txtGilroyMedium16Bluegray900),
                        CustomTextFormField(
                            focusNode: FocusNode(),
                            hintText: "Please Enter Venues",
                            initialValue: widget.entity['venues'],

                            // ValidationProperties
                            onsaved: (value) => widget.entity['venues'] = value,
                            margin: getMargin(top: 7))
                      ]),
                ),
                GestureDetector(
                  onTap: () => _selectDate(context),
                  child: AbsorbPointer(
                    child: TextFormField(
                      initialValue: DateFormat('yyyy-MM-dd')
                          .format(DateTime.parse(widget.entity['dates'])),
                      decoration: const InputDecoration(
                        labelText: 'dates',
                        suffixIcon: Icon(Icons.calendar_today),
                      ),
                      onSaved: (value) {
                        widget.entity['dates'] =
                            DateFormat('yyyy-MM-dd').format(selectedDate);
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: getPadding(top: 18),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Sponsors",
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: AppStyle.txtGilroyMedium16Bluegray900),
                        CustomTextFormField(
                            focusNode: FocusNode(),
                            hintText: "Please Enter Sponsors",
                            initialValue: widget.entity['sponsors'],

                            // ValidationProperties
                            onsaved: (value) =>
                                widget.entity['sponsors'] = value,
                            margin: getMargin(top: 7))
                      ]),
                ),
                DropdownButtonFormField<String>(
                  decoration:
                      const InputDecoration(labelText: 'Tournament Name'),
                  value: selectedtournament_nameValue,
                  items: [
                    const DropdownMenuItem<String>(
                      value: null,
                      child: Text('No Value'),
                    ),
                    ...tournament_nameItems.map<DropdownMenuItem<String>>(
                      (item) {
                        return DropdownMenuItem<String>(
                          value: item['tournament_name'].toString(),
                          child: Text(item['tournament_name'].toString()),
                        );
                      },
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      selectedtournament_nameValue = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a Tournament Name ';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    widget.entity['tournament_name'] = value;
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

                      final token = await TokenManager.getToken();
                      try {
                        await apiService.updateEntity(
                            token!,
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
                              content:
                                  Text('Failed to update My_Tournament: $e'),
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
