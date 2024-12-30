import 'package:cricyard/data/network/network_api_service.dart';
import 'package:flutter/material.dart';

import '../../../../Utils/image_constant.dart';
import '../../../../Utils/size_utils.dart';
import '../../../../providers/token_manager.dart';
import '../../../../theme/app_style.dart';
import '../../../widgets/app_bar/appbar_image.dart';
import '../../../widgets/app_bar/appbar_title.dart';
import '../../../widgets/app_bar/custom_app_bar.dart';

import '../../../widgets/custom_dropdown_field.dart';
import '../../../widgets/custom_text_form_field.dart';
import '../../Login Screen/view/CustomButton.dart';
import '../viewmodel/dynamic_form_service.dart';

class CreateForm extends StatefulWidget {
  @override
  _CreateFormState createState() => _CreateFormState();
}

class _CreateFormState extends State<CreateForm> {
  TextEditingController formNameController = TextEditingController();
  TextEditingController formDescController = TextEditingController();
  TextEditingController relatedToController = TextEditingController();
  TextEditingController pageEventController = TextEditingController();
  TextEditingController buttonCaptionController = TextEditingController();

  final DynamicFormApiService apiService = DynamicFormApiService(NetworkApiService());

  List<Map<String, dynamic>> components = [];

  List<dynamic> relatedToFixedDropdown = ['Menu', 'Related To',];
  List<dynamic> pageEventFixedDropdown = ['OnClick', 'OnBlur',];

