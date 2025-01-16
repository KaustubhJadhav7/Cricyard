import 'package:cricyard/data/network/network_api_service.dart';
import 'package:cricyard/views/screens/Bookmarks/model/Bookmarks_model.dart';
import 'package:cricyard/views/screens/Bookmarks/viewmodels/Bookmarks_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class CreateEntityScreen extends StatefulWidget {
  const CreateEntityScreen({super.key});

  @override
  _CreateEntityScreenState createState() => _CreateEntityScreenState();
}

class _CreateEntityScreenState extends State<CreateEntityScreen> {
  // final Map<String, dynamic> formData = {};
  late BookmarkEntity formData;
  final _formKey = GlobalKey<FormState>();
  var selectedFileupload_Field;
  @override
  void initState() {
    super.initState();
    formData = BookmarkEntity(id: 0, active: false);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BookmarksProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(title: const Text('Create Bookmarks')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration:
                      const InputDecoration(labelText: 'bookmark_firstletter'),
                  onSaved: (value) =>  formData.title= value,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'bookmark_link'),
                  onSaved: (value) => formData.url = value,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration:
                      const InputDecoration(labelText: 'fileupload_field'),
                  onSaved: (value) => formData.description = value,
                ),
                const SizedBox(height: 16),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 5), // Add margin
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                          print(formData);
                          await provider.createEntity(context,formData, selectedFileupload_Field);
                          Navigator.pop(context);
                        
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      child: const Center(
                        child: Text(
                          'SUBMIT',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
