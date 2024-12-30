import 'package:cricyard/core/app_export.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../theme/custom_text_style.dart';

class Myfollowingscreen extends StatefulWidget {
  const Myfollowingscreen({super.key});

  @override
  State<Myfollowingscreen> createState() => _MyfollowingscreenState();
}

class _MyfollowingscreenState extends State<Myfollowingscreen> {

  int _selectedIndex =0;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: Column(
          children: [
           _headerWidget(),
           const SizedBox(height: 20,),
            _customTabBar(),
            const SizedBox(height: 20,),
            _selectedTabContent(),

          ],
        ),
      ),
    );
  }

  Widget _headerWidget(){
    return  SizedBox(
      height: 60,
      child: Row(
        children: [
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: const Color(0xFFC4FD62),

                  borderRadius: BorderRadius.circular(12)
              ),
              child: const Icon(Icons.arrow_back_ios_new,color: Colors.black,),
            ),
          ),
          const SizedBox(width: 15,),
          Text("Following",style: CustomTextStyles.titleLargePoppinsBlack40)
        ],
      ),
    );
  }

  Widget _customTabBar() {
    return Container(
      height: 70,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          _tabItem(
            index: 0,
            selectedIndex: _selectedIndex,
            onTap: () {
              setState(() {
                _selectedIndex = 0;
              });
            },
            text: "India",
          ),
          _tabItem(
            index: 1,
            selectedIndex: _selectedIndex,
            onTap: () {
              setState(() {
                _selectedIndex = 1;
              });
            },
            text: "Shri Lanka",
          ),
        ],
      ),
    );
  }

  Widget _tabItem({required int index,selectedIndex, required VoidCallback onTap, required String text}) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
                color:
                index == selectedIndex ? Colors.black : Colors.transparent,
                borderRadius: BorderRadius.circular(30)),
            child: Center(
              child: Text(text,
                  style: index == selectedIndex
                      ? CustomTextStyles.titleSmallPoppinsWhite
                      : CustomTextStyles.titleSmallGray600),
            ),
          ),
        ),
      ),
    );
  }

  Widget _selectedTabContent() {
    switch (_selectedIndex) {
      case 0:
        return _buildIndiaContent();
      case 1:
        return _buildSriLankaContent();
      default:
        return Container();
    }
  }

  Widget _buildIndiaContent(){
    return Column(
      children: [
        // playing 11
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Container(
              height: MediaQuery.of(context).size.height*0.6,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child:_buildPlaying11PlayerRowWidget('India')),
        ),
        const SizedBox(height: 20,),
        // on bench
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Container(
              height: MediaQuery.of(context).size.height*0.35,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child:_buildOnBenchPlayerRowWidget()),
        ),
      ],
    );
  }

  Widget _buildSriLankaContent(){
    return Column(
      children: [
        // playing 11
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Container(
              height: MediaQuery.of(context).size.height*0.6,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child:_buildPlaying11PlayerRowWidget('SriLanka')),
        ),
        const SizedBox(height: 20,),
        // on bench
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Container(
              height: MediaQuery.of(context).size.height*0.35,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child:_buildOnBenchPlayerRowWidget()),
        ),
      ],
    );
  }

  Widget _buildPlaying11PlayerRowWidget(String team){
    return  Column(
      children: [
        const SizedBox(height: 10,),
       _buildTitleRowWidget(title1: 'Playing XI $team',subtitle1: '',title2: '',title3: '',subtitle2: '',subtitle3: ''),
        _buildPlayerImgRowWidget(imgPath1: ImageConstant.imgImage51, imgPath2: ImageConstant.imgImage51, imgPath3: ImageConstant.imgImage51),
       const Divider(color: Colors.grey,),
        _buildTitleRowWidget(title1: 'R Sharma(c)',subtitle1: 'Batter',title2: 'S Gill',subtitle2: 'Batter',title3: 'V Kholi',subtitle3: 'Batter'),
       const SizedBox(height: 10,),
        _buildPlayerImgRowWidget(imgPath1: ImageConstant.imgImage51, imgPath2: ImageConstant.imgImage51, imgPath3: ImageConstant.imgImage51),
        const Divider(color: Colors.grey,),
        _buildTitleRowWidget(title1: 'Rinku (vc)',subtitle1: 'Batter',title2: 'S Gill',subtitle2: 'Batter',title3: 'V Kholi',subtitle3: 'Batter'),
        const SizedBox(height: 10,),
        _buildPlayerImgRowWidget(imgPath1: ImageConstant.imgImage51, imgPath2: ImageConstant.imgImage51, imgPath3: ImageConstant.imgImage51),
        const Divider(color: Colors.grey,),
        _buildTitleRowWidget(title1: 'Rinku (vc)',subtitle1: 'Batter',title2: 'S Gill',subtitle2: 'Batter',title3: 'V Kholi',subtitle3: 'Batter'),
        const SizedBox(height: 10,),
        _buildPlayerImgRowWidget(imgPath1: ImageConstant.imgImage51, imgPath2: ImageConstant.imgImage51, imgPath3: ''),
        const Divider(color: Colors.grey,),
        _buildTitleRowWidget(title1: 'J.Bumhrah',subtitle1: 'Baller',title2: 'ArshaDeep',subtitle2: 'Baller',title3: '',subtitle3: ''),

      ],
    );
  }
  Widget _buildOnBenchPlayerRowWidget(){
    return  Column(
      children: [
        const SizedBox(height: 10,),
       _buildTitleRowWidget(title1: 'On Bench',subtitle1: '',title2: '',title3: '',subtitle2: '',subtitle3: ''),
        _buildPlayerImgRowWidget(imgPath1: ImageConstant.imgImage51, imgPath2: ImageConstant.imgImage51, imgPath3: ImageConstant.imgImage51),
       const Divider(color: Colors.grey,),
        _buildTitleRowWidget(title1: 'R Sharma(c)',subtitle1: 'Batter',title2: 'S Gill',subtitle2: 'Batter',title3: 'V Kholi',subtitle3: 'Batter'),
        _buildPlayerImgRowWidget(imgPath1: ImageConstant.imgImage51, imgPath2: ImageConstant.imgImage51, imgPath3: ImageConstant.imgImage51),
        const Divider(color: Colors.grey,),
        _buildTitleRowWidget(title1: 'R Sharma(c)',subtitle1: 'Batter',title2: 'S Gill',subtitle2: 'Batter',title3: 'V Kholi',subtitle3: 'Batter'),

      ],
    );
  }

  Widget _buildTitleRowWidget({String? title1,String? subtitle1,String? title2,String? subtitle2,String? title3,String? subtitle3}){
    return  Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 15,),
        Expanded(
            child: Column(
              children: [
                Text("$title1",style:title2!.isEmpty ? CustomTextStyles.titleMediumPoppins :CustomTextStyles.titleSmallPoppinsBlack900,),
                Text("$subtitle1",style:CustomTextStyles.titleSmallGray600,),
              ],
            )),
       title2.isEmpty ? Container(): Expanded(
            child: Column(
              children: [
                Text("$title2",style:CustomTextStyles.titleSmallPoppinsBlack900,),
                Text("$subtitle2",style:CustomTextStyles.titleSmallGray600,),
              ],
            )),
       title3!.isEmpty ? Container(): Expanded(
            child: Column(
              children: [
                Text("$title3",style:CustomTextStyles.titleSmallPoppinsBlack900,),
                Text("$subtitle3",style:CustomTextStyles.titleSmallGray600,),
              ],
            )),

      ],
    );
  }
  Widget _buildPlayerImgRowWidget({required String imgPath1,required String imgPath2,required String imgPath3}){
    return  SizedBox(
      height: 70,
      child: Row(
        children: [
          Expanded(
              child: Image.asset(imgPath1)),
          Expanded(
              child: Image.asset(imgPath2)),
         imgPath3.isEmpty ?Container(): Expanded(
              child: Image.asset(imgPath3)),
        ],
      ),
    );
  }
}