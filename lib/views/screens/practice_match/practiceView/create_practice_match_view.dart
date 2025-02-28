// ignore_for_file: use_build_context_synchronously

import 'package:cricyard/views/screens/MenuScreen/Basketball/views/BasketballScorecard/basketballMatchScore.dart';
import 'package:cricyard/views/screens/MenuScreen/Football/views/FootballScorecard/footballMatchScore.dart';
import 'package:cricyard/views/screens/MenuScreen/Hockey/HockeyScorecard/hockeyMatchScore.dart';
import 'package:cricyard/views/screens/MenuScreen/Tennis/views/TennisScorecard/tennisMatchScoreDoubles.dart';
import 'package:cricyard/views/screens/MenuScreen/Tennis/views/TennisScorecard/tennisMatchScoreSingles.dart';
import 'package:cricyard/views/screens/practice_match/practiceRepository/PracticeMatchService.dart';
import 'package:cricyard/views/screens/practice_match/practiceViewmodel/PracticeMatchViewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'PracticeMatchScoreScreen.dart';

class CreatePracticeMatchView extends StatefulWidget {
  const CreatePracticeMatchView({super.key});

  @override
  State<CreatePracticeMatchView> createState() =>
      _CreatePracticeMatchViewState();
}

class _CreatePracticeMatchViewState extends State<CreatePracticeMatchView> {
  TextEditingController _hostTeamController = TextEditingController();
  TextEditingController _visitorTeamController = TextEditingController();
  TextEditingController _oversController = TextEditingController();
  TextEditingController _strikerController = TextEditingController();
  TextEditingController _nonStrikerController = TextEditingController();
  TextEditingController _bowlerController = TextEditingController();

  FocusNode _strikerFocusNode = FocusNode();
  FocusNode _nonStrikerFocusNode = FocusNode();
  FocusNode _bowlerFocusNode = FocusNode();
  FocusNode _hostFocusNode = FocusNode();
  FocusNode _visitorFocusNode = FocusNode();
  FocusNode _oversFocusNode = FocusNode();

  String selectedOption = 'Host';
  String selectedOptedOption = 'Bat';
  List<String> createdTeams = [];

  List<String> dummyPlayers = ['Team1', 'Team2', 'Team3'];

  bool _isLoading = false;
  TextEditingController _awayTeamController = TextEditingController();

  FocusNode _awayFocusNode = FocusNode();

  Future<void> _loadTeams() async {
    final model = Provider.of<PracticeMatchviewModel>(context, listen: false);
    await model.getAllTeam();
    setState(() {
      createdTeams = model.createdTeams;
    });
  }

  String? preferredSport;
  bool isLoading = true;

  Future<void> _loadPreferredSport() async {
    preferredSport = await getPreferredSport();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadTeams();
    _loadPreferredSport();
    Provider.of<PracticeMatchviewModel>(context, listen: false).getAllTeam();
    _hostTeamController.addListener(_updateHostRadio);
    _visitorTeamController.addListener(_updateVisitorRadio);
  }

  @override
  void dispose() {
    _hostTeamController.dispose();
    _visitorTeamController.dispose();
    _hostFocusNode.dispose();
    _visitorFocusNode.dispose();
    _oversFocusNode.dispose();
    super.dispose();
  }

  void _updateHostRadio() {
    setState(() {
      selectedOption = _hostTeamController
          .text; // Whenever host team text changes, select the host radio
    });
  }

  void _updateVisitorRadio() {
    setState(() {
      selectedOption = _visitorTeamController
          .text; // Whenever visitor team text changes, select the visitor radio
    });
  }

  TextEditingController _player1Controller = TextEditingController();
  TextEditingController _player2Controller = TextEditingController();

  TextEditingController _team1Player1Controller = TextEditingController();
  TextEditingController _team1Player2Controller = TextEditingController();
  TextEditingController _team2Player1Controller = TextEditingController();
  TextEditingController _team2Player2Controller = TextEditingController();

  FocusNode _player1FocusNode = FocusNode();
  FocusNode _player2FocusNode = FocusNode();

