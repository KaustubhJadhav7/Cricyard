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
import '../viewmodel/Select_Team_api_service.dart';
import '/providers/token_manager.dart';

class select_teamUpdateEntityScreen extends StatefulWidget {
  final Map<String, dynamic> entity;

  select_teamUpdateEntityScreen({required this.entity});

  @override
  _select_teamUpdateEntityScreenState createState() =>
      _select_teamUpdateEntityScreenState();
}

class _select_teamUpdateEntityScreenState
    extends State<select_teamUpdateEntityScreen> {
  final SelectTeamApiService apiService = SelectTeamApiService();
  final _formKey = GlobalKey<FormState>();

  List<Map<String, dynamic>> team_nameItems = [];
  var selectedteam_nameValue;
  Future<void> fetchteam_nameItems() async {
    final token = await TokenManager.getToken();
    try {
      final selectTdata = await apiService.getTeamName(token!);
      print('team_name data is : $selectTdata');
      // Handle null or empty dropdownData
      if (selectTdata != null && selectTdata.isNotEmpty) {
        setState(() {
          team_nameItems = selectTdata;
          // Set the initial value of selectedselect_tValue based on the entity's value
          selectedteam_nameValue = widget.entity['team_name'] ?? null;
        });
      } else {
        print('team_name data is null or empty');
      }
    } catch (e) {
      print('Failed to load team_name items: $e');
    }
  }

  @override
  void initState() {
    super.initState();

    fetchteam_nameItems(); // Fetch dropdown items when the screen initializes
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
          title: AppbarTitle(text: "Update Select_Team")),
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
                          Text("Team Name",
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: AppStyle.txtGilroyMedium16Bluegray900),
                          CustomTextFormField(
                              focusNode: FocusNode(),
                              hintText: "Enter Team Name",
                              initialValue: widget.entity['team_name'],
                              maxLines: 4,

                              // ValidationProperties

                              onsaved: (value) {
                                widget.entity['team_name'] = value;
                              },
                              margin: getMargin(top: 6))
                        ])),
                SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: 'Team Name'),
                  value: selectedteam_nameValue,
                  items: [
                    const DropdownMenuItem<String>(
                      value: null,
                      child: Text('No Value'),
                    ),
                    ...team_nameItems.map<DropdownMenuItem<String>>(
                      (item) {
                        return DropdownMenuItem<String>(
                          value: item['team_name'].toString(),
                          child: Text(item['team_name'].toString()),
                        );
                      },
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      selectedteam_nameValue = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a Team Name ';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    widget.entity['team_name'] = value;
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
                              content: Text('Failed to update Select_Team: $e'),
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
