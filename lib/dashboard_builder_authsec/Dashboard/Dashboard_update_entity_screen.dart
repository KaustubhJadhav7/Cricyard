// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import '/providers/token_manager.dart';
import 'package:flutter/services.dart';

import 'Dashboard_api_service.dart';

class UpdateEntityScreen extends StatefulWidget {
  final Map<String, dynamic> entity;

  UpdateEntityScreen({required this.entity});

  @override
  _UpdateEntityScreenState createState() => _UpdateEntityScreenState();
}

class _UpdateEntityScreenState extends State<UpdateEntityScreen> {
  final DashboardBuilderApiService apiService = DashboardBuilderApiService();
  final _formKey = GlobalKey<FormState>();

  bool isisdashboard = false;

  @override
  void initState() {
    super.initState();

    isisdashboard = widget.entity['isdashboard'] ?? false; // Set initial value
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Update Dashboard')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  initialValue: widget.entity['name'],
                  decoration: const InputDecoration(labelText: 'name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a name';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    widget.entity['name'] = value;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  initialValue: widget.entity['model'],
                  decoration: const InputDecoration(labelText: 'model'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a model';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    widget.entity['model'] = value;
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Switch(
                      value: isisdashboard,
                      onChanged: (newValue) {
                        setState(() {
                          isisdashboard = newValue;
                        });
                      },
                    ),
                    const SizedBox(width: 8),
                    const Text('isdashboard'),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 5), // Add margin
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();

                        widget.entity['isdashboard'] = isisdashboard;

                        final token = await TokenManager.getToken();
                        try {
                          await apiService.updateEntity(
                              token!,
                              widget.entity[
                                  'id'], // Assuming 'id' is the key in your entity map
                              widget.entity);
                          Navigator.pop(context);
                        } catch (e) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Error'),
                                content: Text('Failed to update entity: $e'),
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
