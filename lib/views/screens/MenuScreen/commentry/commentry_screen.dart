import 'package:cricyard/views/screens/MenuScreen/commentry/commentary_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CommentaryScreen extends StatefulWidget {
  CommentaryScreen({Key? key}) : super(key: key);

  @override
  State<CommentaryScreen> createState() => _CommentaryScreenState();
}

class _CommentaryScreenState extends State<CommentaryScreen> {

  final CommentaryProvider _commentaryProvider = CommentaryProvider();

   List<Map<String, dynamic>> data = [
    {
      'over': 20,
      'runsScored': 2,
      'teamScore': 89,
      'teamWicketsDown': 1,
      'teamName': 'AFG',
      'striker': 'Rahul N',
      'strikerRun': 56,
      'strikerBalls': 23,
      'nonStriker': 'Rahul N',
      'nonStrikerRun': 56,
      'nonStrikerBalls': 23,
      'baller': 'Tevatiya',
      'ballerTotalOver': 3,
      'ballerTotalRun': 23,
      'ballerTotalW': 3,
      'ballerExtras': 1,
      'ballDetails': [
        {
          'ballNumber': '18.1',
          'runs': 1,
          'ballerToBatsman': 'Tevatiya to Rahul N',
          'runsInAlphabet': 'Single',
          'commentary': 'floated up outside off, Rahul N gets forward and blocks',
        },
        {
          'ballNumber': '18.2',
          'ballerToBatsman': 'Tevatiya to Rahul N',
          'runsInAlphabet': 'Four',
          'runs': 4,
          'commentary': 'short and wide outside off, Rahul N cuts it through point for four',
        },
        {
          'ballNumber': '18.3',
          'ballerToBatsman': 'Tevatiya to Rahul N',
          'runsInAlphabet': 'No run',
          'runs': 0,
          'commentary': 'good length ball, defended back to the bowler',
        },
        {
          'ballNumber': '18.4',
          'ballerToBatsman': 'Tevatiya to Rahul N',
          'runsInAlphabet': 'Single',
          'runs': 1,
          'commentary': 'angled in, Rahul N works it to midwicket for a quick single',
        },
        {
          'ballNumber': '18.5',
          'ballerToBatsman': 'Tevatiya to Rahul N',
          'runsInAlphabet': 'No run',
          'runs': 0,
          'commentary': 'full and outside off, Rahul N drives but finds cover',
        },
        {
          'ballNumber': '18.6',
          'ballerToBatsman': 'Tevatiya to Rahul N',
          'runsInAlphabet': 'Four',
          'runs': 4,
          'commentary': 'short ball, Rahul N pulls it through midwicket for four runs',
        },
      ],
    },
    {
      'over': 21,
      'runsScored': 8,
      'teamScore': 97,
      'teamWicketsDown': 1,
      'teamName': 'AFG',
      'striker': 'Rahul N',
      'strikerRun': 64,
      'strikerBalls': 29,
      'nonStriker': 'Rahul N',
      'nonStrikerRun': 56,
      'nonStrikerBalls': 23,
      'baller': 'Malinga',
      'ballerTotalOver': 4,
      'ballerTotalRun': 28,
      'ballerTotalW': 1,
      'ballerExtras': 2,
      'ballDetails': [
        {
          'ballNumber': '19.1',
          'runs': 0,
          'ballerToBatsman': 'Malinga to Rahul N',
          'runsInAlphabet': 'No run',
          'commentary': 'good length ball outside off, defended solidly by Rahul N',
        },
        {
          'ballNumber': '19.2',
          'runs': 4,
          'ballerToBatsman': 'Malinga to Rahul N',
          'runsInAlphabet': 'Four',
          'commentary': 'short and wide, Rahul N cuts it hard through cover for four runs',
        },
        {
          'ballNumber': '19.3',
          'runs': 1,
          'ballerToBatsman': 'Malinga to Rahul N',
          'runsInAlphabet': 'Single',
          'commentary': 'angled in, Rahul N tucks it to square leg and takes a quick single',
        },
        {
          'ballNumber': '19.4',
          'runs': 1,
          'ballerToBatsman': 'Malinga to Non Striker',
          'runsInAlphabet': 'Single',
          'commentary': 'full delivery on off, driven down to long-off for a single',
        },
        {
          'ballNumber': '19.5',
          'runs': 0,
          'ballerToBatsman': 'Malinga to Rahul N',
          'runsInAlphabet': 'No run',
          'commentary': 'short ball, Rahul N ducks under it comfortably',
        },
        {
          'ballNumber': '19.6',
          'runs': 2,
          'ballerToBatsman': 'Malinga to Rahul N',
          'runsInAlphabet': 'Two',
          'commentary': 'full on the pads, Rahul N flicks it through midwicket for a couple',
        },
      ],
    },
    {
      'over': 22,
      'runsScored': 12,
      'teamScore': 109,
      'teamWicketsDown': 1,
      'teamName': 'AFG',
      'striker': 'Rahul N',
      'strikerRun': 72,
      'strikerBalls': 34,
      'nonStriker': 'Rahul N',
      'nonStrikerRun': 56,
      'nonStrikerBalls': 23,
      'baller': 'Malinga',
      'ballerTotalOver': 5,
      'ballerTotalRun': 40,
      'ballerTotalW': 1,
      'ballerExtras': 3,
      'ballDetails': [
        {
          'ballNumber': '20.1',
          'runs': 4,
          'ballerToBatsman': 'Malinga to Rahul N',
          'runsInAlphabet': 'Four',
          'commentary': 'full and wide outside off, Rahul N drives it through cover for four runs',
        },
        {
          'ballNumber': '20.2',
          'runs': 1,
          'ballerToBatsman': 'Malinga to Rahul N',
          'runsInAlphabet': 'Single',
          'commentary': 'good length on off, nudged into the gap at mid-on for a single',
        },
        {
          'ballNumber': '20.3',
          'runs': 2,
          'ballerToBatsman': 'Malinga to Non Striker',
          'runsInAlphabet': 'Two',
          'commentary': 'short ball, pulled away through square leg for a couple',
        },
        {
          'ballNumber': '20.4',
          'runs': 1,
          'ballerToBatsman': 'Malinga to Rahul N',
          'runsInAlphabet': 'Single',
          'commentary': 'full delivery outside off, driven to long-off for a single',
        },
        {
          'ballNumber': '20.5',
          'runs': 1,
          'ballerToBatsman': 'Malinga to Non Striker',
          'runsInAlphabet': 'Single',
          'commentary': 'short of length, dabbed down to third man for a single',
        },
        {
          'ballNumber': '20.6',
          'runs': 3,
          'ballerToBatsman': 'Malinga to Rahul N',
          'runsInAlphabet': 'Three',
          'commentary': 'full on the pads, flicked through midwicket, fielder slides and saves a run',
        },
      ],
    },
  ];

