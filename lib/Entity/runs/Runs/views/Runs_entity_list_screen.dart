// ignore_for_file: use_build_context_synchronously
import 'package:cricyard/Entity/runs/Runs/model/Runs_model.dart';
import 'package:cricyard/Entity/runs/Runs/viewmodel/Runs_viewmodel.dart';
import 'package:cricyard/Entity/runs/Runs/views/widget/buildNormalView.dart';
import 'package:cricyard/Entity/runs/Runs/views/widget/showAdditionalDialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../repository/Runs_api_service.dart';
import 'Runs_create_entity_screen.dart';
import '../../../../utils/size_utils.dart';
import '../../../../Utils/image_constant.dart';
import '../../../../views/widgets/app_bar/appbar_image.dart';
import '../../../../views/widgets/app_bar/appbar_title.dart';
import '../../../../views/widgets/app_bar/custom_app_bar.dart';

class runs_entity_list_screen extends StatefulWidget {
  static const String routeName = '/entity-list';

  @override
  _runs_entity_list_screenState createState() =>
      _runs_entity_list_screenState();
}

class _runs_entity_list_screenState extends State<runs_entity_list_screen> {
  final runsApiService apiService = runsApiService();
  // List<Map<String, dynamic>> entities = [];
  // List<Map<String, dynamic>> filteredEntities = [];
  // List<Map<String, dynamic>> serachEntities = [];

  bool showCardView = true; // Add this variable to control the view mode
  // TextEditingController searchController = TextEditingController();
  // late stt.SpeechToText _speech;

  bool isLoading = false; // Add this variable to track loading state
  int currentPage = 0;
  int pageSize = 10; // Adjust this based on your backend API

  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider =
          Provider.of<RunsEntitiesProvider>(context, listen: false);
      // _speech = stt.SpeechToText();
      super.initState();
      provider.fetchEntities();
      _scrollController.addListener(_scrollListener);
      provider.fetchWithoutPaging();
    });
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
  //       print('Runs entity is .. $serachEntities');
  //     }
  //   } catch (e) {
  //     showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           title: const Text('Error'),
  //           content: Text('Failed to fetch Runs: $e'),
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
  //           content: Text('Failed to fetch Runs data: $e'),
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider =
          Provider.of<RunsEntitiesProvider>(context, listen: false);
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        provider.fetchEntities();
      }
    });
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
  //             entity['description']
  //                 .toString()
  //                 .toLowerCase()
  //                 .contains(keyword.toLowerCase()) ||
  //             entity['active']
  //                 .toString()
  //                 .toLowerCase()
  //                 .contains(keyword.toLowerCase()) ||
  //             entity['number_of_runs']
  //                 .toString()
  //                 .toLowerCase()
  //                 .contains(keyword.toLowerCase()) ||
  //             entity['select_field']
  //                 .toString()
  //                 .toLowerCase()
  //                 .contains(keyword.toLowerCase()))
  //         .toList();
  //   });
  // }

  // void _startListening() async {
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
  //             searchController.text = result.recognizedWords;
  //             _searchEntities(result.recognizedWords);
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
    super.dispose();
  }

  onTapArrowleft1(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RunsEntitiesProvider>(context, listen: false);
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
        title: AppbarTitle(text: " Runs"),
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
          provider.entities.clear();
          await provider.fetchEntities();
        },
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: provider.searchController,
                onChanged: (value) {
                  provider.searchEntities(value);
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
                      provider.startListening();
                    },
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: provider.filteredEntities.length + (isLoading ? 1 : 0),
                itemBuilder: (BuildContext context, int index) {
                  if (index < provider.filteredEntities.length) {
                    final entity = provider.filteredEntities[index];
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
              builder: (context) => runsCreateEntityScreen(),
            ),
          ).then((_) {
            provider.fetchEntities();
          });
        },
        child: const Icon(Icons.add),
      ),
    ));
  }

  Widget _buildListItem(RunsEntity entity) {
    return showCardView ? _buildCardView(entity) : _buildNormalView(entity);
  }

  // Function to build card view for a list item
  Widget _buildCardView(RunsEntity entity) {
    return Card(
        elevation: 2,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: _buildNormalView(entity));
  }


  Widget _buildNormalView(RunsEntity entity) {
    return RunsNormalView(entity: entity);
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
    AdditionalFieldsDialog.show(context, entity);
  }

  
}
