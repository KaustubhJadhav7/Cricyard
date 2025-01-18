import 'package:cricyard/views/screens/MenuScreen/tournament/views/RegisterTournament.dart';
import 'package:cricyard/views/screens/MenuScreen/tournament/all_screen/all_screen.dart';
import 'package:cricyard/views/screens/MenuScreen/tournament/following_screen/myFollowingScreen.dart';
import 'package:cricyard/views/screens/MenuScreen/tournament/my_tournamnet_screen/my_tournament_screen.dart';
import 'package:flutter/material.dart';
import '../../../../../Entity/add_tournament/My_Tournament/views/My_Tournament_create_entity_screen.dart';
import '../../../../../core/app_export.dart';
import '../../../../../theme/custom_button_style.dart';
import '../../../../widgets/custom_elevated_button.dart';

class TournamentSubScreen extends StatefulWidget {
  const TournamentSubScreen({Key? key}) : super(key: key);

  @override
  TournamentSubScreenState createState() => TournamentSubScreenState();
}

class TournamentSubScreenState extends State<TournamentSubScreen>
    with AutomaticKeepAliveClientMixin<TournamentSubScreen> {
  @override
  bool get wantKeepAlive => true;
  late String _selectedLanguage;

  @override
  void initState() {
    super.initState();
    _selectedLanguage = 'Choose Audio'; // Initialize the selected language
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              _buildRow(context),
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.08,
                child: _buildDropdown(context),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.04),
              // Spacer(), // Push buttons to the bottom
              _buildButtons(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomElevatedButton(
          height: 0.06 * MediaQuery.of(context).size.height,
          width: 0.35 * MediaQuery.of(context).size.width,
          text: "My Tournament",
          buttonStyle: CustomButtonStyles.none,
          decoration: BoxDecoration(
              color: Color(0xFF264653),
              borderRadius: BorderRadius.circular(12)),
          buttonTextStyle: CustomTextStyles.titleMediumGray50,
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => MyTournamnetScreen()));
          },
        ),
        CustomElevatedButton(
          height: 0.06 * MediaQuery.of(context).size.height,
          width: 0.25 * MediaQuery.of(context).size.width,
          text: "Following",
          buttonStyle: CustomButtonStyles.none,
          decoration: BoxDecoration(
              color: Color(0xFF264653),
              borderRadius: BorderRadius.circular(12)),
          buttonTextStyle: CustomTextStyles.titleMediumGray50,
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Myfollowingscreen()));
          },
        ),
        CustomElevatedButton(
          height: 0.06 * MediaQuery.of(context).size.height,
          width: 0.20 * MediaQuery.of(context).size.width,
          text: "All",
          buttonStyle: CustomButtonStyles.none,
          decoration: BoxDecoration(
              color: Color(0xFF264653),
              borderRadius: BorderRadius.circular(12)),
          buttonTextStyle: CustomTextStyles.titleMediumGray50,
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => AllScreen()));
          },
        )
      ],
    );
  }

  Widget _buildButtons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0), // Add margin at the bottom
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: CustomElevatedButton(
                height: 48.v,
                text: "Create Tournament",
                buttonStyle: CustomButtonStyles.none,
                decoration: BoxDecoration(
                    color: Color(0xFF264653),
                    borderRadius: BorderRadius.circular(12)),
                buttonTextStyle: const TextStyle(
                  color: Colors.white, // White text color
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyTournamentCreateEntityScreen(),
                    ),
                  );
                },
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: CustomElevatedButton(
                height: 49.v,
                text: "Enroll In Tournament",
                buttonStyle: CustomButtonStyles.none,
                decoration: BoxDecoration(
                    color: Color(0xFF264653),
                    borderRadius: BorderRadius.circular(12)),
                buttonTextStyle: const TextStyle(
                  color: Colors.white, // White text color
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegisterTournament(),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown(BuildContext context) {
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: Color(0xFF0096c7),
          width: 2.0,
        ), // Yellow border
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.0),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            isExpanded: true,
            icon: Icon(Icons.arrow_drop_down),
            iconSize: 36.0,
            iconEnabledColor: Colors.black,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16.0,
            ),
            hint: Text('Choose Audio'), // Placeholder
            value: _selectedLanguage,
            onChanged: (String? newValue) {
              setState(() {
                _selectedLanguage = newValue!;
              });
            },
            items: <String>[
              'Choose Audio',
              'English',
              'Spanish',
              'French',
              'German'
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}