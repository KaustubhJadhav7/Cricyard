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
import '../viewmodels/Retired_api_service.dart';
import '/providers/token_manager.dart';
import 'package:flutter/services.dart';

class retiredUpdateEntityScreen extends StatefulWidget {
  final Map<String, dynamic> entity;

  retiredUpdateEntityScreen({required this.entity});

  @override
  _retiredUpdateEntityScreenState createState() =>
      _retiredUpdateEntityScreenState();
}

class _retiredUpdateEntityScreenState extends State<retiredUpdateEntityScreen> {
  final RetiredApiService apiService = RetiredApiService();
  final _formKey = GlobalKey<FormState>();

  bool isactive = false;

  var selectedplayer_name; // Initialize with the default value \n);
  List<String> player_nameList = [
    'bar_code',
    'qr_code',
  ];

  String? selectedcan_batter_bat_again;
  Future<void> _showcan_batter_bat_againSelectionDialog(
      BuildContext context) async {
    final result = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Select can_batter_bat_again'),
          children: [
            RadioListTile<String>(
              title: const Text('bar_code'),
              value: 'bar_code',
              groupValue: selectedcan_batter_bat_again,
              onChanged: (value) {
                setState(() {
                  selectedcan_batter_bat_again = value;
                  Navigator.pop(context, value);
                });
              },
            ),
            RadioListTile<String>(
              title: const Text('qr_code'),
              value: 'qr_code',
              groupValue: selectedcan_batter_bat_again,
              onChanged: (value) {
                setState(() {
                  selectedcan_batter_bat_again = value;
                  Navigator.pop(context, value);
                });
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();

    isactive = widget.entity['active'] ?? false; // Set initial value

    selectedplayer_name =
        widget.entity['player_name']; // Initialize with the default value

    selectedcan_batter_bat_again = widget.entity['can_batter_bat_again'] ??
        ''; // Initialize selected can_batter_bat_again
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
          title: AppbarTitle(text: "Update Retired")),
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
                              maxLines: 4,

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
                DropdownButtonFormField<String>(
                  decoration:
                      const InputDecoration(labelText: 'Selectplayer_name'),
                  value: widget.entity['player_name'],
                  items: player_nameList
                      .map((name) => DropdownMenuItem<String>(
                            value: name,
                            child: Text(name),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedplayer_name = value!;
                      widget.entity['player_name'] = value;
                    });
                  },
                ),
                const SizedBox(height: 16),
                Padding(
                    padding: getPadding(top: 19),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Can Batter bat again",
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: AppStyle.txtGilroyMedium16Bluegray900),
                          CustomTextFormField(
                              focusNode: FocusNode(),
                              hintText: "Enter Can Batter bat again",
                              readOnly: true,
                              controller: TextEditingController(
                                  text: selectedcan_batter_bat_again),
                              onTap: () =>
                                  _showcan_batter_bat_againSelectionDialog(
                                      context),

                              // ValidationProperties

                              onsaved: (value) {
                                widget.entity['can_batter_bat_again'] = value;
                              },
                              margin: getMargin(top: 6))
                        ])),
                const SizedBox(height: 16),
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
                              content: Text('Failed to update Retired: $e'),
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
