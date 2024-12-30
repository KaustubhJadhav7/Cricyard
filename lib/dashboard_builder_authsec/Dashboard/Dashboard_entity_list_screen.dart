import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '/providers/token_manager.dart';
import 'Dashboard_api_service.dart';
import 'Dashboard_create_entity_screen.dart';
import 'Dashboard_update_entity_screen.dart';

class dashboard_entity_list_screen extends StatefulWidget {
  static const String routeName = '/entity-list';

  @override
  _dashboard_entity_list_screenState createState() =>
      _dashboard_entity_list_screenState();
}

class _dashboard_entity_list_screenState
    extends State<dashboard_entity_list_screen> {
  final DashboardBuilderApiService apiService = DashboardBuilderApiService();
  List<Map<String, dynamic>> entities = [];
  bool showCardView = true; // Add this variable to control the view mode

  @override
  void initState() {
    super.initState();
    fetchEntities();
  }

  Future<void> fetchEntities() async {
    try {
      final token = await TokenManager.getToken();

      if (token != null) {
        final fetchedEntities = await apiService.getEntities(token);
        setState(() {
          entities = fetchedEntities;
        });
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text('Failed to fetch entities: $e'),
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

  Future<void> deleteEntity(Map<String, dynamic> entity) async {
    try {
      final token = await TokenManager.getToken();
      await apiService.deleteEntity(token!, entity['id']);
      setState(() {
        entities.remove(entity);
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
      appBar: AppBar(
        title: const Text('Dashboard List'),
        actions: [
          // Add a switch in the app bar to toggle between card view and normal view
          Switch(
            activeColor: Colors.greenAccent,
            inactiveThumbColor: Colors.white,
            value: showCardView,
            onChanged: (value) {
              setState(() {
                showCardView = value;
              });
            },
          ),
        ],
      ),
      body: entities.isEmpty
          ? const Center(
              child: Text('No entities found.'),
            )
          : ListView.builder(
              itemCount: entities.length,
              itemBuilder: (BuildContext context, int index) {
                final entity = entities[index];
                return _buildListItem(entity);
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CreateEntityScreen(),
            ),
          ).then((_) {
            fetchEntities();
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  // Function to build list items
  Widget _buildListItem(Map<String, dynamic> entity) {
    return showCardView ? _buildCardView(entity) : _buildNormalView(entity);
  }

  // Function to build card view for a list item
  Widget _buildCardView(Map<String, dynamic> entity) {
    return Card(
        elevation: 2,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: _buildNormalView(entity));
  }

  // Function to build normal view for a list item
  Widget _buildNormalView(Map<String, dynamic> entity) {
    return ListTile(
      title: Text(entity['id'].toString()),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(entity['name'] ?? 'No name provided'),
          const SizedBox(height: 4),

          Text(entity['model'] ?? 'No model provided'),
          const SizedBox(height: 4),

          Text(entity['isdashboard'] ?? 'No isdashboard provided'),
          const SizedBox(height: 4),

          // Added address text
        ],
      ),
      trailing: _buildPopupMenu(entity),
    );
  }

  // Function to build popup menu for a list item
  Widget _buildPopupMenu(Map<String, dynamic> entity) {
    return PopupMenuButton<String>(
      itemBuilder: (BuildContext context) {
        return [
          const PopupMenuItem<String>(
            value: 'edit',
            child: Row(
              children: [
                Icon(Icons.edit),
                SizedBox(width: 8),
                Text('Edit'),
              ],
            ),
          ),
          const PopupMenuItem<String>(
            value: 'delete',
            child: Row(
              children: [
                Icon(Icons.delete),
                SizedBox(width: 8),
                Text('Delete'),
              ],
            ),
          ),
          const PopupMenuItem<String>(
            value: 'WHO',
            child: Row(
              children: [
                Icon(Icons.manage_accounts_outlined),
                SizedBox(width: 8),
                Text('WHO'),
              ],
            ),
          ),
        ];
      },
      onSelected: (String value) {
        if (value == 'edit') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UpdateEntityScreen(entity: entity),
            ),
          ).then((_) {
            fetchEntities();
          });
        } else if (value == 'delete') {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Confirm Deletion'),
                content:
                    const Text('Are you sure you want to delete this entity?'),
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
                      deleteEntity(entity);
                    },
                  ),
                ],
              );
            },
          );
        } else if (value == 'WHO') {
          _showAdditionalFieldsDialog(context, entity);
        }
      },
    );
  }

  // Function to show additional fields in a dialog
  void _showAdditionalFieldsDialog(
    BuildContext context,
    Map<String, dynamic> entity,
  ) {
    final dateFormat =
        DateFormat('yyyy-MM-dd HH:mm:ss'); // Define your desired date format

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Additional Fields'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                  'Created At: ${_formatTimestamp(entity['createdAt'], dateFormat)}'),
              Text('Created By: ${entity['createdBy'] ?? 'N/A'}'),
              Text('Updated By: ${entity['updatedBy'] ?? 'N/A'}'),
              Text(
                  'Updated At: ${_formatTimestamp(entity['updatedAt'], dateFormat)}'),
              Text('Account ID: ${entity['accountId'] ?? 'N/A'}'),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  String _formatTimestamp(dynamic timestamp, DateFormat dateFormat) {
    if (timestamp is int) {
      // If it's an integer, assume it's a Unix timestamp in milliseconds
      final DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
      return dateFormat.format(dateTime);
    } else if (timestamp is String) {
      // If it's a string, assume it's already formatted as a date
      return timestamp;
    } else {
      // Handle other cases here if needed
      return 'N/A';
    }
  }
}
