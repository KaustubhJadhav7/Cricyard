import 'package:cricyard/providers/token_manager.dart';
import 'package:cricyard/views/screens/MenuScreen/find_friends_screen/showall_friends_screen.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:flutter_app/utils.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../Entity/friends/Find_Friends/viewmodel/Find_Friends_api_service.dart';

class FindFriendsScreen extends StatefulWidget {
  @override
  // final String token;

  // const FindFriendsScreen({Key? key, required this.token}) : super(key: key);

  _FindFriendsScreenState createState() => _FindFriendsScreenState();
}

class _FindFriendsScreenState extends State<FindFriendsScreen> {
  late Future<List<Map<String, dynamic>>> _friendsFuture;
  final FindFriendsApiService _apiService =
      FindFriendsApiService(); // Instantiate the ApiService
  String? _token;

  @override
  void initState() {
    super.initState();
    // Call the method to fetch friends when the screen initializes
    _loadFriends();
  }

  Future<void> _loadFriends() async {
    _token = await TokenManager.getToken();
    //  String token = widget.token;
    print("token is : $_token");
    setState(() {
      print("apiservice is getting calling");
      _friendsFuture = _apiService.getAllUsers(_token!);

      print("apiservice is getting called");
    });
  }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Find Friends'),
//       ),

//       body: Container(
//         decoration: BoxDecoration(
//           color: Color(0xFFF0F5F4),
//           borderRadius: BorderRadius.circular(25),
//         ),
//         padding: EdgeInsets.fromLTRB(13, 53, 6, 9),
//         child: Stack(
//           clipBehavior: Clip.none,
//           children: [
//             Positioned.fill(
//               // Position the list of friends below your existing UI
//               child: FutureBuilder<List<Map<String, dynamic>>>(
//                 future: _friendsFuture,
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     // Show a loading indicator while data is being fetched
//                     return Center(child: CircularProgressIndicator());
//                   } else if (snapshot.hasError) {
//                     // Show an error message if fetching data fails
//                     return Center(child: Text('Error: ${snapshot.error}'));
//                   } else if (snapshot.hasData) {
//                     // If data is available, display the list of friends
//                     return ListView.builder(
//                       itemCount: snapshot.data!.length,
//                       itemBuilder: (context, index) {
//                         final friend = snapshot.data![index];
//                         return ListTile(
//                           leading: CircleAvatar(
//                             // Load profile image from the friend's data
//                             backgroundImage: NetworkImage(
//                               friend['profileImageUrl'] ?? '',
//                             ),
//                           ),
//                           title: Text(friend['name'] ?? ''),
//                           subtitle: Text(friend['status'] ?? ''),
//                           // Add more fields as needed
//                         );
//                       },
//                     );
//                   } else {
//                     // Show a message if no friends are found
//                     return Center(child: Text('No friends found.'));
//                   }
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//BELOW IS MY WIDGE WITH STYLING
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Find Friends'),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF0F5F4),
          borderRadius: BorderRadius.circular(25),
        ),
        padding: const EdgeInsets.fromLTRB(13, 53, 6, 9),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 6, 29.2, 18),
                      child: SizedBox(
                        width: 24,
                        height: 24,
                        child: SvgPicture.asset(
                          'assets/vectors/vector_411_x2.svg',
                        ),
                      ),
                    ),
                    Text(
                      'Find Friends',
                      style: GoogleFonts.getFont(
                        'Poppins',
                        fontWeight: FontWeight.w700,
                        fontSize: 32,
                        color: const Color(0xFF000000),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 18),
                  child: SizedBox(
                    width: 78,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 24, 0),
                          child: Container(
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(
                                  'assets/images/magnifying_glass_2.png',
                                ),
                              ),
                            ),
                            child: Container(
                              width: 30,
                              height: 30,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 6, 0, 0),
                          child: SizedBox(
                            width: 24,
                            height: 24,
                            child: SvgPicture.asset(
                              'assets/vectors/vector_687_x2.svg',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20), // Add some space between elements
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: const Color(0xFFC5E1A5), // Light parrot color
                borderRadius: BorderRadius.circular(30),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  border: InputBorder.none,
                  icon: Icon(Icons.search),
                ),
              ),
            ),
            const SizedBox(height: 20), // Add some space between elements

            const SizedBox(height: 10),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ShowallFriendsScreen(),
                    ),
                  );
                },
                icon: const Icon(Icons.arrow_forward),
                label: const Text(
                  'My Friends',
                  style: TextStyle(
                      fontSize: 20, color: Colors.black), // Adjust font size
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(const Color(
                      0xFFC5E1A5)), // Set button color to your custom color
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 20)), // Adjust button size
                ),
              ),
            ),
            // Add space between button and search box
            const SizedBox(height: 10),

            // Now add your list of friends here
            FutureBuilder<List<Map<String, dynamic>>>(
              future: _friendsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // Show a loading indicator while data is being fetched
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  // Show an error message if fetching data fails
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  // If data is available, display the list of friends
                  return Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final friend = snapshot.data![index];
                        return ListTile(
                          leading: CircleAvatar(
                            // Load profile image from the friend's data
                            backgroundImage: NetworkImage(
                              friend['profileImageUrl'] ?? '',
                            ),
                          ),
                          title: Text(friend['fullName'] ?? ''),
                          subtitle: Text(friend['status'] ?? ''),
                          // Add more fields as needed
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  // Implement onTap action here
                                  // You can call the addFriend method from your service
                                  // Make sure to pass the required parameters
                                  if (_token != null ||
                                      friend['user_id'] != null) {
                                    print('Token: $_token');
                                    print(' userId: ${friend['user_id']}');

                                    _apiService.addFriend(
                                        _token!, friend['user_id']);
                                    print(
                                        'Add friend request sent successfully.');
                                  } else {
                                    // Handle case where token is null
                                    print("Token is null");
                                    print(
                                        'Error: token or userId is null. userId: ${friend['user_id']}');
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  margin: const EdgeInsets.only(right: 8),
                                  decoration: const BoxDecoration(
                                    color:
                                        Colors.green, // Green background color
                                    shape: BoxShape.circle, // Circular shape
                                  ),
                                  child: const Icon(
                                    Icons.add, // Plus sign icon
                                    color: Colors.white, // White color
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  // Show a message if no friends are found
                  return const Center(child: Text('No friends found.'));
                }
              },
            ),
          ],
        ),
      ),
    );
  }