  FocusNode _team1P1FocusNode = FocusNode();
  FocusNode _team1P2FocusNode = FocusNode();
  FocusNode _team2P1FocusNode = FocusNode();
  FocusNode _team2P2FocusNode = FocusNode();

  void showSnackBar(BuildContext context, String msg, Color color) {
    final mediaQuery = MediaQuery.of(context);
    final topPadding = mediaQuery.viewPadding.bottom;
    const snackBarHeight = 50.0; // Approximate height of SnackBar

    final topMargin = topPadding + snackBarHeight + 700; // Add some padding

    SnackBar snackBar = SnackBar(
      margin: EdgeInsets.only(bottom: topMargin, left: 16.0, right: 16.0),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors
          .transparent, // Make background transparent to show custom design
      elevation: 0, // Remove default elevation to apply custom shadow
      content: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [color.withOpacity(0.8), color],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  offset: Offset(0, 4),
                  blurRadius: 10.0,
                ),
              ],
            ),
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                const Icon(
                  Icons.info_rounded,
                  color: Colors.white,
                  size: 28.0, // Slightly larger icon
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    msg,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 16.0, // Slightly larger text
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  },
                ),
              ],
            ),
          ),
          Positioned(
            left: -15,
            top: -15,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: color.withOpacity(0.5),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            right: -10,
            bottom: -10,
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: color.withOpacity(0.5),
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _submitFormFootball(PracticeMatchviewModel model) async {
    if (_hostTeamController.text.isEmpty || _awayTeamController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Error!! All fields are required.',
            style: TextStyle(color: Colors.white, fontSize: 14), // Text color
          ),
          backgroundColor: Colors.red, // Background color
          duration: Duration(seconds: 3), // Optional: Adjust the duration
        ),
      );
      return;
    }
    setState(() {
      _isLoading = true;
    });
    // Fetch preferred sport from SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String preferredSport =
        prefs.getString('preferred_sport') ?? 'Cricket'; // Default to 'Cricket'
    String hostTeam = _hostTeamController.text;
    String awayTeam = _awayTeamController.text;
    String tossWinner = selectedOption;
    String optedTo = selectedOptedOption;
    Map<String, String> formData = {
      'hostTeam': hostTeam,
      'visitorTeam': awayTeam,
      'tossWinner': tossWinner,
      'opted_to': optedTo,
      'preferred_sport': preferredSport,
    };
    print(formData);
    try {
      Map<String, dynamic> match =
          await model.createPracticeMatchFootball(formData);
      print(" Football Practice match created successfully: $match");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FootballScoreboardScreen(entity: match),
        ),
      );
    } catch (e) {
      // Show an error message if the API call fails
      print("Error occurred: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Failed to create practice match. Please try again.',
            style: TextStyle(color: Colors.white), // Text color
          ),
          backgroundColor: Colors.red, // Background color
          duration: Duration(seconds: 3), // Optional: Adjust the duration
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
    // You can now send `formData` to the backend
  }

  void _submitFormHockey(PracticeMatchviewModel model) async {
    if (_hostTeamController.text.isEmpty || _awayTeamController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Error!! All fields are required.',
            style: TextStyle(color: Colors.white, fontSize: 14), // Text color
          ),
          backgroundColor: Colors.red, // Background color
          duration: Duration(seconds: 3), // Optional: Adjust the duration
        ),
      );
      return;
    }
    setState(() {
      _isLoading = true;
    });
    // Fetch preferred sport from SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String preferredSport =
        prefs.getString('preferred_sport') ?? 'Cricket'; // Default to 'Cricket'
    String hostTeam = _hostTeamController.text;
    String awayTeam = _awayTeamController.text;
    String tossWinner = selectedOption;
    String optedTo = selectedOptedOption;
    Map<String, String> formData = {
      'hostTeam': hostTeam,
      'visitorTeam': awayTeam,
      'tossWinner': tossWinner,
      'opted_to': optedTo,
      'preferred_sport': preferredSport,
    };
    print(formData);
    try {
      Map<String, dynamic> match =
          await model.createPracticeMatchHockey(formData);
      print(" Hockey Practice match created successfully: $match");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HockeyScoreboardScreen(entity: match),
        ),
      );
    } catch (e) {
      // Show an error message if the API call fails
      print("Error occurred: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Failed to create practice match. Please try again.',
            style: TextStyle(color: Colors.white), // Text color
          ),
          backgroundColor: Colors.red, // Background color
          duration: Duration(seconds: 3), // Optional: Adjust the duration
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
    // You can now send `formData` to the backend
  }

  void _submitFormTennis(PracticeMatchviewModel model) async {
    if (selectedMatchType == 'Singles' &&
        (_player1Controller.text.isEmpty || _player2Controller.text.isEmpty)) {
      showSnackBar(context, 'Error!! All fields are required.', Colors.red);
      return;
    } else if (selectedMatchType == 'Doubles' &&
        (_team1Player1Controller.text.isEmpty ||
            _team1Player2Controller.text.isEmpty ||
            _team2Player1Controller.text.isEmpty ||
            _team2Player2Controller.text.isEmpty)) {
      showSnackBar(context, 'Error!! All fields are required.', Colors.red);
      return;
    }

    setState(() => _isLoading = true);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String preferredSport = prefs.getString('preferred_sport') ?? 'Tennis';
    String hostTeam = _hostTeamController.text;
    String awayTeam = _awayTeamController.text;

    // ✅ Separate form data for Singles
  Map<String, String> formDataSingles = {
    'hostTeam': _player1Controller.text,
    'visitorTeam': _player2Controller.text,
    'opted_to': "Bat",
    'tossWinner': "tossWinner",
    'preferred_sport': preferredSport,
    //! uncomment later for backend ---
    // 'matchType': 'Singles',  
    // 'player1': _player1Controller.text,
    // 'player2': _player2Controller.text,
    //! ---

  };

  // ✅ Separate form data for Doubles
  Map<String, String> formDataDoubles = {
    'hostTeam': hostTeam,
    'visitorTeam': awayTeam,
    'opted_to': "Bat",
    'tossWinner': "tossWinner",
    'preferred_sport': preferredSport,
    // 'matchType': 'Doubles',  //! Uncomment this while sending to backend
    // 'team1_player1': _team1Player1Controller.text,
    // 'team1_player2': _team1Player2Controller.text,
    // 'team2_player1': _team2Player1Controller.text,
    // 'team2_player2': _team2Player2Controller.text,
    'tossWinner': _team1Player1Controller.text,
    'striker_player_name': _team1Player2Controller.text,

    'non_striker_player_name': _team2Player1Controller.text,
    'baller_player_name': _team2Player2Controller.text,
  };

    try {
      // ✅ Determine which formData to send
    Map<String, dynamic> match = (selectedMatchType == 'Singles')
        ? await model.createPracticeMatchTennis(formDataSingles)
        : await model.createPracticeMatchTennis(formDataDoubles);

    print("Tennis Practice match created successfully: $match");

      // Navigate to the correct scoreboard based on match type
      if (selectedMatchType == 'Singles') {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TennisScoreboardScreen(
              entity: match
              // player1: _player1Controller.text,
              // player2: _player2Controller.text,
            ),
          ),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TennisDoublesScoreboardScreen(
              entity: match,
              team1: [
                _team1Player1Controller.text,
                _team1Player2Controller.text
              ],
              team2: [
                _team2Player1Controller.text,
                _team2Player2Controller.text
              ],
            ),
          ),
        );
      }
    } catch (e) {
      print("Error occurred: $e");
      showSnackBar(context,
          'Failed to create practice match. Please try again.', Colors.red);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _submitFormBasketball(PracticeMatchviewModel model) async {
    if (_hostTeamController.text.isEmpty || _awayTeamController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Error!! All fields are required.',
            style: TextStyle(color: Colors.white, fontSize: 14), // Text color
          ),
          backgroundColor: Colors.red, // Background color
          duration: Duration(seconds: 3), // Optional: Adjust the duration
        ),
      );

      return;
    }

    setState(() {
      _isLoading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String preferredSport =
        prefs.getString('preferred_sport') ?? 'Cricket'; // Default to 'Cricket'

    String hostTeam = _hostTeamController.text;
    String awayTeam = _awayTeamController.text;
    // String tossWinner = selectedOption;
    // String optedTo = selectedOptedOption;

    Map<String, String> formData = {
      'hostTeam': hostTeam ?? "Barcelona",
      'visitorTeam': awayTeam ?? "Real Madrid",
      'tossWinner': selectedOption,
      'opted_to': "Bat",
      'preferred_sport': preferredSport,
    };
    print(formData);

    try {
      Map<String, dynamic> match =
          await model.createPracticeMatchBasketball(formData);
      print(" Basketball Practice match created successfully: $match");

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BasketballScoreboardScreen(entity: match),
        ),
      );
    } catch (e) {
      // Show an error message if the API call fails
      print("Error occurred: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Failed to create basketball practice match. Please try again.',
            style: TextStyle(color: Colors.white), // Text color
          ),
          backgroundColor: Colors.red, // Background color
          duration: Duration(seconds: 3), // Optional: Adjust the duration
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }

    // You can now send `formData` to the backend
  }

  void _submitFormCricket(PracticeMatchviewModel model) async {
    if (_hostTeamController.text.isEmpty ||
        _visitorTeamController.text.isEmpty ||
        _strikerController.text.isEmpty ||
        _nonStrikerController.text.isEmpty ||
        _bowlerController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Error!! All fields are required.',
            style: TextStyle(color: Colors.white), // Text color
          ),
          backgroundColor: Colors.red, // Background color
          duration: Duration(seconds: 3), // Optional: Adjust the duration
        ),
      );
      return;
    }
    if (int.tryParse(_oversController.text) == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Error!! Overs must be a valid integer.',
            style: TextStyle(color: Colors.white), // Text color
          ),
          backgroundColor: Colors.red, // Background color
          duration: Duration(seconds: 3), // Optional: Adjust the duration
        ),
      );
    }
    setState(() {
      _isLoading = true;
    });
    // Fetch preferred sport from SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String preferredSport =
        prefs.getString('preferred_sport') ?? 'Cricket'; // Default to 'Cricket'
    String hostTeam = _hostTeamController.text;
    String visitorTeam = _visitorTeamController.text;
    String overs = _oversController.text;
    String tossWinner = selectedOption;
    String optedTo = selectedOptedOption;
    String striker = _strikerController.text;
    String nonStriker = _nonStrikerController.text;
    String bowler = _bowlerController.text;
    Map<String, dynamic> formData = {
      'hostTeam': hostTeam,
      'visitorTeam': visitorTeam,
      'match_overs': overs,
      'tossWinner': tossWinner,
      'opted_to': optedTo,
      'striker_player_name': striker,
      'non_striker_player_name': nonStriker,
      'baller_player_name': bowler,
      'preferred_sport': preferredSport, // Added preferred sport field
    };
    print(formData);
    try {
      print("Host Team: ${_hostTeamController.text}");
      print("Visitor Team: ${_visitorTeamController.text}");
      print("Striker: ${_strikerController.text}");
      print("Non-Striker: ${_nonStrikerController.text}");
      print("Bowler: ${_bowlerController.text}");
      Map<String, dynamic> match = await model.createPracticeMatch(formData);
      print("Practice match created successfully: $match");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PracticeMatchScoreScreen(entity: match),
        ),
      );
    } catch (e) {
      // Show an error message if the API call fails
      print("Error occurred: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Failed to create practice match. Please try again.',
            style: TextStyle(color: Colors.white), // Text color
          ),
          backgroundColor: Colors.red, // Background color
          duration: Duration(seconds: 3), // Optional: Adjust the duration
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // void getAllTeams() async {
  //   final data = await practiceService.getAllTeam();
  //   print(data);
  //   setState(() {
  //     createdTeams =
  //         data.map<String>((team) => team['team_name'] as String).toList();
  //   });
  //   print("created Team-$createdTeams");
  // }

  Future<String?> getPreferredSport() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('preferred_sport');
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    // Define a mapping of sports to their respective UI builder functions
    final Map<String, Widget Function(BuildContext)> sportsUIBuilders = {
      'Football': buildFootballUI,
      'Cricket': buildCricketUI,
      'Basketball': buildBasketballUI, // Example new sport
      'Tennis': buildTennisUI, // Another example
      'Hockey': buildHockeyUI, // Another example
      // Add more sports here in the future
    };
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              // child: IntrinsicHeight(
              //   child: preferredSport == 'Football'
              //       ? buildFootballUI(context) // Show football UI
              //       : buildCricketUI(context), // Show cricket UI (default)
              // ),
              child: IntrinsicHeight(
                child: sportsUIBuilders[preferredSport]?.call(context) ??
                    buildCricketUI(context), // Default to Cricket UI
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildFootballUI(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Teams",
                style: GoogleFonts.getFont('Poppins',
                    color: Colors.blue, fontSize: 16),
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0, 1),
                      blurRadius: 0.5,
                    )
                  ],
                ),
                child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Consumer<PracticeMatchviewModel>(
                        builder: (context, value, child) {
                      return Column(
                        children: [
                          // _buildTextField(
                          //     _hostTeamController, 'Host Team', _hostFocusNode),
                          _buildAutocompleteTextField(_hostTeamController,
                              'Home Team', _hostFocusNode, value.createdTeams),
                          _buildAutocompleteTextField(_awayTeamController,
                              'Away Team', _awayFocusNode, value.createdTeams),
                        ],
                      );
                    })),
              ),
              const SizedBox(height: 16),
              Text(
                "Toss Won by?",
                style: GoogleFonts.getFont('Poppins',
                    color: Colors.blue, fontSize: 16),
              ),
              const SizedBox(height: 8),
              Container(
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0, 1),
                      blurRadius: 0.5,
                    )
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _buildRadio(
                        _hostTeamController.text.isEmpty
                            ? 'Host'
                            : _hostTeamController.text,
                        _hostTeamController),
                    _buildRadio(
                        _awayTeamController.text.isEmpty
                            ? 'Visitor'
                            : _awayTeamController.text,
                        _awayTeamController),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Text(
                "Opted For ?",
                style: GoogleFonts.getFont('Poppins',
                    color: Colors.blue, fontSize: 16),
              ),
              const SizedBox(height: 8),
              Container(
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0, 1),
                      blurRadius: 0.5,
                    )
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _buildOptedRadio('Start - Kickoff'),
                    _buildOptedRadio('Sides'),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Consumer<PracticeMatchviewModel>(
                builder: (context, value, child) {
                  return SizedBox(
                    height: 50,
                    width: 110,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.all<Color>(Colors.blue),
                      ),
                      onPressed: () {
                        _submitFormFootball(value);
                      },
                      child: _isLoading
                          ? CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : Text(
                              "Kick Off",
                              style: GoogleFonts.getFont('Poppins',
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget buildHockeyUI(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Teams",
                style: GoogleFonts.getFont('Poppins',
                    color: Colors.blue, fontSize: 16),
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0, 1),
                      blurRadius: 0.5,
                    )
                  ],
                ),
                child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Consumer<PracticeMatchviewModel>(
                        builder: (context, value, child) {
                      return Column(
                        children: [
                          // _buildTextField(
                          //     _hostTeamController, 'Host Team', _hostFocusNode),
                          _buildAutocompleteTextField(_hostTeamController,
                              'Home Team', _hostFocusNode, value.createdTeams),
                          _buildAutocompleteTextField(_awayTeamController,
                              'Away Team', _awayFocusNode, value.createdTeams),
                        ],
                      );
                    })),
              ),
              const SizedBox(height: 16),
              Text(
                "Toss Won by?",
                style: GoogleFonts.getFont('Poppins',
                    color: Colors.blue, fontSize: 16),
              ),
              const SizedBox(height: 8),
              Container(
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0, 1),
                      blurRadius: 0.5,
                    )
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _buildRadio(
                        _hostTeamController.text.isEmpty
                            ? 'Host'
                            : _hostTeamController.text,
                        _hostTeamController),
                    _buildRadio(
                        _awayTeamController.text.isEmpty
                            ? 'Visitor'
                            : _awayTeamController.text,
                        _awayTeamController),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Text(
                "Opted For ?",
                style: GoogleFonts.getFont('Poppins',
                    color: Colors.blue, fontSize: 16),
              ),
              const SizedBox(height: 8),
              Container(
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0, 1),
                      blurRadius: 0.5,
                    )
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _buildOptedRadio('Attack-Start'),
                    _buildOptedRadio('Defence'),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Consumer<PracticeMatchviewModel>(
                builder: (context, value, child) {
                  return SizedBox(
                    height: 50,
                    width: 110,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.all<Color>(Colors.blue),
                      ),
                      onPressed: () {
                        _submitFormHockey(value);
                      },
                      child: _isLoading
                          ? CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : Text(
                              "Start Match!",
                              style: GoogleFonts.getFont('Poppins',
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTennisUI(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Match Type",
                style: GoogleFonts.getFont('Poppins',
                    color: Colors.blue, fontSize: 16),
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0, 1),
                        blurRadius: 0.5),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    children: [
                      _buildMatchTypeRadio('Singles'),
                      _buildMatchTypeRadio('Doubles'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const SizedBox(height: 8),
              Consumer<PracticeMatchviewModel>(
                builder: (context, value, child) {
                  return Column(
                    children: selectedMatchType == 'Singles'
                        ? [
                            Text(
                              "Players",
                              style: GoogleFonts.getFont('Poppins',
                                  color: Colors.blue, fontSize: 16),
                            ),
                            _buildAutocompleteTextField(
                                _player1Controller,
                                'Player 1',
                                _player1FocusNode,
                                value.createdTeams),
                            _buildAutocompleteTextField(
                                _player2Controller,
                                'Player 2',
                                _player2FocusNode,
                                value.createdTeams),
                          ]
                        : [
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Teams",
                              style: GoogleFonts.getFont('Poppins',
                                  color: Colors.blue, fontSize: 16),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.grey,
                                    offset: Offset(0, 1),
                                    blurRadius: 0.5,
                                  )
                                ],
                              ),
                              child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Consumer<PracticeMatchviewModel>(
                                      builder: (context, value, child) {
                                    return Column(
                                      children: [
                                        // _buildTextField(
                                        //     _hostTeamController, 'Host Team', _hostFocusNode),
                                        _buildAutocompleteTextField(
                                            _hostTeamController,
                                            'Team 1 Name',
                                            _hostFocusNode,
                                            value.createdTeams),
                                        _buildAutocompleteTextField(
                                            _awayTeamController,
                                            'Team 2 Name',
                                            _awayFocusNode,
                                            value.createdTeams),
                                      ],
                                    );
                                  })),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              "Players",
                              style: GoogleFonts.getFont('Poppins',
                                  color: Colors.blue, fontSize: 16),
                            ),
                            const SizedBox(height: 16),
                            _buildAutocompleteTextField(
                                _team1Player1Controller,
                                'Team 1 - Player 1',
                                _team1P1FocusNode,
                                value.createdTeams),
                            _buildAutocompleteTextField(
                                _team1Player2Controller,
                                'Team 1 - Player 2',
                                _team1P2FocusNode,
                                value.createdTeams),
                            SizedBox(height: 10),
                            _buildAutocompleteTextField(
                                _team2Player1Controller,
                                'Team 2 - Player 1',
                                _team2P1FocusNode,
                                value.createdTeams),
                            _buildAutocompleteTextField(
                                _team2Player2Controller,
                                'Team 2 - Player 2',
                                _team2P2FocusNode,
                                value.createdTeams),
                          ],
                  );
                },
              ),
              const SizedBox(height: 30),
              Consumer<PracticeMatchviewModel>(
                builder: (context, value, child) {
                  return SizedBox(
                    height: 50,
                    width: 110,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.all<Color>(Colors.blue),
                      ),
                      onPressed: () => _submitFormTennis(value),
                      child: _isLoading
                          ? CircularProgressIndicator(color: Colors.white)
                          : Text(
                              "Start Match",
                              style: GoogleFonts.getFont('Poppins',
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCricketUI(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Teams",
                style: GoogleFonts.getFont('Poppins', color: Colors.blue),
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0, 1),
                      blurRadius: 0.5,
                    )
                  ],
                ),
                child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      child: Consumer<PracticeMatchviewModel>(
                          builder: (context, value, child) {
                        return Column(
                          children: [
                            // _buildTextField(
                            //     _hostTeamController, 'Host Team', _hostFocusNode),
                            _buildAutocompleteTextField(
                                _hostTeamController,
                                'Host Team',
                                _hostFocusNode,
                                value.createdTeams),
                            _buildAutocompleteTextField(
                                _visitorTeamController,
                                'Visitor Team',
                                _visitorFocusNode,
                                value.createdTeams),
                          ],
                        );
                      }),
                    )),
              ),
              const SizedBox(height: 16),
              Text(
                "Toss Won by?",
                style: GoogleFonts.getFont('Poppins', color: Colors.blue),
              ),
              const SizedBox(height: 8),
              Container(
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0, 1),
                      blurRadius: 0.5,
                    )
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _buildRadio(
                        _hostTeamController.text.isEmpty
                            ? 'Host'
                            : _hostTeamController.text,
                        _hostTeamController),
                    _buildRadio(
                        _visitorTeamController.text.isEmpty
                            ? 'Visitor'
                            : _visitorTeamController.text,
                        _visitorTeamController),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Text(
                "Opted to ?",
                style: GoogleFonts.getFont('Poppins', color: Colors.blue),
              ),
              const SizedBox(height: 8),
              Container(
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0, 1),
                      blurRadius: 0.5,
                    )
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _buildOptedRadio('Bat'),
                    _buildOptedRadio('Ball'),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Text(
                "Overs",
                style: GoogleFonts.getFont('Poppins', color: Colors.blue),
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0, 1),
                      blurRadius: 0.5,
                    )
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _buildTextField(
                    _oversController,
                    'Overs',
                    _oversFocusNode,
                    TextInputType.number,
                    FilteringTextInputFormatter.digitsOnly,
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                "Striker",
                style: GoogleFonts.getFont('Poppins', color: Colors.blue),
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0, 1),
                      blurRadius: 0.5,
                    )
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: _buildAutocompleteTextField(_strikerController,
                      'Striker', _strikerFocusNode, dummyPlayers),
                ),
              ),
              const SizedBox(height: 30),
              Text(
                "Non-Striker",
                style: GoogleFonts.getFont('Poppins', color: Colors.blue),
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0, 1),
                      blurRadius: 0.5,
                    )
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: _buildAutocompleteTextField(_nonStrikerController,
                      'Non-Striker', _nonStrikerFocusNode, dummyPlayers),
                ),
              ),
              const SizedBox(height: 30),
              Text(
                "Opening Bowler",
                style: GoogleFonts.getFont('Poppins', color: Colors.blue),
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0, 1),
                      blurRadius: 0.5,
                    )
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: _buildTextField(_bowlerController, 'Bowler',
                      _bowlerFocusNode, TextInputType.text),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Consumer<PracticeMatchviewModel>(
                builder: (context, value, child) {
                  return SizedBox(
                    height: 50,
                    width: 110,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.all<Color>(Colors.blue),
                      ),
                      onPressed: () {
                        _submitFormCricket(value);
                      },
                      child: _isLoading
                          ? CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : Text(
                              "Start Match",
                              style: GoogleFonts.getFont('Poppins',
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildBasketballUI(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Teams",
                style: GoogleFonts.getFont('Poppins',
                    color: Colors.blue, fontSize: 16),
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0, 1),
                      blurRadius: 0.5,
                    )
                  ],
                ),
                child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Consumer<PracticeMatchviewModel>(
                        builder: (context, value, child) {
                      return Column(
                        children: [
                          // _buildTextField(
                          //     _hostTeamController, 'Host Team', _hostFocusNode),
                          _buildAutocompleteTextField(_hostTeamController,
                              'Home Team', _hostFocusNode, value.createdTeams),
                          _buildAutocompleteTextField(_awayTeamController,
                              'Away Team', _awayFocusNode, value.createdTeams),
                        ],
                      );
                    })),
              ),
              const SizedBox(height: 16),
              const SizedBox(height: 30),
              Consumer<PracticeMatchviewModel>(
                builder: (context, value, child) {
                  return SizedBox(
                    height: 50,
                    width: 110,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.all<Color>(Colors.blue),
                      ),
                      onPressed: () {
                        _submitFormBasketball(value);
                      },
                      child: _isLoading
                          ? CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : Text(
                              "Start Match",
                              style: GoogleFonts.getFont('Poppins',
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  String selectedMatchType = 'Singles';

  Widget _buildMatchTypeRadio(String value) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Radio(
          value: value,
          groupValue: selectedMatchType,
          activeColor: Colors.blue,
          onChanged: (val) {
            setState(() {
              selectedMatchType = val.toString();
            });
          },
        ),
        Text(
          value,
          style: GoogleFonts.getFont('Poppins', color: Colors.black),
        ),
      ],
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String hint,
    FocusNode focusNode, [
    TextInputType keyboardType = TextInputType.text,
    TextInputFormatter? inputFormatter,
  ]) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      keyboardType: keyboardType,
      inputFormatters: inputFormatter != null ? [inputFormatter] : [],
      decoration: InputDecoration(
        hintText: hint,
        border: InputBorder.none,
      ),
    );
  }

  Widget _buildAutocompleteTextField(TextEditingController controller,
      String label, FocusNode focusNode, List<String> data) {
    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return const Iterable<String>.empty();
        }
        return data.where((String option) {
          return option.contains(textEditingValue.text);
        });
      },
      onSelected: (String selection) {
        controller.text = selection;
        setState(() {});
      },
      fieldViewBuilder: (BuildContext context,
          TextEditingController textEditingController,
          FocusNode focusNode,
          VoidCallback onFieldSubmitted) {
        textEditingController.text = controller.text;
        return TextField(
          controller: controller,
          focusNode: focusNode,
          decoration: InputDecoration(
            labelText: label,
            border: const UnderlineInputBorder(),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.blue, width: 2),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
          style: const TextStyle(
            color: Colors.black,
          ), // Change input text color here
        );
      },
      optionsViewBuilder: (BuildContext context,
          AutocompleteOnSelected<String> onSelected, Iterable<String> options) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 4.0,
            child: Container(
              height: 160,
              color: Colors.white,
              width: 200.0,
              child: ListView.builder(
                padding: const EdgeInsets.all(0.0),
                itemCount: options.length,
                itemBuilder: (BuildContext context, int index) {
                  final String option = options.elementAt(index);
                  return ListTile(
                    title: Text(
                      option,
                      style: const TextStyle(
                          color:
                              Colors.black), // Change dropdown text color here
                    ),
                    onTap: () {
                      onSelected(option);
                    },
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildRadio(String value, TextEditingController controller) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Radio(
          value: value,
          groupValue: selectedOption,
          activeColor: Colors.blue,
          onChanged: (val) {
            setState(() {
              selectedOption = val.toString();
            });
          },
        ),
        Text(
          controller.text.isEmpty ? '$value Team' : controller.text.toString(),
          style: GoogleFonts.getFont('Poppins', color: Colors.black),
        ),
      ],
    );
  }

  Widget _buildOptedRadio(String value) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Radio(
          value: value,
          groupValue: selectedOptedOption,
          activeColor: Colors.blue,
          onChanged: (val) {
            setState(() {
              selectedOptedOption = val.toString();
            });
          },
        ),
        Text(
          value,
          style: GoogleFonts.getFont('Poppins', color: Colors.black),
        ),
      ],
    );
  }
}