   bool _isLoading = false;

  Future<void> fetchCommentary()async{
    setState(() {
      _isLoading = true;
    });
    final res = await  _commentaryProvider.fetchCommentary();
    if(res.isNotEmpty){
      setState(() {
        data = res;
        _isLoading = false;

      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Commentary",
          style: GoogleFonts.poppins(),
        ),
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
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body: _isLoading ?  const Center(child: CircularProgressIndicator()): SizedBox(
        height: MediaQuery.of(context).size.height - kToolbarHeight - 50,
        child: ListView.builder(
          reverse: true,
          itemCount: data.length,
          itemBuilder: (context, index) {
            final mData = data[index];
            return _myDataTiles(context, mData);
          },
        ),
      ),
    );
  }

  Widget _myDataTiles(BuildContext context, Map<String, dynamic> data) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.all(8.0),
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Over ${data['over']}",
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildRunsScoredWidget(data),
                    _verticalDivider(context),
                    _buildScoreAfterOverWidget(data),
                    _verticalDivider(context),
                    _buildPlayerStatsWidget(data),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          _buildBallDetailsList(context, data),
        ],
      ),
    );
  }

  Widget _verticalDivider(BuildContext context){
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: MediaQuery.of(context).size.height*0.07,
        width: 1,
        color: Colors.grey,
      ),
    );
  }

  Widget _buildRunsScoredWidget(Map<String, dynamic> data) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "Runs Scored: ",
              style: GoogleFonts.poppins(color: Colors.black),
            ),
            Text(
              "${data['ballerTotalRun']}",
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 7,),
        SizedBox(
          height: 30,
          child: ListView.builder(
            shrinkWrap: true,
            reverse: true,
            scrollDirection: Axis.horizontal,
            physics: NeverScrollableScrollPhysics(),
            itemCount: data['ballDetails'].length,
            itemBuilder: (context, index) {
              final ballDetails = data['ballDetails'][index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Text(
                  "${ballDetails['runs']}",
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildScoreAfterOverWidget(Map<String, dynamic> data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          "Score After ${data['over']} Overs:",
          style: GoogleFonts.poppins(color: Colors.black),
        ),
        SizedBox(height: 10,),
        Text(
          "${data['teamName']} ${data['teamScore']}-${data['teamWicketsDown']}",
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildPlayerStatsWidget(Map<String, dynamic> data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${data['striker']} ${data['strikerRun']} (${data['strikerBalls']})",
          style: GoogleFonts.poppins(color: Colors.black),
        ),
        Text(
          "${data['nonStriker']} ${data['nonStrikerRun']} (${data['nonStrikerBalls']})",
          style: GoogleFonts.poppins(color: Colors.black),
        ),
        const SizedBox(height: 10),
        Text(
          "${data['baller']}",
          style: GoogleFonts.poppins(color: Colors.black),
        ),
        Text(
          "${data['ballerTotalOver']}-${data['ballerTotalW']}-${data['ballerTotalRun']}-${data['ballerExtras']}",
          style: GoogleFonts.poppins(color: Colors.black),
        ),
      ],
    );
  }

  Widget _buildBallDetailsList(BuildContext context, Map<String, dynamic> data) {
    return ListView.builder(
      shrinkWrap: true,
      reverse: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: data['ballDetails'].length,
      itemBuilder: (context, index) {
        final ballDetails = data['ballDetails'][index];
        return ListTile(
          leading: Text(
            "${ballDetails['ballNumber']}",
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          title: RichText(
            text: TextSpan(
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: 12,
              ),
              children: [
                TextSpan(
                  text: "${ballDetails['ballerToBatsman']} ",
                ),
                TextSpan(
                  text: "${ballDetails['runsInAlphabet']} ",
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: "${ballDetails['commentary']}",
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
