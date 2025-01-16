import 'package:cricyard/Entity/start_inning/Start_inning/model/Start_inning_model.dart';
import 'package:cricyard/Entity/start_inning/Start_inning/viewmodels/Start_inning_viewmodel.dart';
import 'package:cricyard/Utils/image_constant.dart';
import 'package:cricyard/Utils/size_utils.dart';
import 'package:cricyard/theme/app_style.dart';
import 'package:cricyard/views/widgets/app_bar/appbar_image.dart';
import 'package:cricyard/views/widgets/app_bar/appbar_title.dart';
import 'package:cricyard/views/widgets/app_bar/custom_app_bar.dart';
import 'package:cricyard/views/widgets/custom_button.dart';
import 'package:cricyard/views/widgets/custom_dropdown_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class StartInningCreateEntityScreen extends StatefulWidget {
  const StartInningCreateEntityScreen({super.key});

  @override
  _StartInningCreateEntityScreenState createState() =>
      _StartInningCreateEntityScreenState();
}

class _StartInningCreateEntityScreenState
    extends State<StartInningCreateEntityScreen> {
  final StartInningModel formData = StartInningModel(
    id: 0,
    selectMatch: '',
    selectTeam: '',
    selectPlayer: '',
    datetimeField: '',
  );
  final _formKey = GlobalKey<FormState>();

  var selectedSelectMatch;
  List<String> selectMatchList = ['bar_code', 'qr_code'];

  var selectedSelectTeam;
  List<String> selectTeamList = ['bar_code', 'qr_code'];

  var selectedSelectPlayer;
  List<String> selectPlayerList = ['bar_code', 'qr_code'];

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
          },
        ),
        centerTitle: true,
        title: AppbarTitle(text: "Create Start Inning"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                CustomDropdownFormField(
                  value: selectedSelectMatch,
                  items: selectMatchList
                      .map<DropdownMenuItem<String>>((item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: AppStyle.txtGilroyMedium16Bluegray900,
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedSelectMatch = value!;
                      formData.selectMatch = value;
                    });
                  },
                  onSaved: (value) {
                    formData.selectMatch = selectedSelectMatch!;
                  },
                ),
                const SizedBox(height: 16),
                CustomDropdownFormField(
                  value: selectedSelectTeam,
                  items: selectTeamList
                      .map<DropdownMenuItem<String>>((item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: AppStyle.txtGilroyMedium16Bluegray900,
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedSelectTeam = value!;
                      formData.selectTeam = value;
                    });
                  },
                  onSaved: (value) {
                    formData.selectTeam = selectedSelectTeam!;
                  },
                ),
                const SizedBox(height: 16),
                CustomDropdownFormField(
                  value: selectedSelectPlayer,
                  items: selectPlayerList
                      .map<DropdownMenuItem<String>>((item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: AppStyle.txtGilroyMedium16Bluegray900,
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedSelectPlayer = value!;
                      formData.selectPlayer = value;
                    });
                  },
                  onSaved: (value) {
                    formData.selectPlayer = selectedSelectPlayer!;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  initialValue: DateFormat('yyyy-MM-dd HH:mm')
                      .format(selectedDateTime),
                  decoration: const InputDecoration(
                    labelText: 'Datetime Field',
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                  readOnly: true,
                  onTap: () => _selectDateTime(context),
                  onSaved: (value) {
                    formData.datetimeField =
                        DateFormat('yyyy-MM-dd HH:mm').format(selectedDateTime);
                  },
                ),
                const SizedBox(height: 16),
                CustomButton(
                  height: getVerticalSize(50),
                  text: "Submit",
                  margin: getMargin(top: 24, bottom: 5),
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      await provider.createEntity(formData, context);
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
