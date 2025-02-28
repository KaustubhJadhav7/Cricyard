import 'package:cricyard/views/screens/MenuScreen/new_dash/Newdashboard.dart';
import 'package:cricyard/views/screens/SportSelection/repository/sportSelectionApiService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SportSelectionScreen extends StatefulWidget {
  const SportSelectionScreen({Key? key}) : super(key: key);

  @override
  State<SportSelectionScreen> createState() => _SportSelectionScreenState();
}

class _SportSelectionScreenState extends State<SportSelectionScreen> {
  String userId = ""; // Store userId here
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
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final sportProvider = Provider.of<SportSelectionProvider>(context);
      super.initState();
      sportProvider.fetchUserId();
    });
  }

  @override
  Widget build(BuildContext context) {
    final sportProvider = Provider.of<SportSelectionProvider>(context, listen: false);
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
                  groupValue: sportProvider.selectedSport,
                  onChanged: (value) {
                    setState(() {
                      sportProvider.selectedSport = value;
                    });
                  },
                )),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (sportProvider.selectedSport != null) {
                  // Save the preferred sport in SharedPreferences
                  sportProvider
                      .savePreferredSport(sportProvider.selectedSport!);
                  print("Sport is set: ${sportProvider.selectedSport}");
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
              child: const Text(
                'Continue',
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }

//   Future<void> _fetchUserId() async {
//   final prefs = await SharedPreferences.getInstance();
//   String? userDataStr = prefs.getString('userData');
//   if (userDataStr != null) {
//     try {
//       Map<String, dynamic> userData = json.decode(userDataStr);
//       if (userData.containsKey('userId')) {
//         setState(() {
//           userId = userData['userId'].toString();
//         });
//         print('User ID from sport selection: $userId');
//       } else {
//         print("User ID not found in stored user data.");
//         userId = ""; // Set empty to prevent unwanted API calls
//       }
//     } catch (e) {
//       print("Error fetching userId: $e");
//     }
//   }
// }

  // Future<void> _updateSportOnBackend(String sport) async {
  //   // final String url = "$baseUrl/api/setSport?userId=$userId&sport=$sport";
  //   final String endpoint = "/api/setSport";
  //   final String encodedSport =
  //       Uri.encodeComponent(sport); // Encode sport parameter
  //   final String url = "$baseUrl$endpoint?userId=$userId&sport=$encodedSport";
  //   print("API URL: ${url}");
  //   try {
  //     final response = await http.post(
  //       Uri.parse(url),
  //       headers: {
  //         "Content-Type": "application/json"
  //       }, // Optional but good practice);
  //     );
  //     if (response.statusCode == 200) {
  //       print("Sport updated successfully on the backend !!");
  //     } else {
  //       print("\$ Failed to update sport in Backend. Status: ${response.statusCode} !!");
  //     }
  //   } catch (e) {
  //     print("Error updating sport on backend: $e");
  //   }
  // }

//   Future<void> _updateSportOnBackend(String sport) async {
//   if (userId.isEmpty) {
//     print("🚫 User ID is empty. Skipping sport update.");
//     return;
//   }
//   final String endpoint = "/api/setSport";
//   final String encodedSport = Uri.encodeComponent(sport);
//   final String url = "$baseUrl$endpoint?userId=$userId&sport=$encodedSport";
//   print("Sending Sport Selection API request: $url");
//   try {
//     final response = await http.post(
//       Uri.parse(url),
//       headers: {"Content-Type": "application/json"},
//     );
//     if (response.statusCode == 200) {
//       print("✅ Sport updated successfully on the backend.");
//     } else {
//       print("❌ Failed to update sport in Backend. "
//             "Status: ${response.statusCode}, Response: ${response.body}");
//     }
//   } catch (e) {
//     print("⚠️ Error updating sport on backend: $e");
//   }
// }

//   Future<void> savePreferredSport(String sport) async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     if (sport == 'None') {
//       // Remove the sport preference if 'None' is selected
//       await prefs.remove('preferred_sport');
//     } else {
//       // Save the selected sport
//       await prefs.setString('preferred_sport', sport);
//     }
//     // If user is logged in, send sport to backend
//     if (userId != null) {
//       await _updateSportOnBackend(sport);
//     } else {
//       print("User not logged in for preferredSport on DB");
//     }
//     // After saving, retrieve the value again to verify it
//     String? savedSport = prefs.getString('preferred_sport');
//     print(
//         'Saved sport: $savedSport'); // This should print the selected sport or null if removed
//   }
}
