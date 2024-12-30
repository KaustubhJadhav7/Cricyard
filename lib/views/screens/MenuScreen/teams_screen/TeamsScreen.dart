import 'package:cricyard/views/screens/MenuScreen/teams_screen/teamView/EnrollInTeam_view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../Entity/team/views/Teams_create_entity_screen.dart';
import '../../../../core/app_export.dart';
import '../../../../theme/custom_button_style.dart';
import '../../../widgets/custom_elevated_button.dart';
import 'my_teams_screen.dart';

class TeamsSubScreen extends StatefulWidget {
  const TeamsSubScreen({Key? key}) : super(key: key);

  @override
  TeamsSubScreenState createState() => TeamsSubScreenState();
}

class TeamsSubScreenState extends State<TeamsSubScreen>
    with AutomaticKeepAliveClientMixin<TeamsSubScreen> {
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
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        elevation: 0,
        forceMaterialTransparency: true,
        backgroundColor: Colors.grey[200],
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: const Color(0xFF219ebc),
                  borderRadius: BorderRadius.circular(12)),
              child: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
              ),
            ),
          ),
        ),
        title: Text(
          "Teams",
          style:
              GoogleFonts.getFont('Poppins', fontSize: 20, color: Colors.black),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: screenHeight * 0.04),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.048,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildRow(context),
                SizedBox(height: screenHeight * 0.08),
                SizedBox(
                  height: screenHeight * 0.08,
                  child: _buildDropdown(context),
                ),
                SizedBox(
                    height: screenHeight * 0.08), // Adjust spacing as needed
              ],
            ),
          ),
          // Spacer(), // Push buttons to the bottom
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.048,
            ),
            child: _buildButtons(context),
          ),
        ],
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
          text: "My Team",
          buttonStyle: CustomButtonStyles.none,
          decoration: BoxDecoration(
              color: Color(0xFF264653),
              borderRadius: BorderRadius.circular(12)),
          buttonTextStyle: CustomTextStyles.titleMediumGray50,
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => MyTeamScreen()));
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
          // onPressed: () {
          //   Navigator.push(context,
          //       MaterialPageRoute(builder: (context) => Myfollowingscreen()));
          // },
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
          // onPressed: () {
          //   Navigator.push(
          //       context, MaterialPageRoute(builder: (context) => AllScreen()));
          // },
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
                text: "Create Team",
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
                      builder: (context) => TeamsCreateEntityScreen(),
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
                text: "Enroll",
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
                      builder: (context) => const EnrollInTeamView(),
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
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            isExpanded: true,
            icon: const Icon(Icons.arrow_drop_down),
            iconSize: 36.0,
            iconEnabledColor: Colors.black,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16.0,
            ),
            hint: const Text('Choose Audio'), // Placeholder
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
