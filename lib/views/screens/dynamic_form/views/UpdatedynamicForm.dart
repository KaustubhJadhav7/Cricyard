import 'package:cricyard/data/network/network_api_service.dart';
import 'package:flutter/material.dart';

import '../../../../providers/token_manager.dart';
import '../viewmodel/dynamic_form_service.dart';

class EditForm extends StatefulWidget {
  final Map<String, dynamic> formData;

  EditForm({required this.formData});

  @override
  _EditFormState createState() => _EditFormState();
}

class _EditFormState extends State<EditForm> {
  TextEditingController formNameController = TextEditingController();
  TextEditingController formDescController = TextEditingController();
  TextEditingController relatedToController = TextEditingController();
  TextEditingController pageEventController = TextEditingController();
  TextEditingController buttonCaptionController = TextEditingController();

  final DynamicFormApiService apiService = DynamicFormApiService(NetworkApiService());

  List<dynamic> components = []; // List to store table data
  List<dynamic> relatedToFixedDropdown = ['Menu', 'Related To',];
  List<dynamic> pageEventFixedDropdown = ['OnClick', 'OnBlur',];

  List<dynamic> typeFixedDropdown = ['text', 'dropdown','date','checkbox','textarea','togglebutton'];
  List<dynamic> mappingFixedDropdown = ['TEXTFIELD1', 'TEXTFIELD2','TEXTFIELD3','TEXTFIELD4','TEXTFIELD5','TEXTFIELD6','TEXTFIELD7','TEXTFIELD8','TEXTFIELD9','TEXTFIELD10','TEXTFIELD11','TEXTFIELD12','TEXTFIELD13','TEXTFIELD14','TEXTFIELD15','TEXTFIELD16','TEXTFIELD17','TEXTFIELD18','TEXTFIELD19','TEXTFIELD20','TEXTFIELD21','TEXTFIELD22','TEXTFIELD23',
    'TEXTFIELD24','TEXTFIELD25','TEXTFIELD26','LONGTEXT1','LONGTEXT2','LONGTEXT3','LONGTEXT4',];
  List<dynamic> truefalseFixedDropdown = ['true', 'false',];

  @override
  void initState() {
    super.initState();
    // Initialize text controllers with the data from the selected row
    formNameController.text = widget.formData['form_name'] ?? '';
    formDescController.text = widget.formData['form_desc'] ?? '';
    relatedToController.text = widget.formData['related_to'] ?? '';
    pageEventController.text = widget.formData['page_event'] ?? '';
    buttonCaptionController.text = widget.formData['button_caption'] ?? '';

    // Initialize the components data, or you can load it from formData['components'].
    // For this example, we'll use an empty list.
    components = widget.formData['components'] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Form'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                controller: formNameController,
                decoration: InputDecoration(labelText: 'Form Name'),
              ),
              TextFormField(
                controller: formDescController,
                decoration: InputDecoration(labelText: 'Form Description'),
              ),
              DropdownButtonFormField<String>(
                value: relatedToController.text,
                decoration:
                const InputDecoration(labelText: 'Select Related To'),
                items: [
                  ...relatedToFixedDropdown.map<DropdownMenuItem<String>>(
                        (item) {
                      return DropdownMenuItem<String>(
                        value: item.toString(),
                        child: Text(item),
                      );
                    },
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    relatedToController.text = value!;
                  });
                },
              ),
              DropdownButtonFormField<String>(
                value: pageEventController.text,
                decoration:
                const InputDecoration(labelText: 'Select Page Event'),
                items: [
                  ...pageEventFixedDropdown.map<DropdownMenuItem<String>>(
                        (item) {
                      return DropdownMenuItem<String>(
                        value: item.toString(),
                        child: Text(item),
                      );
                    },
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    pageEventController.text = value!;
                  });
                },
              ),
              TextFormField(
                controller: buttonCaptionController,
                decoration: InputDecoration(labelText: 'Button Caption'),
              ),

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
                    DataColumn(label: Text('Actions'), numeric: false), // Add Actions column
                  ],
                  rows: components.asMap().entries.map((entry) {
                    final index = entry.key;
                    final component = entry.value;

                    return DataRow(
                      cells: <DataCell>[
                        DataCell(TextField(
                          controller: TextEditingController(text: component['label'] ?? ''),
                          onChanged: (value){
                            component['label']=value;
                          },
                        )),
                        DataCell(
                          DropdownButtonFormField<String>(
                            value: component['type'],
                            decoration:
                            const InputDecoration(labelText: 'Select Type'),
                            items: [
                              ...typeFixedDropdown.map<DropdownMenuItem<String>>(
                                    (item) {
                                  return DropdownMenuItem<String>(
                                    value: item.toString(),
                                    child: Text(item),
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
                            value: component['mapping'],
                            decoration:
                            const InputDecoration(labelText: 'Select Mapping'),
                            items: [
                              ...mappingFixedDropdown.map<DropdownMenuItem<String>>(
                                    (item) {
                                  return DropdownMenuItem<String>(
                                    value: item.toString(),
                                    child: Text(item),
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
                          onChanged: (value){
                            component['mandatory']=value;
                          },
                        )),
                        DataCell(
                          DropdownButtonFormField<String>(
                            value: component['readonly'],
                            decoration:
                            const InputDecoration(labelText: 'Select Read Only'),
                            items: [
                              ...truefalseFixedDropdown.map<DropdownMenuItem<String>>(
                                    (item) {
                                  return DropdownMenuItem<String>(
                                    value: item.toString(),
                                    child: Text(item),
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
                          onChanged: (value){
                            component['drop_values']=value;
                          },
                        )),
                        DataCell(TextField(
                          controller: TextEditingController(text: component['sp'] ?? ''),
                          onChanged: (value){
                            component['sp']=value;
                          },
                        )),
                        DataCell(
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                components.removeAt(index);
                              });
                            },
                            child: Text('Delete'),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // Add a new row to the components table
                  components.add({
                    'label': '',
                    'type': null,
                    'mapping': null,
                    'mandatory': '',
                    'readonly': null,
                    'drop_values': '',
                    'sp': '',
                  });
                  setState(() {}); // Refresh the UI to show the new row
                },
                child: Text('Add Row'),
              ),

              ElevatedButton(
                onPressed: () async {
                  // Save the updated data back to the original data list
                  widget.formData['form_name'] = formNameController.text;
                  widget.formData['form_desc'] = formDescController.text;
                  widget.formData['related_to'] = relatedToController.text;
                  widget.formData['page_event'] = pageEventController.text;
                  widget.formData['button_caption'] = buttonCaptionController.text;
                  widget.formData['components'] = components;
                  // final token = await TokenManager.getToken();
                  apiService.updateDynamicForm(
                    // token!,
                   widget.formData['form_id'], widget.formData);
                  Navigator.of(context).pop();
                },
                child: Text('Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


