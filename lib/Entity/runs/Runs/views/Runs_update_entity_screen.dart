// ignore_for_file: use_build_context_synchronously
import 'package:cricyard/Entity/runs/Runs/model/Runs_model.dart';
import 'package:cricyard/Entity/runs/Runs/viewmodel/Runs_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../../../Utils/image_constant.dart';
import '../../../../Utils/size_utils.dart';
import '../../../../theme/app_style.dart';
import '../../../../views/widgets/app_bar/appbar_image.dart';
import '../../../../views/widgets/app_bar/appbar_title.dart';
import '../../../../views/widgets/app_bar/custom_app_bar.dart';
import '../../../../views/widgets/custom_button.dart';
import '../../../../views/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import '../repository/Runs_api_service.dart';
import '/providers/token_manager.dart';

import 'package:flutter/services.dart';

class runsUpdateEntityScreen extends StatefulWidget {
  final RunsEntity entity;

  runsUpdateEntityScreen({required this.entity});

  @override
  _runsUpdateEntityScreenState createState() => _runsUpdateEntityScreenState();
}

class _runsUpdateEntityScreenState extends State<runsUpdateEntityScreen> {
  final _formKey = GlobalKey<FormState>();

  bool isactive = false;

  // List<Map<String, dynamic>> select_fieldItems = [];
  var selectedselect_fieldValue;
  // Future<void> fetchselect_fieldItems() async {
  //   final token = await TokenManager.getToken();
  //   try {
  //     final selectTdata = await apiService.getselectField();
  //     print('select_field data is : $selectTdata');
  //     // Handle null or empty dropdownData
  //     if (selectTdata != null && selectTdata.isNotEmpty) {
  //       setState(() {
  //         select_fieldItems = selectTdata;
  //         // Set the initial value of selectedselect_tValue based on the entity's value
  //         selectedselect_fieldValue = widget.entity['select_field'] ?? null;
  //       });
  //     } else {
  //       print('select_field data is null or empty');
  //     }
  //   } catch (e) {
  //     print('Failed to load select_field items: $e');
  //   }
  // }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider =
          Provider.of<RunsEntitiesProvider>(context, listen: false);

      super.initState();

      isactive = widget.entity.active ?? false; // Set initial value

      provider.fetchSelectFieldItems(
          selectedselect_fieldValue); // Fetch dropdown items when the screen initializes
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RunsEntitiesProvider>(context, listen: false);
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
          title: AppbarTitle(text: "Update Runs")),
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
                              initialValue: widget.entity.description,
                              maxLines: 4,

                              // ValidationProperties

                              onsaved: (value) {
                                widget.entity.description = value ?? "";
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
                    padding: getPadding(top: 19),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Number of Runs",
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: AppStyle.txtGilroyMedium16Bluegray900),
                          CustomTextFormField(
                              focusNode: FocusNode(),
                              hintText: "Enter Number of Runs",
                              initialValue:
                                  widget.entity.numberOfRuns.toString(),
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9]'))
                              ],

                              // ValidationProperties

                              onsaved: (value) {
                                if (value != null && value.isNotEmpty) {
                                  widget.entity.numberOfRuns = int.parse(
                                      value); // Parse the string to int
                                }
                              },
                              margin: getMargin(top: 6))
                        ])),
                SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: 'select Field'),
                  value: selectedselect_fieldValue,
                  items: [
                    const DropdownMenuItem<String>(
                      value: null,
                      child: Text('No Value'),
                    ),
                    ...selectedselect_fieldValue.map<DropdownMenuItem<String>>(
                      (item) {
                        return DropdownMenuItem<String>(
                          value: item['player_name'].toString(),
                          child: Text(item['player_name'].toString()),
                        );
                      },
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      selectedselect_fieldValue = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a select Field ';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    widget.entity.selectField = value;
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

                      widget.entity.active = isactive;

                      try {
                        await provider.updateEntity(
                            widget.entity
                                .id, // Assuming 'id' is the key in your entity map
                            widget.entity);

                        Navigator.pop(context);
                      } catch (e) {
                        // ignore: use_build_context_synchronously
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Error'),
                              content: Text('Failed to update Runs: $e'),
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