// class FindFriendsScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Color(0xFFF0F5F4),
//         borderRadius: BorderRadius.circular(25),
//       ),

//       child: Container(
//         padding: EdgeInsets.fromLTRB(13, 53, 6, 9),
//         child: Stack(
//           clipBehavior: Clip.none,
//           children: [
//             SizedBox(
//               width: double.infinity,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Container(
//                     margin: EdgeInsets.fromLTRB(9, 0, 11, 20),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Container(
//                               margin: EdgeInsets.fromLTRB(0, 6, 29.2, 18),
//                               child: SizedBox(
//                                 width: 24,
//                                 height: 24,
//                                 child: SvgPicture.asset(
//                                   'assets/vectors/vector_411_x2.svg',
//                                 ),
//                               ),
//                             ),
//                             Text(
//                               'Find Friends',
//                               style: GoogleFonts.getFont(
//                                 'Poppins',
//                                 fontWeight: FontWeight.w700,
//                                 fontSize: 32,
//                                 color: Color(0xFF000000),
//                               ),
//                             ),
//                           ],
//                         ),
//                         Container(
//                           margin: EdgeInsets.fromLTRB(0, 0, 0, 18),
//                           child: SizedBox(
//                             width: 78,
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Container(
//                                   margin: EdgeInsets.fromLTRB(0, 0, 24, 0),
//                                   child: Container(
//                                     decoration: BoxDecoration(
//                                       image: DecorationImage(
//                                         fit: BoxFit.cover,
//                                         image: AssetImage(
//                                           'assets/images/magnifying_glass_2.png',
//                                         ),
//                                       ),
//                                     ),
//                                     child: Container(
//                                       width: 30,
//                                       height: 30,
//                                     ),
//                                   ),
//                                 ),
//                                 Container(
//                                   margin: EdgeInsets.fromLTRB(0, 6, 0, 0),
//                                   child: SizedBox(
//                                     width: 24,
//                                     height: 24,
//                                     child: SvgPicture.asset(
//                                       'assets/vectors/vector_687_x2.svg',
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Container(
//                     margin: EdgeInsets.fromLTRB(34, 0, 30, 33),
//                     decoration: BoxDecoration(
//                       border: Border.all(color: Color(0xFFD6D6D6)),
//                       borderRadius: BorderRadius.circular(10),
//                       color: Color(0xFFDEF8BB),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Color(0x40000000),
//                           offset: Offset(0, 1),
//                           blurRadius: 2,
//                         ),
//                       ],
//                     ),
//                     child: Container(
//                       height: 51,
//                       padding: EdgeInsets.fromLTRB(18, 10, 18, 11),
//                       child: Container(
//                         decoration: BoxDecoration(
//                           image: DecorationImage(
//                             fit: BoxFit.cover,
//                             image: AssetImage(
//                               'assets/images/magnifying_glass_2.png',
//                             ),
//                           ),
//                         ),
//                         child: Container(
//                           width: 30,
//                           height: 30,
//                         ),
//                       ),
//                     ),
//                   ),
//                   Container(
//                     margin: EdgeInsets.fromLTRB(26, 0, 19, 19),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Container(
//                               margin: EdgeInsets.fromLTRB(0, 0, 37, 0),
//                               child: SizedBox(
//                                 width: 41,
//                                 height: 40,
//                                 child: SvgPicture.asset(
//                                   'assets/vectors/mask_group_1_x2.svg',
//                                 ),
//                               ),
//                             ),
//                             Container(
//                               margin: EdgeInsets.fromLTRB(0, 11, 0, 2),
//                               child: Text(
//                                 'Addai',
//                                 style: GoogleFonts.getFont(
//                                   'Poppins',
//                                   fontWeight: FontWeight.w600,
//                                   fontSize: 18,
//                                   color: Color(0xFF000000),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         Container(
//                           margin: EdgeInsets.fromLTRB(0, 11, 0, 4),
//                           child: Container(
//                             decoration: BoxDecoration(
//                               image: DecorationImage(
//                                 fit: BoxFit.cover,
//                                 image: AssetImage(
//                                   'assets/images/delete_4.png',
//                                 ),
//                               ),
//                             ),
//                             child: Container(
//                               width: 28,
//                               height: 25,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Container(
//                     margin: EdgeInsets.fromLTRB(27, 0, 17, 16),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Container(
//                               margin: EdgeInsets.fromLTRB(0, 0, 37, 0),
//                               width: 40,
//                               height: 40,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(15),
//                               ),
//                               child: Container(
//                                 decoration: BoxDecoration(
//                                   image: DecorationImage(
//                                     fit: BoxFit.cover,
//                                     image: AssetImage(
//                                       'assets/images/image_2.png',
//                                     ),
//                                   ),
//                                 ),
//                                 child: Container(
//                                   width: 70.2,
//                                   height: 52.8,
//                                 ),
//                               ),
//                             ),
//                             Container(
//                               margin: EdgeInsets.fromLTRB(0, 10, 0, 3),
//                               child: Text(
//                                 'Boampong',
//                                 style: GoogleFonts.getFont(
//                                   'Poppins',
//                                   fontWeight: FontWeight.w600,
//                                   fontSize: 18,
//                                   color: Color(0xFF000000),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         Container(
//                           margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
//                           child: Container(
//                             decoration: BoxDecoration(
//                               image: DecorationImage(
//                                 fit: BoxFit.cover,
//                                 image: AssetImage(
//                                   'assets/images/delete_4.png',
//                                 ),
//                               ),
//                             ),
//                             child: Container(
//                               width: 28,
//                               height: 25,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Container(
//                     margin: EdgeInsets.fromLTRB(25, 0, 17, 8),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Container(
//                               margin: EdgeInsets.fromLTRB(0, 0, 39, 0),
//                               width: 40,
//                               height: 40,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(25),
//                               ),
//                               child: Container(
//                                 decoration: BoxDecoration(
//                                   image: DecorationImage(
//                                     fit: BoxFit.cover,
//                                     image: AssetImage(
//                                       'assets/images/image_11.png',
//                                     ),
//                                   ),
//                                 ),
//                                 child: Container(
//                                   width: 124.5,
//                                   height: 79.1,
//                                 ),
//                               ),
//                             ),
//                             Container(
//                               margin: EdgeInsets.fromLTRB(0, 8, 0, 5),
//                               child: Text(
//                                 'Akua',
//                                 style: GoogleFonts.getFont(
//                                   'Poppins',
//                                   fontWeight: FontWeight.w600,
//                                   fontSize: 18,
//                                   color: Color(0xFF000000),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         Container(
//                           margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
//                           child: Container(
//                             decoration: BoxDecoration(
//                               image: DecorationImage(
//                                 fit: BoxFit.cover,
//                                 image: AssetImage(
//                                   'assets/images/delete_4.png',
//                                 ),
//                               ),
//                             ),
//                             child: Container(
//                               width: 28,
//                               height: 25,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Container(
//                     margin: EdgeInsets.fromLTRB(25, 0, 16, 7),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Container(
//                           margin: EdgeInsets.fromLTRB(0, 0, 0, 9),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Container(
//                                 margin: EdgeInsets.fromLTRB(0, 0, 39, 0),
//                                 width: 40,
//                                 height: 40,
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(25),
//                                 ),
//                                 child: Container(
//                                   decoration: BoxDecoration(
//                                     image: DecorationImage(
//                                       fit: BoxFit.cover,
//                                       image: AssetImage(
//                                         'assets/images/image_11.png',
//                                       ),
//                                     ),
//                                   ),
//                                   child: Container(
//                                     width: 124.5,
//                                     height: 79.1,
//                                   ),
//                                 ),
//                               ),

//     STATIC FRIENDS
//                               Container(
//                                 margin: EdgeInsets.fromLTRB(0, 10, 0, 3),
//                                 child: Text(
//                                   'Addai',
//                                   style: GoogleFonts.getFont(
//                                     'Poppins',
//                                     fontWeight: FontWeight.w600,
//                                     fontSize: 18,
//                                     color: Color(0xFF000000),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Container(
//                           margin: EdgeInsets.fromLTRB(0, 24, 0, 0),
//                           child: Container(
//                             decoration: BoxDecoration(
//                               image: DecorationImage(
//                                 fit: BoxFit.cover,
//                                 image: AssetImage(
//                                   'assets/images/delete_4.png',
//                                 ),
//                               ),
//                             ),
//                             child: Container(
//                               width: 28,
//                               height: 25,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Container(
//                     margin: EdgeInsets.fromLTRB(25, 0, 25, 16),
//                     child: Align(
//                       alignment: Alignment.topLeft,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Container(
//                             margin: EdgeInsets.fromLTRB(0, 0, 39, 0),
//                             width: 40,
//                             height: 40,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(25),
//                             ),
//                             child: Container(
//                               decoration: BoxDecoration(
//                                 image: DecorationImage(
//                                   fit: BoxFit.cover,
//                                   image: AssetImage(
//                                     'assets/images/image_11.png',
//                                   ),
//                                 ),
//                               ),
//                               child: Container(
//                                 width: 124.5,
//                                 height: 79.1,
//                               ),
//                             ),
//                           ),
//                           Container(
//                             margin: EdgeInsets.fromLTRB(0, 8, 0, 5),
//                             child: Text(
//                               'Adiza Salifu',
//                               style: GoogleFonts.getFont(
//                                 'Poppins',
//                                 fontWeight: FontWeight.w600,
//                                 fontSize: 18,
//                                 color: Color(0xFF000000),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Container(
//                     margin: EdgeInsets.fromLTRB(27, 0, 27, 16),
//                     child: Align(
//                       alignment: Alignment.topLeft,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Container(
//                             margin: EdgeInsets.fromLTRB(0, 0, 37, 0),
//                             width: 40,
//                             height: 40,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(15),
//                             ),
//                             child: Container(
//                               decoration: BoxDecoration(
//                                 image: DecorationImage(
//                                   fit: BoxFit.cover,
//                                   image: AssetImage(
//                                     'assets/images/image_2.png',
//                                   ),
//                                 ),
//                               ),
//                               child: Container(
//                                 width: 70.2,
//                                 height: 52.8,
//                               ),
//                             ),
//                           ),
//                           Container(
//                             margin: EdgeInsets.fromLTRB(0, 10, 0, 3),
//                             child: Text(
//                               'Akua',
//                               style: GoogleFonts.getFont(
//                                 'Poppins',
//                                 fontWeight: FontWeight.w600,
//                                 fontSize: 18,
//                                 color: Color(0xFF000000),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Container(
//                     margin: EdgeInsets.fromLTRB(25, 0, 25, 8),
//                     child: Align(
//                       alignment: Alignment.topLeft,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Container(
//                             margin: EdgeInsets.fromLTRB(0, 0, 39, 0),
//                             width: 40,
//                             height: 40,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(25),
//                             ),
//                             child: Container(
//                               decoration: BoxDecoration(
//                                 image: DecorationImage(
//                                   fit: BoxFit.cover,
//                                   image: AssetImage(
//                                     'assets/images/image_11.png',
//                                   ),
//                                 ),
//                               ),
//                               child: Container(
//                                 width: 124.5,
//                                 height: 79.1,
//                               ),
//                             ),
//                           ),
//                           Container(
//                             margin: EdgeInsets.fromLTRB(0, 8, 0, 5),
//                             child: Text(
//                               'Amponsah',
//                               style: GoogleFonts.getFont(
//                                 'Poppins',
//                                 fontWeight: FontWeight.w600,
//                                 fontSize: 18,
//                                 color: Color(0xFF000000),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Container(
//                     margin: EdgeInsets.fromLTRB(27, 0, 27, 16),
//                     child: Align(
//                       alignment: Alignment.topLeft,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Container(
//                             margin: EdgeInsets.fromLTRB(0, 0, 37, 0),
//                             width: 40,
//                             height: 40,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(15),
//                             ),
//                             child: Container(
//                               decoration: BoxDecoration(
//                                 image: DecorationImage(
//                                   fit: BoxFit.cover,
//                                   image: AssetImage(
//                                     'assets/images/image_2.png',
//                                   ),
//                                 ),
//                               ),
//                               child: Container(
//                                 width: 70.2,
//                                 height: 52.8,
//                               ),
//                             ),
//                           ),
//                           Container(
//                             margin: EdgeInsets.fromLTRB(0, 10, 0, 3),
//                             child: Text(
//                               'Bisa K Dei',
//                               style: GoogleFonts.getFont(
//                                 'Poppins',
//                                 fontWeight: FontWeight.w600,
//                                 fontSize: 18,
//                                 color: Color(0xFF000000),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Container(
//                     margin: EdgeInsets.fromLTRB(25, 0, 25, 16),
//                     child: Align(
//                       alignment: Alignment.topLeft,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Container(
//                             margin: EdgeInsets.fromLTRB(0, 0, 39, 0),
//                             width: 40,
//                             height: 40,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(25),
//                             ),
//                             child: Container(
//                               decoration: BoxDecoration(
//                                 image: DecorationImage(
//                                   fit: BoxFit.cover,
//                                   image: AssetImage(
//                                     'assets/images/image_11.png',
//                                   ),
//                                 ),
//                               ),
//                               child: Container(
//                                 width: 124.5,
//                                 height: 79.1,
//                               ),
//                             ),
//                           ),
//                           Container(
//                             margin: EdgeInsets.fromLTRB(0, 8, 0, 5),
//                             child: Text(
//                               'Boampong',
//                               style: GoogleFonts.getFont(
//                                 'Poppins',
//                                 fontWeight: FontWeight.w600,
//                                 fontSize: 18,
//                                 color: Color(0xFF000000),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Container(
//                     margin: EdgeInsets.fromLTRB(27, 0, 27, 10),
//                     child: Align(
//                       alignment: Alignment.topLeft,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Container(
//                             margin: EdgeInsets.fromLTRB(0, 0, 37, 0),
//                             width: 40,
//                             height: 40,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(15),
//                             ),
//                             child: Container(
//                               decoration: BoxDecoration(
//                                 image: DecorationImage(
//                                   fit: BoxFit.cover,
//                                   image: AssetImage(
//                                     'assets/images/image_2.png',
//                                   ),
//                                 ),
//                               ),
//                               child: Container(
//                                 width: 70.2,
//                                 height: 52.8,
//                               ),
//                             ),
//                           ),
//                           Container(
//                             margin: EdgeInsets.fromLTRB(0, 10, 0, 3),
//                             child: Text(
//                               'Buabeng',
//                               style: GoogleFonts.getFont(
//                                 'Poppins',
//                                 fontWeight: FontWeight.w600,
//                                 fontSize: 18,
//                                 color: Color(0xFF000000),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Container(
//                     margin: EdgeInsets.fromLTRB(7, 0, 7, 35),
//                     child: Align(
//                       alignment: Alignment.topRight,
//                       child: Container(
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(28),
//                           color: Color(0xFF2F80ED),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Color(0x40466087),
//                               offset: Offset(0, 4),
//                               blurRadius: 16,
//                             ),
//                           ],
//                         ),
//                         child: Container(
//                           width: 56,
//                           height: 56,
//                           padding: EdgeInsets.fromLTRB(18, 18, 18, 18),
//                           child: Container(
//                             width: 20,
//                             height: 20,
//                             child: SizedBox(
//                               width: 20,
//                               height: 20,
//                               child: SvgPicture.asset(
//                                 'assets/vectors/vector_354_x2.svg',
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     width: 409,
//                     height: 80,
//                     child: SvgPicture.asset(
//                       'assets/vectors/subtract_32_x2.svg',
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Positioned(
//               right: 172,
//               bottom: 51,
//               child: Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(51),
//                   gradient: LinearGradient(
//                     begin: Alignment(0, -1),
//                     end: Alignment(0, 1),
//                     colors: <Color>[Color(0xFFBEFF4C), Color(0x00BBFB4C)],
//                     stops: <double>[0, 1],
//                   ),
//                 ),
//                 child: Container(
//                   width: 64,
//                   height: 64,
//                   child: Container(
//                     width: 20,
//                     height: 20,
//                     child: SizedBox(
//                       width: 20,
//                       height: 20,
//                       child: SvgPicture.asset(
//                         'assets/vectors/vector_73_x2.svg',
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             Positioned(
//               left: 20,
//               bottom: 15,
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: Color(0xFFC7FC6C),
//                   borderRadius: BorderRadius.circular(51),
//                 ),
//                 child: Container(
//                   width: 50,
//                   height: 50,
//                   padding: EdgeInsets.fromLTRB(14, 14, 13.5, 13.5),
//                   child: SizedBox(
//                     width: 22.5,
//                     height: 22.5,
//                     child: SvgPicture.asset(
//                       'assets/vectors/vector_524_x2.svg',
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             Positioned(
//               left: 97,
//               bottom: 15,
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: Color(0xFFC7FC6C),
//                   borderRadius: BorderRadius.circular(51),
//                 ),
//                 child: Container(
//                   width: 50,
//                   height: 50,
//                   padding: EdgeInsets.fromLTRB(16.1, 14.1, 14.1, 16.1),
//                   child: Container(
//                     width: 19.8,
//                     height: 19.8,
//                     child: SizedBox(
//                       width: 19.8,
//                       height: 19.8,
//                       child: SvgPicture.asset(
//                         'assets/vectors/vector_843_x2.svg',
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             Positioned(
//               right: 89,
//               bottom: 15,
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: Color(0xFFC7FC6C),
//                   borderRadius: BorderRadius.circular(51),
//                 ),
//                 child: Container(
//                   width: 50,
//                   height: 50,
//                   padding: EdgeInsets.fromLTRB(15, 18.6, 15, 16.6),
//                   child: Container(
//                     width: 20,
//                     height: 14.7,
//                     child: SizedBox(
//                       width: 20,
//                       height: 14.7,
//                       child: SvgPicture.asset(
//                         'assets/vectors/vector_274_x2.svg',
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             Positioned(
//               right: 13,
//               bottom: 15,
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: Color(0xFFC7FC6C),
//                   borderRadius: BorderRadius.circular(51),
//                 ),
//                 child: Container(
//                   width: 50,
//                   height: 50,
//                   padding: EdgeInsets.fromLTRB(20, 17, 20, 15),
//                   child: Container(
//                     width: 4,
//                     height: 18,
//                     child: SizedBox(
//                       width: 4,
//                       height: 18,
//                       child: SvgPicture.asset(
//                         'assets/vectors/vector_561_x2.svg',
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
}