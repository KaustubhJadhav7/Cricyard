// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:cricyard/core/app_export.dart';
import 'package:flutter/material.dart';

import '../../../../../Entity/matches/Match/repository/Match_api_service.dart';
import '../../../../../theme/custom_button_style.dart';
import '../../../../widgets/custom_elevated_button.dart';
import '../scoring/matchScore.dart';

class Matches extends StatefulWidget {
  const Matches({Key? key}) : super(key: key);

  @override
  MatchesState createState() => MatchesState();
}

class MatchesState extends State<Matches>
    with AutomaticKeepAliveClientMixin<Matches> {
  final MatchApiService apiService = MatchApiService();
  List<Map<String, dynamic>> myMatchsEntities = [];
  bool isLoading = false;
  late DateTime matchDateTime;
  late Duration timeRemaining;
  late String formattedTimeRemaining = '';
  @override
  void initState() {
    super.initState();
    allMAtches();
  }


  Future<void> allMAtches() async {
    setState(() {
      isLoading = true;
    });
    try {
      // remove tournament id and pass dynamically

      final fetchedEntities = await apiService.allmatches(1);
      print('data is $fetchedEntities');
      setState(() {
        myMatchsEntities = fetchedEntities;
        isLoading = false;
      });
      print('Match entity is .. $myMatchsEntities');
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text('Failed to fetch Match: $e'),
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

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.maxFinite,
          decoration: AppDecoration.fillGray,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 18.v),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildMyMatchesRow(context),
                    SizedBox(height: 31.v),
                    _buildGridText(context),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMyMatchesRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 7.0),
            child: _buildCustomElevatedButton(text: "Following"),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 7.0),
            child: _buildCustomElevatedButton(
              text: "All",
              onPressed: () => allMAtches(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCustomElevatedButton({required String text, VoidCallback? onPressed,}) {
    return CustomElevatedButton(
      height: 50.v,
      width: MediaQuery.of(context).size.width * 0.1,
      text: text,
      buttonStyle: CustomButtonStyles.none,
      decoration: CustomButtonStyles.fullyBlack,
      buttonTextStyle: CustomTextStyles.titleMediumGray50,
      onPressed: onPressed,
    );
  }

  Widget _buildGridText(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (myMatchsEntities.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Text(
            'No matches found.',
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
        ),
      );
    } else {
      return Padding(
        padding: EdgeInsets.only(right: 11.h),
        child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: myMatchsEntities.length,
          itemBuilder: (BuildContext context, int index) {
            final entity = myMatchsEntities[index];
            return _buildListItem(entity);
          },
        ),
      );
    }
  }

  Widget _buildListItem(Map<String, dynamic> entity) {
    final matchDateTime = DateTime.parse(entity['datetime_field']);
    final now = DateTime.now();
    final timeRemaining = matchDateTime.difference(now);
    final hours = timeRemaining.inHours;
    final minutes = timeRemaining.inMinutes % 60;
    final formattedTimeRemaining = "${hours}h : ${minutes}m";
    final matchStatus = entity['matchStatus'];
    bool status = getStatus(matchStatus);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MatchScoreScreen(
              entity: entity, status: status,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        height: 100,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(12)),
        child: Row(
          children: [
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.transparent,
                  backgroundImage: AssetImage(ImageConstant.imgEngRoundFlag),
                ),
                Text(
                  entity['team_1_name'],
                  style: CustomTextStyles.titleMediumPoppins,
                )
              ],
            )),
            const SizedBox(
              width: 6,
            ),
            Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      entity['tournament_name'] ?? 'Match',
                      style: CustomTextStyles.titleMediumPoppins,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          formattedTimeRemaining.contains('-')
                              ? 'Match Over'
                              : formattedTimeRemaining,
                          style: formattedTimeRemaining.contains('-')
                              ? CustomTextStyles.titleSmallRed700
                              : CustomTextStyles.titleSmallDeeppurpleA400,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          entity['datetime_field'],
                          style: CustomTextStyles.titleSmallGray600,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Location: ${entity['location']}",
                      style: CustomTextStyles.titleSmallGray600,
                    ),
                  ],
                )),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.transparent,
                  backgroundImage:
                      AssetImage(ImageConstant.imgShriLankaRoundFlag),
                ),
                Text(
                  entity['team_2_name'],
                  style: CustomTextStyles.titleMediumPoppins,
                )
              ],
            )),
          ],
        ),
      ),
    );
  }
  bool getStatus(String status){
    if(status == 'Started'){
      return  true;
    }
    else{
      return false;
    }
  }
}