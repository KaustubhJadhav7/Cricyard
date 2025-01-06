// ignore_for_file: use_build_context_synchronously
import 'package:cricyard/Entity/feedback_form/FeedBack_Form/viewmodel/FeedBack_Form_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../repository/FeedBack_Form_api_service.dart';
import 'FeedBack_Form_create_entity_screen.dart';
import 'FeedBack_Form_update_entity_screen.dart';
import '/providers/token_manager.dart';
import 'package:flutter/services.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import '../../../../theme/app_style.dart';
import '../../../../utils/size_utils.dart';
import '../../../../Utils/image_constant.dart';
import '../../../../views/widgets/app_bar/appbar_image.dart';
import '../../../../views/widgets/app_bar/appbar_title.dart';
import '../../../../views/widgets/app_bar/custom_app_bar.dart';
import '../../../../theme/app_decoration.dart';

class feedback_form_entity_list_screen extends StatefulWidget {
  static const String routeName = '/entity-list';

  @override
  _feedback_form_entity_list_screenState createState() =>
      _feedback_form_entity_list_screenState();
}

class _feedback_form_entity_list_screenState
    extends State<feedback_form_entity_list_screen> {
  final FeedbackFormApiService apiService = FeedbackFormApiService();
  List<Map<String, dynamic>> entities = [];
  List<Map<String, dynamic>> filteredEntities = [];
  List<Map<String, dynamic>> serachEntities = [];
  

  bool showCardView = true; // Add this variable to control the view mode
  TextEditingController searchController = TextEditingController();
  late stt.SpeechToText speech;
  

  bool isLoading = false; // Add this variable to track loading state
  int currentPage = 0;
  int pageSize = 10; // Adjust this based on your backend API

  
  @override
  void initState() {
    // speech = stt.SpeechToText();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final feedbackProvider = Provider.of<FeedbackProvider>(context, listen: false);
      feedbackProvider.fetchEntities();
      feedbackProvider.fetchWithoutPaging();
      feedbackProvider.scrollController.addListener(feedbackProvider.scrollListener);
      feedbackProvider.fetchWithoutPaging();
    });
    // fetchEntities();
    // scrollController.addListener(.scrollListener);
  }

  // Future<void> fetchwithoutpaging() async {
  //   try {
  //     final token = await TokenManager.getToken();
  //     if (token != null) {
  //       final fetchedEntities = await apiService.getEntities();
  //       print('data is $fetchedEntities');
  //       setState(() {
  //         serachEntities = fetchedEntities; // Update only filteredEntities
  //       });
  //       print('FeedBack_Form entity is .. $serachEntities');
  //     }
  //   } catch (e) {
  //     showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           title: const Text('Error'),
  //           content: Text('Failed to fetch FeedBack_Form: $e'),
  //           actions: [
  //             TextButton(
  //               child: const Text('OK'),
  //               onPressed: () {
  //                 Navigator.of(context).pop();
  //               },
  //             ),
  //           ],
  //         );
  //       },
  //     );
  //   }
  // }

  // Future<void> fetchEntities() async {
  //   try {
  //     setState(() {
  //       isLoading = true;
  //     });
  //     final token = await TokenManager.getToken();
  //     if (token != null) {
  //       final fetchedEntities =
  //           await apiService.getAllWithPagination(currentPage, pageSize);
  //       print(' data is $fetchedEntities');
  //       setState(() {
  //         entities.addAll(fetchedEntities); // Add new data to the existing list
  //         filteredEntities = entities.toList(); // Update only filteredEntities
  //         currentPage++;
  //       });
  //       print(' entity is .. $filteredEntities');
  //     }
  //   } catch (e) {
  //     showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           title: const Text('Error'),
  //           content: Text('Failed to fetch FeedBack_Form data: $e'),
  //           actions: [
  //             TextButton(
  //               child: const Text('OK'),
  //               onPressed: () {
  //                 Navigator.of(context).pop();
  //               },
  //             ),
  //           ],
  //         );
  //       },
  //     );
  //   } finally {
  //     setState(() {
  //       isLoading = false;
  //     });
  //   }
  // }

  // void _scrollListener() {
  //   if (_scrollController.position.pixels ==
  //       _scrollController.position.maxScrollExtent) {
  //     fetchEntities();
  //   }
  // }

  // Future<void> deleteEntity(Map<String, dynamic> entity) async {
  //   try {
  //     await apiService.deleteEntity(entity['id']);
  //     setState(() {
  //       entities.remove(entity);
  //     });
  //   } catch (e) {
  //     showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           title: const Text('Error'),
  //           content: Text('Failed to delete entity: $e'),
  //           actions: [
  //             TextButton(
  //               child: const Text('OK'),
  //               onPressed: () {
  //                 Navigator.of(context).pop();
  //               },
  //             ),
  //           ],
  //         );
  //       },
  //     );
  //   }
  // }

  // void searchEntities(String keyword) {
  //   setState(() {
  //     filteredEntities = serachEntities
  //         .where((entity) =>
  //             entity['name']
  //                 .toString()
  //                 .toLowerCase()
  //                 .contains(keyword.toLowerCase()) ||
  //             entity['phone_number']
  //                 .toString()
  //                 .toLowerCase()
  //                 .contains(keyword.toLowerCase()) ||
  //             entity['email_field']
  //                 .toString()
  //                 .toLowerCase()
  //                 .contains(keyword.toLowerCase()) ||
  //             entity['share_your_experience']
  //                 .toString()
  //                 .toLowerCase()
  //                 .contains(keyword.toLowerCase()))
  //         .toList();
  //   });
  // }

  // void startListening() async {
  //   if (!speech.isListening) {
  //     bool available = await speech.initialize(
  //       onStatus: (status) {
  //         print('Speech recognition status: $status');
  //       },
  //       onError: (error) {
  //         print('Speech recognition error: $error');
  //       },
  //     );
  //     if (available) {
  //       speech.listen(
  //         onResult: (result) {
  //           if (result.finalResult) {
  //             searchController.text = result.recognizedWords;
  //             search_Entities(result.recognizedWords);
  //           }
  //         },
  //       );
  //     }
  //   }
  // }

  // void stopListening() {
  //   if (speech.isListening) {
  //     speech.stop();
  //   }
  // }

  @override
  void dispose() {
    speech.cancel();
    super.dispose();
  }

  onTapArrowleft1(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final feedbackProvider = Provider.of<FeedbackProvider>(context, listen: false);
    return SafeArea(
        child: Scaffold(
      appBar: CustomAppBar(
        height: getVerticalSize(49),
        leadingWidth: 40,
        leading: AppbarImage(
            height: getSize(24),
            width: getSize(24),
            svgPath: ImageConstant.imgArrowleft,
            margin: getMargin(left: 16, top: 12, bottom: 13),
            onTap: () {
              onTapArrowleft1(context);
            }),
        centerTitle: true,
        title: AppbarTitle(text: " FeedBack_Form"),
        actions: [
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
      body: RefreshIndicator(
        onRefresh: () async {
          currentPage = 1;
          entities.clear();
          await feedbackProvider.fetchEntities();
        },
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: feedbackProvider.searchController,
                onChanged: (value) {
                  feedbackProvider.search_Entities(value);
                },
                decoration: InputDecoration(
                  hintText: 'Search...',
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.mic),
                    onPressed: () {
                      feedbackProvider.startListening();
                    },
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredEntities.length + (isLoading ? 1 : 0),
                itemBuilder: (BuildContext context, int index) {
                  if (index < filteredEntities.length) {
                    final entity = filteredEntities[index];
                    return _buildListItem(entity);
                  } else {
                    // Display the loading indicator at the bottom when new data is loading
                    return const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                },
                controller: feedbackProvider.scrollController,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => feedback_formCreateEntityScreen(),
            ),
          ).then((_) {
            feedbackProvider.fetchEntities();
          });
        },
        child: const Icon(Icons.add),
      ),
    ));
  }

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

  // Function to build normal view for a list item

  Widget _buildNormalView(Map<String, dynamic> entity) {
    final values = entity.values.elementAt(21) ?? 'Authsec';
    final feedbackProvider = Provider.of<FeedbackProvider>(context, listen: false);

    return SizedBox(
      width: double.maxFinite,
      child: Container(
        padding: getPadding(
          left: 16,
          top: 5,
          right: 5,
          bottom: 17,
        ),
        decoration: AppDecoration.outlineGray70011.copyWith(
            borderRadius: BorderRadiusStyle.roundedBorder6,
            color: Colors.grey[100]),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: getPadding(
                  //right: 13,
                  ),
              child: Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.30,
                    margin: getMargin(
                      left: 8,
                      top: 3,
                      bottom: 1,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          entity['id'].toString(),
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: AppStyle.txtGreenSemiBold16,
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  PopupMenuButton<String>(
                    icon: const Icon(
                      Icons.more_vert,
                      color: Colors.black,
                      size: 16,
                    ),
                    itemBuilder: (BuildContext context) {
                      return [
                        PopupMenuItem<String>(
                          value: 'edit',
                          child: Row(
                            children: [
                              const Icon(
                                Icons.edit,
                                size: 16, // Adjust the icon size as needed
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Edit',
                                style: AppStyle
                                    .txtGilroySemiBold16, // Adjust the text size as needed
                              ),
                            ],
                          ),
                        ),
                        PopupMenuItem<String>(
                          value: 'delete',
                          child: Row(
                            children: [
                              const Icon(
                                Icons.delete,
                                size: 16, // Adjust the icon size as needed
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Delete',
                                style: AppStyle
                                    .txtGilroySemiBold16, // Adjust the text size as needed
                              ),
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
                            builder: (context) =>
                                feedback_formUpdateEntityScreen(entity: entity),
                          ),
                        ).then((_) {
                          feedbackProvider.fetchEntities();
                        });
                      } else if (value == 'delete') {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Confirm Deletion'),
                              content: const Text(
                                  'Are you sure you want to delete?'),
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
                                    feedbackProvider.deleteEntity(entity)
                                        .then((value) => {feedbackProvider.fetchEntities()});
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: getPadding(
                top: 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Name : ",
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: AppStyle.txtGilroyMedium16,
                  ),
                  Text(
                    entity['name'] ?? 'No Name Available',
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: AppStyle.txtGilroyMedium16Bluegray900,
                  ),
                ],
              ),
            ),
            Padding(
              padding: getPadding(
                top: 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Phone Number : ",
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: AppStyle.txtGilroyMedium16,
                  ),
                  Text(
                    entity['phone_number'] ?? 'No Phone Number Available',
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: AppStyle.txtGilroyMedium16Bluegray900,
                  ),
                ],
              ),
            ),
            Padding(
              padding: getPadding(
                top: 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Email Field : ",
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: AppStyle.txtGilroyMedium16,
                  ),
                  Text(
                    entity['email_field'] ?? 'No Email Field Available',
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: AppStyle.txtGilroyMedium16Bluegray900,
                  ),
                ],
              ),
            ),
            Padding(
              padding: getPadding(
                top: 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Share Your Experience : ",
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: AppStyle.txtGilroyMedium16,
                  ),
                  Text(
                    entity['share_your_experience'] ??
                        'No Share Your Experience Available',
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: AppStyle.txtGilroyMedium16Bluegray900,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLeadingIcon(String title) {
    return CircleAvatar(
      backgroundColor: Colors.blue,
      child: Text(
        title.isNotEmpty ? title[0].toUpperCase() : 'NA',
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }

  void _showAdditionalFieldsDialog(
    BuildContext context,
    Map<String, dynamic> entity,
  ) {
    final dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');

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
      final DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
      return dateFormat.format(dateTime);
    } else if (timestamp is String) {
      return timestamp;
    } else {
      return 'N/A';
    }
  }
}