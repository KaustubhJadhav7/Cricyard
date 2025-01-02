import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:cricyard/core/utils/size_utils.dart';
import 'package:cricyard/providers/token_manager.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../../Utils/size_utils.dart';
import '../../../../core/utils/image_constant.dart';
import '../../../../theme/theme_helper.dart';
import '../../../../views/widgets/custom_image_view.dart';
import '../repository/My_Tournament_api_service.dart';

class TournamentForm extends StatefulWidget {
  @override
  _TournamentFormState createState() => _TournamentFormState();
}

class _TournamentFormState extends State<TournamentForm> {
  final _formKey = GlobalKey<FormState>();
  final _tournamentNameController = TextEditingController();
  final _cityController = TextEditingController(text: 'Patna');
  final _groundController = TextEditingController();
  final _organiserNameController = TextEditingController();
  final _organiserNumberController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  DateTime? _startDate;
  DateTime? _endDate;
  String _ballType = '';
  bool _needMoreTeams = false;
  bool _needOfficials = false;
  File? _selectedImageUrl;
  File? _selectedImageUrl2;

  bool _isSubmitting = false;
  final MyTournamentApiService apiService = MyTournamentApiService();
  final Map<String, dynamic> formData = {};

  String _tournamentType = 'OPEN';
  final List<String> categories = ['OPEN', 'CORPORATE', 'COMMUNITY', 'SCHOOL'];

  String _pitchType = 'ROUGH';
  final List<String> pitchCategories = [
    'ROUGH',
    'CEMENT',
    'TURF',
    'ASTROTURF',
    'MATTING'
  ];

  String _selectedBallType = 'Leather'; // Default selected ball type
  final List<String> ballTypes = ['Leather', 'Tennis', 'Plastic', 'Other'];

  String _matchType = 'LIMITED OVERS';
  final List<String> matchCategories = [
    'LIMITED OVERS',
    'BOX/TURF CRICKET',
    'TEST MATCH',
    'PAIR CRICKET',
    'THE HUNDRED'
  ];

