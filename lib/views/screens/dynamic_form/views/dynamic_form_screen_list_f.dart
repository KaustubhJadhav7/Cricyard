import 'package:cricyard/data/network/network_api_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../Utils/color_constants.dart';
import '../../../../Utils/image_constant.dart';
import '../../../../Utils/size_utils.dart';
import '../../../../providers/token_manager.dart';
import '../../../widgets/app_bar/appbar_image.dart';
import '../../../widgets/app_bar/appbar_title.dart';
import '../../../widgets/app_bar/custom_app_bar.dart';
import 'UpdatedynamicForm.dart';
import 'create_dynamicform.dart';
import '../viewmodel/dynamic_form_service.dart';

class DynamicFormF extends StatefulWidget {
  const DynamicFormF({super.key});

  @override
  State<DynamicFormF> createState() => _DynamicFormFState();
}

class _DynamicFormFState extends State<DynamicFormF> {
  final DynamicFormApiService apiService = DynamicFormApiService(NetworkApiService());

  late List<Map<String, dynamic>> allData = [];

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadDynamicForms();
  }

  Future<void> _loadDynamicForms() async {
    // final token = await TokenManager.getToken();
    try {
      final alData = await apiService.getAllDynamicForms();

      setState(() {
        allData = alData;

        print('allData fetched...');
      });
      isLoading = true;
    } catch (e) {
      isLoading = true;
      print('Failed to load allData: $e');
    }
  }

  Future<void> deleteEntity(Map<String, dynamic> entity) async {
    try {
      // final token = await TokenManager.getToken();
      await apiService.deleteDynamicForm(
        // token!,
       entity['form_id']);
      setState(() {
        allData.remove(entity);
      });
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text('Failed to delete entity: $e'),
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

  Future<void> _onRefresh() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          height: getVerticalSize(49),
          leadingWidth: 40,
          leading: AppbarImage(
              height: getSize(24),
              width: getSize(24),
              svgPath: ImageConstant.imgArrowleftBlueGray900,
              margin: getMargin(left: 16, top: 12, bottom: 13),
              onTap: () {
                Navigator.pop(context);
              }),
          actions: [
            GestureDetector(
              child: Icon(
                Icons.add,
                color: Colors.black,
                size: 20,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CreateForm(),
                  ),
                ).then((value) => {_loadDynamicForms()});
              },
            ),
            const SizedBox(
              width: 20,
            )
          ],
          centerTitle: true,
          title: AppbarTitle(text: "Dynamic Form")),
      body: isLoading == false
          ? const Center(child: CircularProgressIndicator())
          : allData.isEmpty
              ? const Center(
                  child: Text('No Services available.'),
                )
              : RefreshIndicator(
                  onRefresh: _onRefresh,
                  child: ListView.builder(
                      itemCount: allData.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 2),
                          child: Row(
                            children: [
                              InkWell(
                                onLongPress: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('Confirm Deletion'),
                                        content: const Text(
                                            'Are you sure you want to delete this Module?'),
                                        actions: [
                                          TextButton(
                                            child: const Text('Cancel'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                          TextButton(
                                            child: const Text('Delete'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                              deleteEntity(allData[index]);
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: Card(
                                  margin: EdgeInsets.only(left: 8, right: 3),
                                  color: index % 2 == 0
                                      ? Color.fromARGB(255, 234, 203, 239)
                                      : Color.fromARGB(255, 198, 183, 232),
                                  child: Container(
                                    height: 100,
                                    width: MediaQuery.of(context).size.width *
                                        75 /
                                        100,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                //Text('Form Name'),

                                                Text(
                                                  allData[index]['form_name'] ??
                                                      'N/A',
                                                  style: GoogleFonts.poppins()
                                                      .copyWith(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color: ColorConstant
                                                              .purple900),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                //Text('Form Description'),
                                                Text(
                                                  allData[index]['form_desc'] ??
                                                      'N/A',
                                                  style: GoogleFonts.poppins()
                                                      .copyWith(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  'Related to - ',
                                                  style: GoogleFonts.poppins()
                                                      .copyWith(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  allData[index]
                                                          ['related_to'] ??
                                                      'N/A',
                                                  style: GoogleFonts.poppins()
                                                      .copyWith(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  'Page event- ',
                                                  style: GoogleFonts.poppins()
                                                      .copyWith(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  allData[index]
                                                          ['page_event'] ??
                                                      'N/A',
                                                  style: GoogleFonts.poppins()
                                                      .copyWith(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      EditForm(
                                                          formData:
                                                              allData[index]),
                                                ),
                                              ).then((value) =>
                                                  {_loadDynamicForms()});
                                            },
                                            icon: Icon(Icons.edit))
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () async {
                                  print(allData[index]);
                                  final token = await TokenManager.getToken();
                                  apiService.buildForms(
                                    // token!,
                                      allData[index]['form_id'], context);
                                },
                                child: Card(
                                  color: index % 2 == 0
                                      ? Color.fromARGB(255, 234, 203, 239)
                                      : Color.fromARGB(255, 198, 183, 232),
                                  child: Container(
                                    height: 100,
                                    width: MediaQuery.of(context).size.width *
                                        19 /
                                        100,
                                    child: GestureDetector(
                                      child: Center(
                                          child: Text(
                                        'Build',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.poppins().copyWith(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600),
                                      )),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      }),
                ),
    );
  }
}
