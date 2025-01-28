import 'package:cricyard/views/screens/Login%20Screen/view/login_screen_f.dart';
import 'package:cricyard/views/screens/MenuScreen/new_dash/Newdashboard.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SportSelectionScreen extends StatefulWidget {
  const SportSelectionScreen({Key? key}) : super(key: key);

  @override
  State<SportSelectionScreen> createState() => _SportSelectionScreenState();
}

class _SportSelectionScreenState extends State<SportSelectionScreen> {
  String? selectedSport;
  final List<String> sportsList = [
    'Cricket',
    'Football',
    'Basketball',
    'Tennis',
    'Hockey',
    'None'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wide Variety Of Sports To Choose From!'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Choose your preferred sport:',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            const SizedBox(height: 16),
            ...sportsList.map((sport) => RadioListTile<String>(
                  title: Text(sport),
                  value: sport,
                  groupValue: selectedSport,
                  onChanged: (value) {
                    setState(() {
                      selectedSport = value;
                    });
                  },
                )),
            const SizedBox(height: 20),
            ElevatedButton(
              
              onPressed: () {
                if (selectedSport != null) {
                  // Save the preferred sport in SharedPreferences
                  savePreferredSport(selectedSport!);
                  // Navigate to Login or Home
                  Navigator.pushReplacement(
                    context,
                    // MaterialPageRoute(builder: (context) => const LoginScreenF(false)),
                    MaterialPageRoute(builder: (context) => Newdashboard()),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Please select a sport to continue.')),
                  );
                }
              },
              child: const Text('Continue', style: TextStyle(fontSize: 18, color: Colors.black),),
            ),
          ],
        ),
      ),
    );
  }


  // Future<void> savePreferredSport(String sport) async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.setString('preferred_sport', sport);
  //   // After saving, retrieve the value again to verify it
  //   String? savedSport = prefs.getString('preferred_sport');
  //   print('Saved sport: $savedSport'); // This should print the selected sport
  // }
  Future<void> savePreferredSport(String sport) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  if (sport == 'None') {
    // Remove the sport preference if 'None' is selected
    await prefs.remove('preferred_sport');
  } else {
    // Save the selected sport
    await prefs.setString('preferred_sport', sport);
  }

  // After saving, retrieve the value again to verify it
  String? savedSport = prefs.getString('preferred_sport');
  print('Saved sport: $savedSport'); // This should print the selected sport or null if removed
}

}
