// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';

import '/providers/token_manager.dart';
import 'package:flutter/services.dart';

import 'Dashboard_api_service.dart';

class CreateEntityScreen extends StatefulWidget {
  const CreateEntityScreen({super.key});

  @override
  _CreateEntityScreenState createState() => _CreateEntityScreenState();
}

class _CreateEntityScreenState extends State<CreateEntityScreen> {
  final DashboardBuilderApiService apiService = DashboardBuilderApiService();
  final Map<String, dynamic> formData = {};
  final _formKey = GlobalKey<FormState>();

  bool isisdashboard = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Dashboard')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: 'name'),
                  onSaved: (value) => formData['name'] = value,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'model'),
                  onSaved: (value) => formData['model'] = value,
                ),
                const SizedBox(height: 16),
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
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 5), // Add margin
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();

                        formData['isdashboard'] = isisdashboard;

                        final token = await TokenManager.getToken();
                        try {
                          print("token is : $token");
                          print(formData);

                          await apiService.createEntity(token!, formData);

                          Navigator.pop(context);
                        } catch (e) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Error'),
                                content: Text('Failed to create entity: $e'),
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
                    child: const SizedBox(
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
