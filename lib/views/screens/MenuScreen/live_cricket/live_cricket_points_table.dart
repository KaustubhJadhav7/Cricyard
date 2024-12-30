import 'package:flutter/material.dart';
import 'dart:ui';
// import 'package:flutter_app/utils.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../routes/app_routes.dart';
import '../../ReuseableWidgets/BottomAppBarWidget.dart';

class LiveCricketPointsTable extends StatefulWidget {
  @override
  _LiveCricketPointsTableState createState() => _LiveCricketPointsTableState();
}

class _LiveCricketPointsTableState extends State<LiveCricketPointsTable> {

  List<Map<String,dynamic>> dummyData =[
    {
      'team' : 'MI',
      'R' : '1',
      'W' : '10',
      'L' : '0',
      'Nr' : '10',
      'Pts' : '20',
      'NRR' : '+2.90',
    },
    {
      'team' : 'RCB',
      'R' : '2',
      'W' : '8',
      'L' : '2',
      'Nr' : '10',
      'Pts' : '16',
      'NRR' : '+1.09',
    },
    {
      'team' : 'RR',
      'R' : '2',
      'W' : '8',
      'L' : '2',
      'Nr' : '10',
      'Pts' : '16',
      'NRR' : '-0.456',
    },
    {
      'team' : 'PKBS',
      'R' : '2',
      'W' : '8',
      'L' : '2',
      'Nr' : '10',
      'Pts' : '16',
      'NRR' : '-O.101',
    },
    {
      'team' : 'RCB',
      'R' : '2',
      'W' : '8',
      'L' : '2',
      'Nr' : '10',
      'Pts' : '16',
      'NRR' : '-1.09',
    },
    {
      'team' : 'RCB',
      'R' : '2',
      'W' : '8',
      'L' : '2',
      'Nr' : '10',
      'Pts' : '16',
      'NRR' : '-1.09',
    },
    {
      'team' : 'RCB',
      'R' : '2',
      'W' : '8',
      'L' : '2',
      'Nr' : '10',
      'Pts' : '16',
      'NRR' : '-1.09',
    },
    {
      'team' : 'RCB',
      'R' : '2',
      'W' : '8',
      'L' : '2',
      'Nr' : '10',
      'Pts' : '16',
      'NRR' : '-1.09',
    },
    {
      'team' : 'RCB',
      'R' : '2',
      'W' : '8',
      'L' : '2',
      'Nr' : '10',
      'Pts' : '16',
      'NRR' : '-1.09',
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0,right: 8,top: 55),
            child: ListView.builder(
              itemCount: dummyData.length,
              itemBuilder: (context, index) {
                final data = dummyData[index];
                return _myContainer(heading: data['team'], R: data['R'], W: data['W'], L: data['L'], Nr: data['Nr'], Pts: data['Pts'], Nrr:data['NRR']);

            },),
          ),
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: Container(
              height: 50,
              color: Colors.black87,
              child:   Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text("Teams",style: GoogleFonts.getFont(
                        'Poppins',
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: const Color(0xFFFFFFFF),
                      )),
                    ),
                    Expanded(
                      child: Text("R",style: GoogleFonts.getFont(
                        'Poppins',
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: const Color(0xFFFFFFFF),
                      )),
                    ),
                    Expanded(
                      child: Text("W",style: GoogleFonts.getFont(
                        'Poppins',
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: const Color(0xFFFFFFFF),
                      )),
                    ),
                    Expanded(
                      child: Text("L",style: GoogleFonts.getFont(
                        'Poppins',
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: const Color(0xFFFFFFFF),
                      )),
                    ),
                    Expanded(
                      child: Text("Nr",style: GoogleFonts.getFont(
                        'Poppins',
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: const Color(0xFFFFFFFF),
                      )),
                    ),
                    Expanded(
                      child: Text("Pts",style: GoogleFonts.getFont(
                        'Poppins',
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: const Color(0xFFFFFFFF),
                      )),
                    ),
                    Expanded(
                      child: Text("Nrr",style: GoogleFonts.getFont(
                        'Poppins',
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: const Color(0xFFFFFFFF),
                      )),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomAppBarWidget(),
    );
  }

  onTapBtnfixture(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.Fixturelive);
  }

  Widget _myContainer({required String heading,required R,required W,required L,required Nr,required Pts,required String Nrr}){
    Color textColor = Nrr.contains('+') ? Colors.green : Colors.red;

    return Container(
      height: 70,
      width: double.infinity,
      color: Colors.black,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(height: 20,),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(heading,style: GoogleFonts.getFont(
                    'Poppins',
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    color: const Color(0xFFFFFFFF),
                  )),
                ),
                Expanded(
                  child: Text(R,style: GoogleFonts.getFont(
                    'Poppins',
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    color: const Color(0xFFFFFFFF),
                  )),
                ),
                Expanded(
                  child: Text(W,style: GoogleFonts.getFont(
                    'Poppins',
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    color: const Color(0xFFFFFFFF),
                  )),
                ),
                Expanded(
                  child: Text(L,style: GoogleFonts.getFont(
                    'Poppins',
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    color: const Color(0xFFFFFFFF),
                  )),
                ),
                Expanded(
                  child: Text(Nr,style: GoogleFonts.getFont(
                    'Poppins',
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    color: const Color(0xFFFFFFFF),
                  )),
                ),
                Expanded(
                  child: Text(Pts,style: GoogleFonts.getFont(
                    'Poppins',
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    color: const Color(0xFFFFFFFF),
                  )),
                ),
                Expanded(
                  child: Text("$Nrr",style: GoogleFonts.getFont(
                    'Poppins',
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    color:textColor,
                  )),
                ),
              ],
            ),
            SizedBox(height: 10),
            const Divider(color: Colors.grey,thickness: 0.5,)
          ],
        ),
      ),
    );
  }
}