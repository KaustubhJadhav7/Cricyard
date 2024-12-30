// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import '../../../../Utils/image_constant.dart';
import '../../../../Utils/size_utils.dart';
import '../../../../theme/app_style.dart';
import '../../../../views/widgets/app_bar/appbar_image.dart';
import '../../../../views/widgets/app_bar/appbar_title.dart';
import '../../../../views/widgets/app_bar/custom_app_bar.dart';
import '../../../../views/widgets/custom_button.dart';
import '../../../../views/widgets/custom_text_form_field.dart';
import 'package:intl/intl.dart';

import '../viewmodel/Start_Match_api_service.dart';

class start_matchCreateEntityScreen extends StatefulWidget {
  const start_matchCreateEntityScreen({super.key});

  @override
  _start_matchCreateEntityScreenState createState() =>
      _start_matchCreateEntityScreenState();
}

class _start_matchCreateEntityScreenState
    extends State<start_matchCreateEntityScreen> {
  final StartMatchApiService apiService = StartMatchApiService();
  final Map<String, dynamic> formData = {};
  final _formKey = GlobalKey<FormState>();

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

  bool isactive = false;

  @override
  void initState() {
    super.initState();
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
          title: AppbarTitle(text: "Start Match")),
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
                        Text("Name of Match",
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: AppStyle.fieldlabel),
                        CustomTextFormField(
                          focusNode: FocusNode(),
                          hintText: "Please Enter Name of Match",
                          onsaved: (value) => formData['name_of_match'] = value,
                        )
                      ]),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: getPadding(top: 18),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Format",
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: AppStyle.fieldlabel),
                        CustomTextFormField(
                          focusNode: FocusNode(),
                          hintText: "Please Enter Format",
                          onsaved: (value) => formData['format'] = value,
                        )
                      ]),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: getPadding(top: 18),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Rules",
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: AppStyle.fieldlabel),
                        CustomTextFormField(
                          focusNode: FocusNode(),
                          hintText: "Please Enter Rules",
                          onsaved: (value) => formData['rules'] = value,
                        )
                      ]),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: getPadding(top: 18),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Venue",
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: AppStyle.fieldlabel),
                        CustomTextFormField(
                          focusNode: FocusNode(),
                          hintText: "Please Enter Venue",
                          onsaved: (value) => formData['venue'] = value,
                        )
                      ]),
                ),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: () => _selectDate(context),
                  child: AbsorbPointer(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'date_field',
                        suffixIcon: Icon(Icons.calendar_today),
                      ),
                      controller: TextEditingController(
                        text: DateFormat('yyyy-MM-dd').format(selectedDate),
                      ),
                      onSaved: (value) => formData['date_field'] =
                          DateFormat('yyyy-MM-dd').format(selectedDate),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
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
                              maxLines: 5,
                              focusNode: FocusNode(),
                              hintText: "Enter Description",
                              onsaved: (value) =>
                                  formData['description'] = value,
                              margin: getMargin(top: 6))
                        ])),
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
                const SizedBox(width: 8),
                CustomButton(
                  height: getVerticalSize(50),
                  text: "Submit",
                  margin: getMargin(top: 24, bottom: 5),
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();

                      formData['active'] = isactive;

                      try {
                        print(formData);
                        Map<String, dynamic> createdEntity =
                            await apiService.createEntity(formData);

                        Navigator.pop(context);
                      } catch (e) {
                        // ignore: use_build_context_synchronously
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Error'),
                              content: Text('Failed to create Start_Match: $e'),
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