  List<dynamic> typeFixedDropdown = ['text', 'dropdown','date','checkbox','textarea','togglebutton'];
  List<dynamic> mappingFixedDropdown = ['TEXTFIELD1', 'TEXTFIELD2','TEXTFIELD3','TEXTFIELD4','TEXTFIELD5','TEXTFIELD6','TEXTFIELD7','TEXTFIELD8','TEXTFIELD9','TEXTFIELD10','TEXTFIELD11','TEXTFIELD12','TEXTFIELD13','TEXTFIELD14','TEXTFIELD15','TEXTFIELD16','TEXTFIELD17','TEXTFIELD18','TEXTFIELD19','TEXTFIELD20','TEXTFIELD21','TEXTFIELD22','TEXTFIELD23',
    'TEXTFIELD24','TEXTFIELD25','TEXTFIELD26','LONGTEXT1','LONGTEXT2','LONGTEXT3','LONGTEXT4',];
  List<dynamic> truefalseFixedDropdown = ['true', 'false',];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          height: getVerticalSize(49),
          leadingWidth: 40,
          leading: AppbarImage(
              height: getSize(24),
              width: getSize(24),
              svgPath: ImageConstant.imgArrowleft,
              margin: getMargin(left: 16, top: 12, bottom: 13),
              onTap: () {
                Navigator.pop(context);
              }),
          centerTitle: true,
          title: AppbarTitle(text: "Create Dynamic Form"),),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Padding(
                  padding: getPadding(top: 19),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Form Name",
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style:  TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w700)),
                        CustomTextFormField(
                            focusNode: FocusNode(),
                            hintText: "Enter Form Name",
                            controller: formNameController,
                            margin: getMargin(top: 6))
                      ])),
              Padding(
                  padding: getPadding(top: 19),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Form Description",
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style:  TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w700)),
                        CustomTextFormField(
                            focusNode: FocusNode(),
                            hintText: "Enter Form Description",
                            controller: formDescController,
                            margin: getMargin(top: 6))
                      ])),

              Padding(
                padding: getPadding(top: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Select Related To",
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style:  TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                    CustomDropdownFormField(
                      items: [
                        ...relatedToFixedDropdown.map<DropdownMenuItem<String>>(
                              (item) {
                            return DropdownMenuItem<String>(
                              value: item.toString(),
                              child: Text(item, style: AppStyle.txtGilroyMedium16Bluegray900),
                            );
                          },
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          relatedToController.text = value!;
                        });
                      },
                    )
                  ],
                ),
              ),

              Padding(
                padding: getPadding(top: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Select Page Event",
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style:  TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                    CustomDropdownFormField(
                      items: [
                        ...pageEventFixedDropdown.map<DropdownMenuItem<String>>(
                              (item) {
                            return DropdownMenuItem<String>(
                              value: item.toString(),
                              child: Text(item,style: AppStyle.txtGilroyMedium16Bluegray900),
                            );
                          },
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          pageEventController.text = value!;
                        });
                      },
                    )
                  ],
                ),
              ),
              Padding(
                  padding: getPadding(top: 19),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Button Caption",
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style:  TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w700)),
                        CustomTextFormField(
                            focusNode: FocusNode(),
                            hintText: "Enter Button Caption",
                            controller: buttonCaptionController,
                            margin: getMargin(top: 6))
                      ])),
              const Text('Components Details'),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: const <DataColumn>[
                    DataColumn(label: Text('Label')),
                    DataColumn(label: Text('Type')),
                    DataColumn(label: Text('Mapping')),
                    DataColumn(label: Text('Mandatory')),
                    DataColumn(label: Text('Readonly')),
                    DataColumn(label: Text('Drop Values')),
                    DataColumn(label: Text('SP')),
                  ],
                  rows: components.asMap().entries.map((entry) {
                    final index = entry.key;
                    final component = entry.value;
                    bool? isReadonly =  false;
                    return DataRow(
                      cells: <DataCell>[
                        DataCell(TextField(
                          controller: TextEditingController(text: component['label'] ?? ''),
                          onChanged: (value) {
                            component['label'] = value;
                          },
                        )),
                        DataCell(
                    DropdownButtonFormField<String>(
                    decoration:
                    const InputDecoration(labelText: 'Select Type'),
                    items: [
                    ...typeFixedDropdown.map<DropdownMenuItem<String>>(
                    (item) {
                    return DropdownMenuItem<String>(
                    value: item.toString(),
                    child: Text(item,style: AppStyle.txtGilroyMedium16Bluegray900),
                    );
                    },
                    ),
                    ],
                    onChanged: (value) {
                    setState(() {
                      component['type'] = value;
                    });
                    },
                    ),

                        ),
                        DataCell(
                          DropdownButtonFormField<String>(
                            decoration:
                            const InputDecoration(labelText: 'Select Mapping'),
                            items: [
                              ...mappingFixedDropdown.map<DropdownMenuItem<String>>(
                                    (item) {
                                  return DropdownMenuItem<String>(
                                    value: item.toString(),
                                    child: Text(item,style: AppStyle.txtGilroyMedium16Bluegray900),
                                  );
                                },
                              ),
                            ],
                            onChanged: (value) {
                              setState(() {
                                component['mapping'] = value;
                              });
                            },
                          ),

                        ),
                        DataCell(TextField(
                          controller: TextEditingController(text: component['mandatory'] ?? ''),
                          onChanged: (value) {
                            component['mandatory'] = value;
                          },
                        )),
                        DataCell(
                          DropdownButtonFormField<String>(
                            decoration:
                            const InputDecoration(labelText: 'Select Read Only'),
                            items: [
                              ...truefalseFixedDropdown.map<DropdownMenuItem<String>>(
                                    (item) {
                                  return DropdownMenuItem<String>(
                                    value: item.toString(),
                                    child: Text(item,style: AppStyle.txtGilroyMedium16Bluegray900),
                                  );
                                },
                              ),
                            ],
                            onChanged: (value) {
                              setState(() {
                                component['readonly'] = value;
                              });
                            },
                          ),

                        ),
                        DataCell(TextField(
                          controller: TextEditingController(text: component['drop_values'] ?? ''),
                          onChanged: (value) {
                            component['drop_values'] = value;
                          },
                        )),
                        DataCell(TextField(
                          controller: TextEditingController(text: component['sp'] ?? ''),
                          onChanged: (value) {
                            component['sp'] = value;
                          },
                        )),
                      ],
                    );
                  }).toList(),
                ),
              ),
              CustomButton(
                height: getVerticalSize(50),
                text: "Add Row",
                
                onTap: () async {
                  components.add({
                    'label': '',
                    'type': '',
                    'mapping': '',
                    'mandatory': '',
                    'readonly': '',
                    'drop_values': '',
                    'sp': '',
                  });
                  setState(() {});
                },
              ),

              CustomButton(
                height: getVerticalSize(50),
                text: "Create Dynamic Form",
               
                onTap: () async {
                  final dynamicFormData = {
                    'form_name': formNameController.text,
                    'form_desc': formDescController.text,
                    'related_to': relatedToController.text,
                    'page_event': pageEventController.text,
                    'button_caption': buttonCaptionController.text,
                    'components': components,
                  };
                  final token = await TokenManager.getToken();
                  apiService.createDynamicForm(dynamicFormData);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}