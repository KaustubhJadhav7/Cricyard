// ignore_for_file: use_build_context_synchronously
import 'package:cricyard/core/app_export.dart';
import 'package:flutter/material.dart';

import '/providers/token_manager.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

import 'NotificationService.dart';

class GetAllNotification extends StatefulWidget {
  static const String routeName = '/entity-list';

  @override
  _GetAllNotificationState createState() => _GetAllNotificationState();
}

class _GetAllNotificationState extends State<GetAllNotification> {
  final NotificationService apiService = NotificationService();
  List<Map<String, dynamic>> entities = [];
  List<Map<String, dynamic>> filteredEntities = [];
  List<Map<String, dynamic>> serachEntities = [];

  bool showCardView = true; // Add this variable to control the view mode
  TextEditingController searchController = TextEditingController();
  late stt.SpeechToText _speech;

  bool isLoading = false; // Add this variable to track loading state
  int currentPage = 0;
  int pageSize = 10; // Adjust this based on your backend API

  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    _speech = stt.SpeechToText();
    super.initState();
    fetchEntities();
    _scrollController.addListener(_scrollListener);
    fetchwithoutpaging();
  }

  Future<void> fetchwithoutpaging() async {
    try {
      final fetchedEntities = await apiService.getByUserId();
      print('data is $fetchedEntities');
      setState(() {
        serachEntities = fetchedEntities; // Update only filteredEntities
      });
      print('entity is .. $serachEntities');
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text('Failed to fetch : $e'),
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

  Future<void> fetchEntities() async {
    try {
      setState(() {
        isLoading = true;
      });

      final token = await TokenManager.getToken();
      if (token != null) {
        final fetchedEntities =
            await apiService.getAllWithPagination(token, currentPage, pageSize);
        print('paging data is $fetchedEntities');
        setState(() {
          entities.addAll(fetchedEntities); // Add new data to the existing list
          filteredEntities = entities.toList(); // Update only filteredEntities
          currentPage++;
        });

        print(' entity is .. $filteredEntities');
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text('Failed to fetch Notification data: $e'),
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
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      fetchEntities();
    }
  }

  void _searchEntities(String keyword) {
    setState(() {
      filteredEntities = serachEntities
          .where((entity) => entity['notification']
              .toString()
              .toLowerCase()
              .contains(keyword.toLowerCase()))
          .toList();
    });
  }

  void _startListening() async {
    if (!_speech.isListening) {
      bool available = await _speech.initialize(
        onStatus: (status) {
          print('Speech recognition status: $status');
        },
        onError: (error) {
          print('Speech recognition error: $error');
        },
      );

      if (available) {
        _speech.listen(
          onResult: (result) {
            if (result.finalResult) {
              searchController.text = result.recognizedWords;
              _searchEntities(result.recognizedWords);
            }
          },
        );
      }
    }
  }

  void _stopListening() {
    if (_speech.isListening) {
      _speech.stop();
    }
  }

  @override
  void dispose() {
    _speech.cancel();
    super.dispose();
  }

  onTapArrowleft1(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          forceMaterialTransparency: true,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 40,
                decoration: BoxDecoration(
                    color: const Color(0xffcbfd71),
                    borderRadius: BorderRadius.circular(12)),
                child: const Icon(Icons.arrow_back_ios_new_outlined),
              ),
            ),
          ),
          title: Text(
            "Notifications",
            style: CustomTextStyles.titleLargePoppinsBlack,
          ),
          actions: [
            Switch(
              activeColor: const Color(0xff2e5b34),
              activeTrackColor: Color(0xff4c9b56),
              inactiveTrackColor: Color(0xffd24343),
              inactiveThumbColor: Color(0xffab2424),
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
            await fetchEntities();
          },
          child: Column(
            children: [
              Text(
                "Total notifications -${filteredEntities.length}",
                style: const TextStyle(color: Colors.grey),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: searchController,
                  onChanged: (value) {
                    _searchEntities(value);
                  },
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 16.0),
                    filled: true,
                    hoverColor: Colors.white,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide.none,
                    ),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.mic),
                      onPressed: () {
                        _startListening();
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
                  controller: _scrollController,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListItem(Map<String, dynamic> entity) {
    return showCardView ? _buildCardView(entity) : _buildNormalView(entity);
  }

  // Function to build card view for a list item
  Widget _buildCardView(Map<String, dynamic> entity) {
    return _buildNormalView(entity);
  }
  //existing code
  // void _accept(int refId) async {
  //   apiService.Accept(refId).then((_) => fetchEntities());
  // }

  // Future<void> _ignore(int refId) async {
  //   apiService.ignored(refId).then((_) => fetchEntities());
  // }

  // code by shri
  void _accept(int refId) async {
    try {
      await apiService.Accept(refId).then((value) => fetchEntities());
      setState(() {
        final index = entities.indexWhere((entity) => entity['id'] == refId);
        if (index != -1) {
          entities[index]['isaccepted'] = true;
          entities[index]['isignored'] = false;
        }
      });
    } catch (e) {
      print('Failed to accept: $e');
    }
  }

  Future<void> _ignore(int refId) async {
    try {
      await apiService.ignored(refId).then((value) => fetchEntities());
      setState(() {
        final index = entities.indexWhere((entity) => entity['id'] == refId);
        if (index != -1) {
          entities[index]['isignored'] = true;
          entities[index]['isaccepted'] = false;
        }
      });
    } catch (e) {
      print('Failed to ignore: $e');
    }
  }
  // Function to build normal view for a list item

  Widget _buildNormalView(Map<String, dynamic> entity) {
    bool isAccepted = entity['isaccepted'] ?? false;
    bool isIgnored = entity['isignored'] ?? false;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0), color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${entity['notification']}',
                style: CustomTextStyles.titleMediumPoppins),
            const SizedBox(height: 8.0),
            if (isAccepted)
              const Text('Accepted',
                  style: TextStyle(
                      color: Colors.green,
                      fontSize: 14,
                      fontWeight: FontWeight.w400))
            else if (isIgnored)
              const Text('Ignored',
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 14,
                      fontWeight: FontWeight.w400))
            else
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 70,
                    child: ElevatedButton(
                      onPressed: () {
                        _accept(entity['id']);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Accept',
                            style:
                                TextStyle(color: Colors.white, fontSize: 14)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  SizedBox(
                    width: 70,
                    child: ElevatedButton(
                      onPressed: () {
                        _ignore(entity['id']);
                      },
                      style:
                          ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Ignore',
                            style:
                                TextStyle(color: Colors.white, fontSize: 14)),
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}