  Future<String?> _logopickImage(ImageSource source) async {
    final imagePicker = ImagePicker();

    try {
      final pickedImage = await imagePicker.pickImage(source: source);

      if (pickedImage != null) {
        return pickedImage.path;
      }
    } catch (e) {
      print(e);
    }

    return null;
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImageUrl2 = File(pickedFile.path);
      });
    }
  }

  Future<void> _selectDate(BuildContext context, String dateType) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      setState(() {
        if (dateType == 'start_date') {
          _startDate = picked;
          _startDateController.text = DateFormat.yMd().format(picked);
          formData['start_date'] = picked;
        } else if (dateType == 'end_date') {
          _endDate = picked;
          _endDateController.text = DateFormat.yMd().format(picked);
          formData['end_date'] = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomImageView(
                svgPath: ImageConstant.imgArrowleft,
                color: Colors.white,
              ),
            ),
          ),
          title: Text(
            "Create Tournament",
            style: theme.textTheme.headlineLarge?.copyWith(color: Colors.white),
          ),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () async {
                      String? imageUrl =
                          await _logopickImage(ImageSource.gallery);
                      if (imageUrl != null) {
                        setState(() {
                          _selectedImageUrl = File(imageUrl);
                        });
                      }
                    },
                    child: SizedBox(
                      height: 150,
                      child: Center(
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            if (_selectedImageUrl != null)
                              Image.file(
                                _selectedImageUrl!,
                                height: 150,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              )
                            else
                              const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.photo,
                                      size: 70, color: Colors.grey),
                                  SizedBox(height: 8),
                                  Text(
                                    'Add Banner',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ],
                              ),
                            Positioned(
                              bottom: 56,
                              right: 3,
                              child: Container(
                                height: 24,
                                width: 24,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.blue,
                                ),
                                child: const Center(
                                  child: Icon(Icons.camera_alt,
                                      size: 16, color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Stack(
                        children: [
                          GestureDetector(
                            onTap: _pickImage,
                            child: Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.grey),
                              ),
                              child: _selectedImageUrl2 != null
                                  ? ClipOval(
                                      child: Image.file(
                                        _selectedImageUrl2!,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : const Center(
                                      child: Icon(
                                        Icons.add_photo_alternate,
                                        size: 30,
                                        color: Colors.grey,
                                      ),
                                    ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              height: 24,
                              width: 24,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.blue,
                              ),
                              child: const Center(
                                child: Icon(Icons.camera_alt,
                                    size: 16, color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 8),
                      const Expanded(child: Divider(color: Colors.grey)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: const Text(
                      'Add Logo',
                      style: TextStyle(fontSize: 12, color: Colors.black),
                    ),
                  ),
                  const SizedBox(height: 30),
                  _buildTextFormField(
                      _tournamentNameController,
                      'Tournament / Series Name',
                      'Enter tournament/series name',
                      'Please enter tournament/series name',
                      (value) => formData['tournament_name'] = value!),
                  const SizedBox(height: 16),
                  _buildTextFormField(
                      _cityController,
                      'Venues',
                      'Venues',
                      'Please enter Venues',
                      (value) => formData['venues'] = value!),
                  const SizedBox(height: 16),
                  _buildTextFormField(
                      _groundController,
                      'Sponsors',
                      'Enter Sponsors',
                      'Please enter Sponsors',
                      (value) => formData['sponsors'] = value!),
                  const SizedBox(height: 16),
                  _buildTextFormField(
                      _organiserNameController,
                      'Description',
                      null,
                      'Please enter Description',
                      (value) => formData['description'] = value!),
                  const SizedBox(height: 16),
                  _buildTextFormField(
                      _organiserNumberController,
                      'Rules',
                      'Enter Rules',
                      'Please enter Rules',
                      (value) => formData['rules'] = value!),
                  const SizedBox(height: 16),
                  const Text('Tournament Dates',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.black)),
                  const SizedBox(height: 25),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => _selectDate(context, 'start_date'),
                          child: _buildDateTextField(
                              _startDateController, _startDate, 'Start Date'),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => _selectDate(context, 'end_date'),
                          child: _buildDateTextField(
                              _endDateController, _endDate, 'End Date'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  const Text('Tournament Type',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.black)),
                  const SizedBox(height: 20),
                  Wrap(
                    spacing: 12.0,
                    children: categories.map((category) {
                      return _buildChoiceChip(category, _tournamentType,
                          (selected) {
                        setState(() {
                          if (selected) {
                            _tournamentType = category;
                          }
                          formData['tournament_type'] = _tournamentType;
                        });
                      });
                    }).toList(),
                  ),
                  const SizedBox(height: 25),
                  const Text('Ball Type',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.black)),
                  const SizedBox(height: 20),
                  Wrap(
                    spacing: 12.0,
                    runSpacing: 12.0,
                    children: ballTypes.map((ballType) {
                      return ChoiceChip(
                        selectedColor: Colors.green,
                        backgroundColor: Colors.grey[100],
                        label: Text(ballType),
                        selected: _selectedBallType == ballType,
                        onSelected: (selected) {
                          setState(() {
                            if (selected) {
                              _selectedBallType = ballType;
                              // Update formData or perform any other action
                              formData['ball_type'] = _selectedBallType;
                            }
                          });
                        },
                      );
                    }).toList(),
                  ),

                  // Row(
                  //   children: [
                  //     Expanded(child: _buildBallTypeRadio('Tennis', _ballType)),
                  //     const SizedBox(width: 8),
                  //     Expanded(child: _buildBallTypeRadio('Leather', _ballType)),
                  //   ],
                  // ),
                  const SizedBox(height: 25),
                  const Text('Pitch Type',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.black)),
                  const SizedBox(height: 20),
                  Wrap(
                    spacing: 10.0,
                    children: pitchCategories.map((category) {
                      return _buildChoiceChip(category, _pitchType, (selected) {
                        setState(() {
                          if (selected) {
                            _pitchType = category;
                          }
                          formData['pitch_type'] = _pitchType;
                        });
                      });
                    }).toList(),
                  ),
                  const SizedBox(height: 25),
                  const Text('Match Type',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.black)),
                  const SizedBox(height: 20),
                  Wrap(
                    spacing: 10.0,
                    children: matchCategories.map((category) {
                      return _buildChoiceChip(category, _matchType, (selected) {
                        setState(() {
                          if (selected) {
                            _matchType = category;
                          }
                          formData['match_type'] = _matchType;
                        });
                      });
                    }).toList(),
                  ),
                  const SizedBox(height: 25),
                  const Text('Need more teams?',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.black)),
                  const SizedBox(height: 10),
                  _buildSwitchListTile('Need more teams?', _needMoreTeams,
                      (value) {
                    setState(() {
                      _needMoreTeams = value;
                      formData['need_more_teams'] = _needMoreTeams;
                    });
                  }),
                  const SizedBox(height: 25),
                  const Text('Need officials?',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.black)),
                  const SizedBox(height: 10),
                  _buildSwitchListTile('Need officials?', _needOfficials,
                      (value) {
                    setState(() {
                      _needOfficials = value;
                      formData['need_officials'] = _needOfficials;
                    });
                  }),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child:_isSubmitting ? const Center(child: CircularProgressIndicator()): ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            _isSubmitting = true;
                          });
                          final token = await TokenManager.getToken();
                          print("Form-Data--$formData");
                        final createdEntity =   await apiService.createEntity(
                            token!,
                            formData,
                          );
                          await apiService.uploadlogoimage(token, createdEntity['id'].toString(), 'My_Tournament', _selectedImageUrl!.path.toString(),_selectedImageUrl as Uint8List,);
                          await apiService.uploadlogoimage(token, createdEntity['id'].toString(), 'My_Tournament', _selectedImageUrl2!.path.toString(),_selectedImageUrl2 as Uint8List,);
                          Navigator.pop(context, true);
                          setState(() {
                            _isSubmitting = false;
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Submit',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  TextFormField _buildTextFormField(
      TextEditingController controller,
      String label,
      String? hint,
      String errorText,
      void Function(String?) onSaved) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
      validator: (value) => value!.isEmpty ? errorText : null,
      onSaved: onSaved,
    );
  }

  TextFormField _buildDateTextField(
      TextEditingController controller, DateTime? date, String labelText) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        prefixIcon: const Icon(Icons.calendar_today),
      ),
      enabled: false,
    );
  }

  ChoiceChip _buildChoiceChip(
      String label, String selectedValue, void Function(bool) onSelected) {
    return ChoiceChip(
      label: Text(label),
      selected: selectedValue == label,
      onSelected: onSelected,
      selectedColor: Colors.green,
      backgroundColor: Colors.grey[100],
    );
  }

  RadioListTile<String> _buildBallTypeRadio(String value, String groupValue) {
    return RadioListTile<String>(
      title: Text(value),
      value: value,
      groupValue: groupValue,
      onChanged: (newValue) {
        setState(() {
          _ballType = newValue!;
          formData['ball_type'] = _ballType;
        });
      },
    );
  }

  SwitchListTile _buildSwitchListTile(
      String title, bool value, void Function(bool) onChanged) {
    return SwitchListTile(
      title: Text(title),
      value: value,
      onChanged: onChanged,
    );
  }
}
