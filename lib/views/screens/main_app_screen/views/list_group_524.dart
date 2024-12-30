import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../Utils/color_constants.dart';
import '../../../../Utils/size_utils.dart';
import '../../../../providers/token_manager.dart';
import '../../../../resources/api_constants.dart';
import '../../../../theme/app_style.dart';
import '../../LogoutService/Logoutservice.dart';
import 'package:http/http.dart' as http;

class Listgroup524ItemWidget extends StatefulWidget {
  final Map<String, dynamic> userData;
  Listgroup524ItemWidget({required this.userData});

  @override
  State<Listgroup524ItemWidget> createState() => _Listgroup524ItemWidgetState();
}

class _Listgroup524ItemWidgetState extends State<Listgroup524ItemWidget> {
  int myProjectcount = 0;
  int sharedWithMeCount = 0;
  int allprojectCount = 0;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    print("working");
    final token = await TokenManager.getToken();
    print(token);
    String baseUrl = ApiConstants.baseUrl;
    var myProjectcountres = await http.get(
      Uri.parse('$baseUrl/workspace/secworkspaceuser/count_myproject'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type':
            'application/json', // You may need to adjust the content type as needed
      },
    );
    var sharedWithMeCountres = await http.get(
      Uri.parse('$baseUrl/workspace/secworkspaceuser/count_sharedwithme'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type':
            'application/json', // You may need to adjust the content type as needed
      },
    );
    var allProjectsCountres = await http.get(
      Uri.parse('$baseUrl/workspace/secworkspaceuser/count_allproject'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type':
            'application/json', // You may need to adjust the content type as needed
      },
    );
    if (myProjectcountres.statusCode == 401) {
      LogoutService.logout();
    }
    print(myProjectcountres.statusCode);
    if (myProjectcountres.statusCode <= 209 &&
        sharedWithMeCountres.statusCode <= 209) {
      final myProjectData = jsonDecode(myProjectcountres.body);
      final sharedData = jsonDecode(sharedWithMeCountres.body);
      final allData = jsonDecode(allProjectsCountres.body);
      setState(() {
        myProjectcount = myProjectData;
        sharedWithMeCount = sharedData;
        allprojectCount = allData;
      });
    } else {
      // Handle errors
      print('Failed to fetch data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => ProjectListScreen(
                //         userData: widget.userData,
                //         type: "myproject"), // Get all projects
                //   ),
                // );
              },
              child: Card(
                color: Colors.white,
                elevation: 0.0,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Column(
                    children: [
                      Container(
                        height: getSize(
                          55,
                        ),
                        width: getSize(
                          55,
                        ),
                        margin: getMargin(
                          top: 2,
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Container(
                                height: getSize(
                                  55,
                                ),
                                width: getSize(
                                  55,
                                ),
                                child: CircularProgressIndicator(
                                  value: 0.5,
                                  backgroundColor: ColorConstant.gray30099,
                                  color: ColorConstant.blueA700,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                myProjectcount.toString(),
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                                style: AppStyle.txtGilroyBold18,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Text(
                      //   myProjectcount.toString(),
                      //   style: const TextStyle(
                      //     color: Colors.black,
                      //     fontSize: 12,
                      //   ),
                      // ),
                      const SizedBox(
                        height: 3,
                      ),
                      const Text(
                        'My Projects',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => ProjectListScreen(
                //         userData: widget.userData,
                //         type: "sharedproject"), // Get all projects
                //   ),
                // );
              },
              child: Card(
                color: Colors.white,
                elevation: 0.0,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Column(
                    children: [
                      Container(
                        height: getSize(
                          55,
                        ),
                        width: getSize(
                          55,
                        ),
                        margin: getMargin(
                          top: 2,
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Container(
                                height: getSize(
                                  55,
                                ),
                                width: getSize(
                                  55,
                                ),
                                child: CircularProgressIndicator(
                                  value: 0.5,
                                  backgroundColor: ColorConstant.gray30099,
                                  color: ColorConstant.blueA700,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                sharedWithMeCount.toString(),
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                                style: AppStyle.txtGilroyBold18,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Text(
                      //   myProjectcount.toString(),
                      //   style: const TextStyle(
                      //     color: Colors.black,
                      //     fontSize: 12,
                      //   ),
                      // ),
                      const SizedBox(
                        height: 3,
                      ),
                      const Text(
                        'Shared with me',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => ProjectListScreen(
                //         userData: widget.userData,
                //         type: "allproject"), // Get all projects
                //   ),
                // );
              },
              child: Card(
                color: Colors.white,
                elevation: 0.0,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Column(
                    children: [
                      Container(
                        height: getSize(
                          55,
                        ),
                        width: getSize(
                          55,
                        ),
                        margin: getMargin(
                          top: 2,
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Container(
                                height: getSize(
                                  55,
                                ),
                                width: getSize(
                                  55,
                                ),
                                child: CircularProgressIndicator(
                                  value: 0.5,
                                  backgroundColor: ColorConstant.gray30099,
                                  color: ColorConstant.blueA700,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                allprojectCount.toString(),
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                                style: AppStyle.txtGilroyBold18,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Text(
                      //   myProjectcount.toString(),
                      //   style: const TextStyle(
                      //     color: Colors.black,
                      //     fontSize: 12,
                      //   ),
                      // ),
                      const SizedBox(
                        height: 3,
                      ),
                      const Text(
                        'All Projects',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}