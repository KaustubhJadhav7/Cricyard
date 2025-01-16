// ignore_for_file: use_build_context_synchronously
import 'package:cricyard/Entity/select_team/Select_Team/model/Select_Team_model.dart';
import 'package:cricyard/Entity/select_team/Select_Team/viewmodel/Select_Team_viewmodel.dart';
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
import '../repository/Select_Team_api_service.dart';

class select_teamUpdateEntityScreen extends StatefulWidget {
  final SelectTeamEntity entity;

  select_teamUpdateEntityScreen({required this.entity});

  @override
  _select_teamUpdateEntityScreenState createState() =>
      _select_teamUpdateEntityScreenState();
}

class _select_teamUpdateEntityScreenState
    extends State<select_teamUpdateEntityScreen> {
  final SelectTeamApiService apiService = SelectTeamApiService();
  final _formKey = GlobalKey<FormState>();

  // List<Map<String, dynamic>> team_nameItems = [];
  // var selectedteam_nameValue;
  // Future<void> fetchteam_nameItems() async {
  //   final token = await TokenManager.getToken();
  //   try {
  //     final selectTdata = await apiService.getTeamName();
  //     print('team_name data is : $selectTdata');
  //     // Handle null or empty dropdownData
  //     if (selectTdata != null && selectTdata.isNotEmpty) {
  //       setState(() {
  //         team_nameItems = selectTdata;
  //         // Set the initial value of selectedselect_tValue based on the entity's value
  //         selectedteam_nameValue = widget.entity['team_name'] ?? null;
  //       });
  //     } else {
  //       print('team_name data is null or empty');
  //     }
  //   } catch (e) {
  //     print('Failed to load team_name items: $e');
  //   }
  // }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
    final provider = Provider.of<SelectTeamProvider>(context, listen: false);
    super.initState();

    provider.loadTeamNameItems();
  });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SelectTeamProvider>(context, listen: false);
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
                              initialValue: widget.entity.teamName,
                              maxLines: 4,

                              // ValidationProperties

                              onsaved: (value) {
                                widget.entity.teamName = value;
                              },
                              margin: getMargin(top: 6))
                        ])),
                SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: 'Team Name'),
                  value: provider.selectedTeamNameValue,
                  items: [
                    const DropdownMenuItem<String>(
                      value: null,
                      child: Text('No Value'),
                    ),
                    ...provider.teamNameItems.map<DropdownMenuItem<String>>(
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
                      provider.selectedTeamNameValue = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a Team Name ';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    widget.entity.teamName = value;
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
                        await provider.updateEntity(
                            widget.entity.id, 
                            widget.entity, context);
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
