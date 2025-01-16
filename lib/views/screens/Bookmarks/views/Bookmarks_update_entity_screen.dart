import 'package:cricyard/data/network/network_api_service.dart';
import 'package:cricyard/views/screens/Bookmarks/model/Bookmarks_model.dart';
import 'package:cricyard/views/screens/Bookmarks/viewmodels/Bookmarks_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

class UpdateEntityScreen extends StatefulWidget {
  final BookmarkEntity entity;

  UpdateEntityScreen({required this.entity});

  @override
  _UpdateEntityScreenState createState() => _UpdateEntityScreenState();
}

class _UpdateEntityScreenState extends State<UpdateEntityScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BookmarksProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(title: const Text('Update Bookmarks')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  initialValue: widget.entity.id.toString(),
                  decoration:
                      const InputDecoration(labelText: 'bookmark_firstletter'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a bookmark_firstletter';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    widget.entity.title = value;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  initialValue: widget.entity.url,
                  decoration: const InputDecoration(labelText: 'bookmark_link'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a bookmark_link';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    widget.entity.url = value;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  initialValue: widget.entity.description,
                  decoration:
                      const InputDecoration(labelText: 'fileupload_field'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a fileupload_field';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    widget.entity.description = value;
                  },
                ),
                const SizedBox(height: 16),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 5), // Add margin
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                          await provider.updateEntity(
                            context,
                            widget.entity,
                          );
                          Navigator.pop(context);
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      child: const Center(
                        child: Text(
                          'UPDATE',
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
