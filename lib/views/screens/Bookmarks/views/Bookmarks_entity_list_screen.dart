import 'package:cricyard/data/network/network_api_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '/providers/token_manager.dart';
import '../../../../Utils/image_constant.dart';
import '../../../../Utils/size_utils.dart';
import '../../../../theme/app_decoration.dart';
import '../../../../theme/app_style.dart';
import '../../../widgets/app_bar/appbar_image.dart';
import '../../../widgets/app_bar/appbar_title.dart';
import '../../../widgets/app_bar/custom_app_bar.dart';
import '../model/Bookmarks_api_service.dart';
import 'package:url_launcher/url_launcher.dart';

class bookmarks_entity_list_screen extends StatefulWidget {
  static const String routeName = '/entity-list';

  @override
  _bookmarks_entity_list_screenState createState() =>
      _bookmarks_entity_list_screenState();
}

class _bookmarks_entity_list_screenState
    extends State<bookmarks_entity_list_screen> {
  final ApiService apiService = ApiService(NetworkApiService());
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
        final fetchedEntities = await apiService.getEntities();
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
      await apiService.deleteEntity(entity['id']);
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
            centerTitle: true,
            title: AppbarTitle(text: "Bookmarks")),
        body: entities.isEmpty
            ? const Center(
                child: Text('No BookMarks found.'),
              )
            : Container(
                width: double.maxFinite,
                padding: getPadding(left: 16, top: 16, right: 16, bottom: 16),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: getPadding(top: 22),
                        child: entities.length != 0
                            ? ListView.separated(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                separatorBuilder: (context, index) {
                                  return SizedBox(height: getVerticalSize(24));
                                },
                                itemCount: entities.length,
                                itemBuilder: (context, index) {
                                  Map<String, dynamic> entity = entities[index];
                                  return Container(
                                    width: double.maxFinite,
                                    child: Container(
                                      padding: getPadding(
                                        left: 16,
                                        top: 5,
                                        right: 5,
                                        bottom: 17,
                                      ),
                                      decoration: AppDecoration.outlineGray70011
                                          .copyWith(
                                              borderRadius: BorderRadiusStyle
                                                  .roundedBorder6,
                                              color: Colors.grey[100]),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: getPadding(
                                                //right: 13,
                                                ),
                                            child: Row(
                                              children: [
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.30,
                                                  // getHorizontalSize(
                                                  //   147,
                                                  // ),
                                                  margin: getMargin(
                                                    left: 8,
                                                    top: 3,
                                                    bottom: 1,
                                                  ),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        entity['bookmark_firstletter'] ??
                                                            'No bookmark_firstletter provided',
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: AppStyle
                                                            .txtGreenSemiBold16,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Spacer(),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: getPadding(
                                              top: 10,
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'BookMark Link',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.left,
                                                  style: AppStyle
                                                      .txtGilroyMedium16Bluegray800,
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    _launchURL(entity[
                                                        'bookmark_link']);
                                                  },
                                                  child: Text(
                                                    entity['bookmark_link'] ??
                                                        'No bookmark_link provided',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    textAlign: TextAlign.left,
                                                    style: AppStyle
                                                        .txtGilroyMedium16Green600,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                })
                            : Container(
                                height: MediaQuery.of(context).size.height,
                                child: const Center(
                                  child: Text("No Databases available"),
                                )),
                      )
                    ])));
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

  Widget _buildNormalView(Map<String, dynamic> entity) {
    return ListTile(
      title: Text(entity['id'].toString()),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(entity['bookmark_firstletter'] ??
              'No bookmark_firstletter provided'),
          const SizedBox(height: 4),
          GestureDetector(
            onTap: () {
              _launchURL(entity['bookmark_link']);
            },
            child: Text(
              entity['bookmark_link'] ?? 'No bookmark_link provided',
              style: TextStyle(
                color:
                    Colors.blue, // Change the color to make it look like a link
                decoration: TextDecoration.underline, // Underline the link
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(entity['fileupload_field'] ?? 'No fileupload_field provided'),
          const SizedBox(height: 4),
          // Added address text
        ],
      ),
      // trailing: _buildPopupMenu(entity),
      // onTap: () {
      //   _showAdditionalFieldsDialog(context, entity);
      // },
    );
  }

// Function to launch a URL in the browser
  Future<void> _launchURL(String? url) async {
    if (url != null) {
      try {
        if (await canLaunch(url)) {
          await launch(url);
        } else {
          throw 'Could not launch $url';
        }
      } catch (e) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error'),
              content: Text('Failed to launch URL: $e'),
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
