// ignore_for_file: use_build_context_synchronously

import 'package:cricyard/data/network/network_api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../../../../Utils/color_constants.dart';
import '../../../../Utils/image_constant.dart';
import '../../../../Utils/size_utils.dart';
import '../../../../providers/token_manager.dart';
import '../../../widgets/app_bar/appbar_image.dart';
import '../../../widgets/app_bar/appbar_title.dart';
import '../../../widgets/app_bar/custom_app_bar.dart';
import 'UpdatedynamicForm.dart';
import 'create_dynamicform.dart';
import '../repository/dynamic_form_service.dart';

class DynamicForm extends StatefulWidget {
  @override
  _DynamicFormState createState() => _DynamicFormState();
}

class _DynamicFormState extends State<DynamicForm> {
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
              : Scrollable(
                  viewportBuilder:
                      (BuildContext context, ViewportOffset position) {
                    return SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          columns: [
                            DataColumn(label: Text('Form Name')),
                            DataColumn(label: Text('Form Description')),
                            DataColumn(label: Text('Related To')),
                            DataColumn(label: Text('Page Event')),
                            DataColumn(label: Text('Button Caption')),
                            DataColumn(label: Text('Build')),
                            DataColumn(label: Text('Actions')),
                          ],
                          rows: allData.map((module) {
                            return DataRow(
                              cells: [
                                DataCell(
                                    Text('${module['form_name'] ?? 'N/A'}')),
                                DataCell(
                                    Text('${module['form_desc'] ?? 'N/A'}')),
                                DataCell(
                                    Text('${module['related_to'] ?? 'N/A'}')),
                                DataCell(
                                    Text('${module['page_event'] ?? 'N/A'}')),
                                DataCell(Text(
                                    '${module['button_caption'] ?? 'N/A'}')),
                                DataCell(Row(
                                  children: [
                                    ElevatedButton(
                                      onPressed: () async {
                                        print(module);
                                        final token =
                                            await TokenManager.getToken();
                                        apiService.buildForms(
                                            // token!, 
                                            module['form_id'], context);
                                      },
                                      child: Text("build"),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: ColorConstant.blue700,
                                      ),
                                    )
                                  ],
                                )),
                                DataCell(Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                EditForm(formData: module),
                                          ),
                                        ).then(
                                            (value) => {_loadDynamicForms()});
                                      },
                                      icon: Icon(Icons.edit),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: const Text(
                                                  'Confirm Deletion'),
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
                                                    deleteEntity(module);
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      icon: Icon(Icons.delete),
                                    ),
                                  ],
                                )),
                              ],
                            );
                          }).toList(),
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
