// ignore_for_file: use_build_context_synchronously
import '../../../../Utils/image_constant.dart';
import '../../../../Utils/size_utils.dart';
import '../../../../views/widgets/app_bar/appbar_image.dart';
import '../../../../views/widgets/app_bar/appbar_title.dart';
import '../../../../views/widgets/app_bar/custom_app_bar.dart';
import '../../../../views/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import '../repository/Score_board_api_service.dart';
import '/providers/token_manager.dart';

class score_boardUpdateEntityScreen extends StatefulWidget {
  final Map<String, dynamic> entity;

  score_boardUpdateEntityScreen({required this.entity});

  @override
  _score_boardUpdateEntityScreenState createState() =>
      _score_boardUpdateEntityScreenState();
}

class _score_boardUpdateEntityScreenState
    extends State<score_boardUpdateEntityScreen> {
  final score_boardApiService apiService = score_boardApiService();
  final _formKey = GlobalKey<FormState>();

  List<Map<String, dynamic>> tournamentItems = [];
  var selectedtournamentValue;
  Future<void> fetchtournamentItems() async {
    final token = await TokenManager.getToken();
    try {
      final selectTdata = await apiService.gettournament(token!);
      print('tournament data is : $selectTdata');
      // Handle null or empty dropdownData
      if (selectTdata != null && selectTdata.isNotEmpty) {
        setState(() {
          tournamentItems = selectTdata;
          // Set the initial value of selectedselect_tValue based on the entity's value
          selectedtournamentValue = widget.entity['tournament'] ?? null;
        });
      } else {
        print('tournament data is null or empty');
      }
    } catch (e) {
      print('Failed to load tournament items: $e');
    }
  }

  List<Map<String, dynamic>> batting_teamItems = [];
  var selectedbatting_teamValue;
  Future<void> fetchbatting_teamItems() async {
    final token = await TokenManager.getToken();
    try {
      final selectTdata = await apiService.getbatting_team(token!);
      print('batting_team data is : $selectTdata');
      // Handle null or empty dropdownData
      if (selectTdata != null && selectTdata.isNotEmpty) {
        setState(() {
          batting_teamItems = selectTdata;
          // Set the initial value of selectedselect_tValue based on the entity's value
          selectedbatting_teamValue = widget.entity['batting_team'] ?? null;
        });
      } else {
        print('batting_team data is null or empty');
      }
    } catch (e) {
      print('Failed to load batting_team items: $e');
    }
  }

  List<Map<String, dynamic>> strikerItems = [];
  var selectedstrikerValue;
  Future<void> fetchstrikerItems() async {
    final token = await TokenManager.getToken();
    try {
      final selectTdata = await apiService.getstriker(token!);
      print('striker data is : $selectTdata');
      // Handle null or empty dropdownData
      if (selectTdata != null && selectTdata.isNotEmpty) {
        setState(() {
          strikerItems = selectTdata;
          // Set the initial value of selectedselect_tValue based on the entity's value
          selectedstrikerValue = widget.entity['striker'] ?? null;
        });
      } else {
        print('striker data is null or empty');
      }
    } catch (e) {
      print('Failed to load striker items: $e');
    }
  }

  List<Map<String, dynamic>> ballerItems = [];
  var selectedballerValue;
  Future<void> fetchballerItems() async {
    final token = await TokenManager.getToken();
    try {
      final selectTdata = await apiService.getballer(token!);
      print('baller data is : $selectTdata');
      // Handle null or empty dropdownData
      if (selectTdata != null && selectTdata.isNotEmpty) {
        setState(() {
          ballerItems = selectTdata;
          // Set the initial value of selectedselect_tValue based on the entity's value
          selectedballerValue = widget.entity['baller'] ?? null;
        });
      } else {
        print('baller data is null or empty');
      }
    } catch (e) {
      print('Failed to load baller items: $e');
    }
  }

  bool isvalid_ball_delivery = false;

  bool isno_ball = false;

  var selectedruns_scored_by_running; // Initialize with the default value \n);
  List<String> runs_scored_by_runningList = [
    'bar_code',
    'qr_code',
  ];

  bool isdeclared_2 = false;

  bool isdeclared_4 = false;

  var selectedextra_runs; // Initialize with the default value \n);
  List<String> extra_runsList = [
    'bar_code',
    'qr_code',
  ];

  var selectedmatch_date; // Initialize with the default value \n);
  List<String> match_dateList = [
    'bar_code',
    'qr_code',
  ];

  var selectedmatch_number; // Initialize with the default value \n);
  List<String> match_numberList = [
    'bar_code',
    'qr_code',
  ];

  List<Map<String, dynamic>> chasing_teamItems = [];
  var selectedchasing_teamValue;
  Future<void> fetchchasing_teamItems() async {
    final token = await TokenManager.getToken();
    try {
      final selectTdata = await apiService.getchasing_team(token!);
      print('chasing_team data is : $selectTdata');
      // Handle null or empty dropdownData
      if (selectTdata != null && selectTdata.isNotEmpty) {
        setState(() {
          chasing_teamItems = selectTdata;
          // Set the initial value of selectedselect_tValue based on the entity's value
          selectedchasing_teamValue = widget.entity['chasing_team'] ?? null;
        });
      } else {
        print('chasing_team data is null or empty');
      }
    } catch (e) {
      print('Failed to load chasing_team items: $e');
    }
  }

  List<Map<String, dynamic>> non_strikerItems = [];
  var selectednon_strikerValue;
  Future<void> fetchnon_strikerItems() async {
    final token = await TokenManager.getToken();
    try {
      final selectTdata = await apiService.getnon_striker(token!);
      print('non_striker data is : $selectTdata');
      // Handle null or empty dropdownData
      if (selectTdata != null && selectTdata.isNotEmpty) {
        setState(() {
          non_strikerItems = selectTdata;
          // Set the initial value of selectedselect_tValue based on the entity's value
          selectednon_strikerValue = widget.entity['non_striker'] ?? null;
        });
      } else {
        print('non_striker data is null or empty');
      }
    } catch (e) {
      print('Failed to load non_striker items: $e');
    }
  }

  var selectedovers; // Initialize with the default value \n);
  List<String> oversList = [
    'bar_code',
    'qr_code',
  ];

  var selectedball; // Initialize with the default value \n);
  List<String> ballList = [
    'bar_code',
    'qr_code',
  ];

  bool isfree_hit = false;

  bool iswide_ball = false;

  bool isdead_ball = false;

  bool isdeclared_6 = false;

  bool isleg_by = false;

  bool isover_throw = false;

  @override
  void initState() {
    super.initState();
    fetchtournamentItems(); // Fetch dropdown items when the screen initializes

    fetchbatting_teamItems(); // Fetch dropdown items when the screen initializes

    fetchstrikerItems(); // Fetch dropdown items when the screen initializes

    fetchballerItems(); // Fetch dropdown items when the screen initializes

    isvalid_ball_delivery =
        widget.entity['valid_ball_delivery'] ?? false; // Set initial value

    isno_ball = widget.entity['no_ball'] ?? false; // Set initial value

    selectedruns_scored_by_running = widget
        .entity['runs_scored_by_running']; // Initialize with the default value

    isdeclared_2 = widget.entity['declared_2'] ?? false; // Set initial value

    isdeclared_4 = widget.entity['declared_4'] ?? false; // Set initial value

    selectedextra_runs =
        widget.entity['extra_runs']; // Initialize with the default value

    selectedmatch_date =
        widget.entity['match_date']; // Initialize with the default value

    selectedmatch_number =
        widget.entity['match_number']; // Initialize with the default value

    fetchchasing_teamItems(); // Fetch dropdown items when the screen initializes

    fetchnon_strikerItems(); // Fetch dropdown items when the screen initializes

    selectedovers = widget.entity['overs']; // Initialize with the default value

    selectedball = widget.entity['ball']; // Initialize with the default value

    isfree_hit = widget.entity['free_hit'] ?? false; // Set initial value

    iswide_ball = widget.entity['wide_ball'] ?? false; // Set initial value

    isdead_ball = widget.entity['dead_ball'] ?? false; // Set initial value

    isdeclared_6 = widget.entity['declared_6'] ?? false; // Set initial value

    isleg_by = widget.entity['leg_by'] ?? false; // Set initial value

    isover_throw = widget.entity['over_throw'] ?? false; // Set initial value
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
          title: AppbarTitle(text: "Update Score_board")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: 'Tournament'),
                  value: selectedtournamentValue,
                  items: [
                    const DropdownMenuItem<String>(
                      value: null,
                      child: Text('No Value'),
                    ),
                    ...tournamentItems.map<DropdownMenuItem<String>>(
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
                      selectedtournamentValue = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a Tournament ';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    widget.entity['tournament'] = value;
                  },
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: 'Batting Team'),
                  value: selectedbatting_teamValue,
                  items: [
                    const DropdownMenuItem<String>(
                      value: null,
                      child: Text('No Value'),
                    ),
                    ...batting_teamItems.map<DropdownMenuItem<String>>(
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
                      selectedbatting_teamValue = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a Batting Team ';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    widget.entity['batting_team'] = value;
                  },
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: 'Striker'),
                  value: selectedstrikerValue,
                  items: [
                    const DropdownMenuItem<String>(
                      value: null,
                      child: Text('No Value'),
                    ),
                    ...strikerItems.map<DropdownMenuItem<String>>(
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
                      selectedstrikerValue = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a Striker ';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    widget.entity['striker'] = value;
                  },
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: 'Baller'),
                  value: selectedballerValue,
                  items: [
                    const DropdownMenuItem<String>(
                      value: null,
                      child: Text('No Value'),
                    ),
                    ...ballerItems.map<DropdownMenuItem<String>>(
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
                      selectedballerValue = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a Baller ';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    widget.entity['baller'] = value;
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Switch(
                      value: isvalid_ball_delivery,
                      onChanged: (newValue) {
                        setState(() {
                          isvalid_ball_delivery = newValue;
                        });
                      },
                    ),
                    const SizedBox(width: 8),
                    const Text('Valid Ball delivery'),
                  ],
                ),
                Row(
                  children: [
                    Switch(
                      value: isno_ball,
                      onChanged: (newValue) {
                        setState(() {
                          isno_ball = newValue;
                        });
                      },
                    ),
                    const SizedBox(width: 8),
                    const Text('No Ball'),
                  ],
                ),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                      labelText: 'Selectruns_scored_by_running'),
                  value: widget.entity['runs_scored_by_running'],
                  items: runs_scored_by_runningList
                      .map((name) => DropdownMenuItem<String>(
                            value: name,
                            child: Text(name),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedruns_scored_by_running = value!;
                      widget.entity['runs_scored_by_running'] = value;
                    });
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Switch(
                      value: isdeclared_2,
                      onChanged: (newValue) {
                        setState(() {
                          isdeclared_2 = newValue;
                        });
                      },
                    ),
                    const SizedBox(width: 8),
                    const Text('Declared 2'),
                  ],
                ),
                Row(
                  children: [
                    Switch(
                      value: isdeclared_4,
                      onChanged: (newValue) {
                        setState(() {
                          isdeclared_4 = newValue;
                        });
                      },
                    ),
                    const SizedBox(width: 8),
                    const Text('Declared 4'),
                  ],
                ),
                DropdownButtonFormField<String>(
                  decoration:
                      const InputDecoration(labelText: 'Selectextra_runs'),
                  value: widget.entity['extra_runs'],
                  items: extra_runsList
                      .map((name) => DropdownMenuItem<String>(
                            value: name,
                            child: Text(name),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedextra_runs = value!;
                      widget.entity['extra_runs'] = value;
                    });
                  },
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  decoration:
                      const InputDecoration(labelText: 'Selectmatch_date'),
                  value: widget.entity['match_date'],
                  items: match_dateList
                      .map((name) => DropdownMenuItem<String>(
                            value: name,
                            child: Text(name),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedmatch_date = value!;
                      widget.entity['match_date'] = value;
                    });
                  },
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  decoration:
                      const InputDecoration(labelText: 'Selectmatch_number'),
                  value: widget.entity['match_number'],
                  items: match_numberList
                      .map((name) => DropdownMenuItem<String>(
                            value: name,
                            child: Text(name),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedmatch_number = value!;
                      widget.entity['match_number'] = value;
                    });
                  },
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: 'Chasing Team'),
                  value: selectedchasing_teamValue,
                  items: [
                    const DropdownMenuItem<String>(
                      value: null,
                      child: Text('No Value'),
                    ),
                    ...chasing_teamItems.map<DropdownMenuItem<String>>(
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
                      selectedchasing_teamValue = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a Chasing Team ';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    widget.entity['chasing_team'] = value;
                  },
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: 'Non Striker'),
                  value: selectednon_strikerValue,
                  items: [
                    const DropdownMenuItem<String>(
                      value: null,
                      child: Text('No Value'),
                    ),
                    ...non_strikerItems.map<DropdownMenuItem<String>>(
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
                      selectednon_strikerValue = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a Non Striker ';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    widget.entity['non_striker'] = value;
                  },
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: 'Selectovers'),
                  value: widget.entity['overs'],
                  items: oversList
                      .map((name) => DropdownMenuItem<String>(
                            value: name,
                            child: Text(name),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedovers = value!;
                      widget.entity['overs'] = value;
                    });
                  },
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: 'Selectball'),
                  value: widget.entity['ball'],
                  items: ballList
                      .map((name) => DropdownMenuItem<String>(
                            value: name,
                            child: Text(name),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedball = value!;
                      widget.entity['ball'] = value;
                    });
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Switch(
                      value: isfree_hit,
                      onChanged: (newValue) {
                        setState(() {
                          isfree_hit = newValue;
                        });
                      },
                    ),
                    const SizedBox(width: 8),
                    const Text('Free Hit'),
                  ],
                ),
                Row(
                  children: [
                    Switch(
                      value: iswide_ball,
                      onChanged: (newValue) {
                        setState(() {
                          iswide_ball = newValue;
                        });
                      },
                    ),
                    const SizedBox(width: 8),
                    const Text('Wide Ball'),
                  ],
                ),
                Row(
                  children: [
                    Switch(
                      value: isdead_ball,
                      onChanged: (newValue) {
                        setState(() {
                          isdead_ball = newValue;
                        });
                      },
                    ),
                    const SizedBox(width: 8),
                    const Text('Dead Ball'),
                  ],
                ),
                Row(
                  children: [
                    Switch(
                      value: isdeclared_6,
                      onChanged: (newValue) {
                        setState(() {
                          isdeclared_6 = newValue;
                        });
                      },
                    ),
                    const SizedBox(width: 8),
                    const Text('Declared 6'),
                  ],
                ),
                Row(
                  children: [
                    Switch(
                      value: isleg_by,
                      onChanged: (newValue) {
                        setState(() {
                          isleg_by = newValue;
                        });
                      },
                    ),
                    const SizedBox(width: 8),
                    const Text('Leg By'),
                  ],
                ),
                Row(
                  children: [
                    Switch(
                      value: isover_throw,
                      onChanged: (newValue) {
                        setState(() {
                          isover_throw = newValue;
                        });
                      },
                    ),
                    const SizedBox(width: 8),
                    const Text('Over throw'),
                  ],
                ),
                CustomButton(
                  height: getVerticalSize(50),
                  text: "Update",
                  margin: getMargin(top: 24, bottom: 5),
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();

                      widget.entity['valid_ball_delivery'] =
                          isvalid_ball_delivery;

                      widget.entity['no_ball'] = isno_ball;

                      widget.entity['declared_2'] = isdeclared_2;

                      widget.entity['declared_4'] = isdeclared_4;

                      widget.entity['free_hit'] = isfree_hit;

                      widget.entity['wide_ball'] = iswide_ball;

                      widget.entity['dead_ball'] = isdead_ball;

                      widget.entity['declared_6'] = isdeclared_6;

                      widget.entity['leg_by'] = isleg_by;

                      widget.entity['over_throw'] = isover_throw;

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
                              content: Text('Failed to update Score_board: $e'),
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
