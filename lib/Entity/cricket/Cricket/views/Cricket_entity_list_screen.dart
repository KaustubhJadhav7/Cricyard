import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../repository/Cricket_api_service.dart';
import 'Cricket_create_entity_screen.dart';
import 'Cricket_update_entity_screen.dart';
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
import 'package:provider/provider.dart';
import '../viewmodel/Cricket_viewmodel.dart';
import '../model/cricket_model.dart';

class cricket_entity_list_screen extends StatefulWidget {
  static const String routeName = '/entity-list';

  @override
  _cricket_entity_list_screenState createState() =>
      _cricket_entity_list_screenState();
}

class _cricket_entity_list_screenState
    extends State<cricket_entity_list_screen> {
      
  final CricketApiService apiService = CricketApiService();
  CricketEntity cricketEntity = CricketEntity();
  // List<Map<String, dynamic>> entities = [];
  // List<Map<String, dynamic>> filteredEntities = [];
  // List<Map<String, dynamic>> searchEntities = [];
  // bool showCardView = true; // Add this variable to control the view mode
  // late stt.SpeechToText _speech;
  // bool isLoading = false; // Add this variable to track loading state
  // int currentPage = 0;
  // int pageSize = 10; // Adjust this based on your backend API

  final ScrollController _scrollController = ScrollController();
  late CricketListModel cricketListModel;
  
  @override
  void initState() {
    final cricketProvider = Provider.of<CricketProvider>(context, listen: false);
    super.initState();
    _scrollController.addListener(_scrollListener);
    cricketProvider.fetchEntities();
    cricketProvider.fetchWithoutPaging();
  }

  // Future<void> fetchwithoutpaging() async {
  //   try {
  //     final token = await TokenManager.getToken();
  //     if (token != null) {
  //       final fetchedEntities = await apiService.getEntities(token!);
  //       print('data is $fetchedEntities');
  //       setState(() {
  //         serachEntities = fetchedEntities; // Update only filteredEntities
  //       });
  //       print('Cricket entity is .. $serachEntities');
  //     }
  //   } catch (e) {
  //     showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           title: const Text('Error'),
  //           content: Text('Failed to fetch Cricket: $e'),
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
  //           await apiService.getAllWithPagination(token, currentPage, pageSize);
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
  //           content: Text('Failed to fetch Cricket data: $e'),
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

  void _scrollListener() {
    final cricketProvider = Provider.of<CricketProvider>(context);
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      cricketProvider.fetchEntities();
    }
  }

  // Future<void> deleteEntity(Map<String, dynamic> entity) async {
  //   try {
  //     final token = await TokenManager.getToken();
  //     await apiService.deleteEntity(token!, entity['id']);
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

  // void _searchEntities(String keyword) {
  //   setState(() {
  //     filteredEntities = serachEntities
  //         .where((entity) =>
  //             entity['audio_language']
  //                 .toString()
  //                 .toLowerCase()
  //                 .contains(keyword.toLowerCase()) ||
  //             entity['name']
  //                 .toString()
  //                 .toLowerCase()
  //                 .contains(keyword.toLowerCase()) ||
  //             entity['description']
  //                 .toString()
  //                 .toLowerCase()
  //                 .contains(keyword.toLowerCase()) ||
  //             entity['active']
  //                 .toString()
  //                 .toLowerCase()
  //                 .contains(keyword.toLowerCase()))
  //         .toList();
  //   });
  // }

  // void _startListening() async {
  //   final cricketProvider = Provider.of<CricketProvider>(context);
  //   if (!_speech.isListening) {
  //     bool available = await _speech.initialize(
  //       onStatus: (status) {
  //         print('Speech recognition status: $status');
  //       },
  //       onError: (error) {
  //         print('Speech recognition error: $error');
  //       },
  //     );
  //     if (available) {
  //       _speech.listen(
  //         onResult: (result) {
  //           if (result.finalResult) {
  //             cricketProvider.searchController.text = result.recognizedWords;
  //             cricketProvider.searchEntities(result.recognizedWords);
  //           }
  //         },
  //       );
  //     }
  //   }
  // }

  // void _stopListening() {
  //   if (_speech.isListening) {
  //     _speech.stop();
  //   }
  // }

  @override
  void dispose() {
    // _speech.cancel();
    super.dispose();
  }

  onTapArrowleft1(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final cricketProvider = Provider.of<CricketProvider>(context);
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
        title: AppbarTitle(text: " Cricket"),
        actions: [
          Switch(
            activeColor: Colors.greenAccent,
            inactiveThumbColor: Colors.white,
            value: cricketListModel.showCardView,
            onChanged: (value) {
              setState(() {
                cricketListModel.showCardView = value;
              });
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          cricketListModel.currentPage = 1;
          cricketListModel.entities.clear();
          await cricketProvider.fetchEntities();
        },
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: cricketProvider.searchController,
                onChanged: (value) {
                  cricketProvider.searchEntities(value);
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
                      cricketProvider.startListening();
                    },
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: cricketListModel.filteredEntities.length + (cricketListModel.isLoading ? 1 : 0),
                itemBuilder: (BuildContext context, int index) {
                  if (index < cricketListModel.filteredEntities.length) {
                    final entity = cricketListModel.filteredEntities[index];
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
                controller: _scrollController,
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
              builder: (context) => CricketCreateEntityScreen(),
            ),
          ).then((_) {
            cricketProvider.fetchEntities();
          });
        },
        child: const Icon(Icons.add),
      ),
    ));
  }

  Widget _buildListItem(Map<String, dynamic> entity) {
    return cricketListModel.showCardView ? _buildCardView(entity) : _buildNormalView(entity);
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
    final cricketProvider = Provider.of<CricketProvider>(context);

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
                                CricketUpdateEntityScreen(entity: entity),
                          ),
                        ).then((_) {
                          cricketProvider.fetchEntities();
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
                                    cricketProvider.deleteEntity(entity)
                                        .then((value) => {cricketProvider.fetchEntities()});
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
                    "Audio Language : ",
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: AppStyle.txtGilroyMedium16,
                  ),
                  Text(
                    entity['audio_language'] ?? 'No Audio Language Available',
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
                    "Description : ",
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: AppStyle.txtGilroyMedium16,
                  ),
                  Text(
                    entity['description'] ?? 'No Description Available',
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
                    "Active : ",
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: AppStyle.txtGilroyMedium16,
                  ),
                  Text(
                    entity['active'].toString() ?? 'No Active Available',
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