import 'package:cricyard/views/screens/MenuScreen/teams_screen/teamRepo/team_repo.dart';
import 'package:flutter/material.dart';

class TeamViewModel extends ChangeNotifier {
  final teamrepo = TeamRepo();

//   Future<List<Map<String, dynamic>>> getEntities() async {
//     try {
//       final token = await TokenManager.getToken();

//       dio.options.headers['Authorization'] = 'Bearer $token';
//       final response = await dio.get('$baseUrl/Teams/Teams');
//       final entities = (response.data as List).cast<Map<String, dynamic>>();
//       return entities;
//     } catch (e) {
//       throw Exception('Failed to get all Team: $e');
//     }
//   }

//   Future<List<Map<String, dynamic>>> getAllWithPagination(
//       String token, int page, int Size) async {
//     try {
//       dio.options.headers['Authorization'] = 'Bearer $token';
//       final response = await dio
//           .get('$baseUrl/Teams/Teams/getall/page?page=$page&size=$Size');
//       final entities =
//           (response.data['content'] as List).cast<Map<String, dynamic>>();
//       return entities;
//     } catch (e) {
//       throw Exception('Failed to get all without pagination: $e');
//     }
//   }

//   Future<Map<String, dynamic>> createEntity(
//       String token, Map<String, dynamic> entity) async {
//     try {
//       print("in post api$entity");
//       dio.options.headers['Authorization'] = 'Bearer $token';
//       final response = await dio.post('$baseUrl/Teams/Teams', data: entity);

//       print(entity);

//       // Assuming the response is a Map<String, dynamic>
//       Map<String, dynamic> responseData = response.data;

//       return responseData;
//     } catch (e) {
//       throw Exception('Failed to create Team: $e');
//     }
//   }

// // Modify the uploadlogoimage function
//   Future<void> uploadlogoimage(String token, String ref, String refTableNmae,
//       String selectedFilePath, Uint8List image_timageBytes) async {
//     try {
//       String apiUrl = "$baseUrl/FileUpload/Uploadeddocs/$ref/$refTableNmae";

//       final Uint8List fileBytes = image_timageBytes!;
//       final mimeType = logolookupMimeType(selectedFilePath);

//       FormData formData = FormData.fromMap({
//         'file': MultipartFile.fromBytes(
//           fileBytes,
//           filename: selectedFilePath
//               .split('/')
//               .last, // Get the file name from the path
//           contentType: MediaType.parse(mimeType!),
//         ),
//       });

//       Dio dio = Dio(); // Create a new Dio instance
//       dio.options.headers['Authorization'] = 'Bearer $token';

//       final response = await dio.post(apiUrl, data: formData);

//       if (response.statusCode == 200) {
//         // Handle successful response
//         print('File uploaded successfully');
//       } else {
//         print('Failed to upload file with status: ${response.statusCode}');
//       }
//     } catch (error) {
//       print('Error occurred during form submission: $error');
//     }
//   }

// // Modify the lookupMimeType function if needed
//   String logolookupMimeType(String filePath) {
//     final ext = filePath.split('.').last;
//     switch (ext) {
//       case 'jpg':
//       case 'jpeg':
//         return 'image/jpeg';
//       case 'png':
//         return 'image/png';
//       case 'pdf':
//         return 'application/pdf';
//       // Add more cases for other file types as needed
//       default:
//         return 'application/octet-stream'; // Default MIME type
//     }
//   }

//   Future<void> updateEntity(
//       String token, int entityId, Map<String, dynamic> entity) async {
//     try {
//       dio.options.headers['Authorization'] = 'Bearer $token';
//       await dio.put('$baseUrl/Teams/Teams/$entityId', data: entity);
//       print(entity);
//     } catch (e) {
//       throw Exception('Failed to update entity: $e');
//     }
//   }

//   Future<void> deleteEntity(String token, int entityId) async {
//     try {
//       dio.options.headers['Authorization'] = 'Bearer $token';
//       await dio.delete('$baseUrl/Teams/Teams/$entityId');
//     } catch (e) {
//       throw Exception('Failed to delete entity: $e');
//     }
//   }

// my team creted by self

  List<Map<String, dynamic>> teamNameItems = [];

  Future<dynamic> getMyTeam() async {
    // teamrepo.getMyTeam().then(
    //   (value) {
    //     List<Map<String, dynamic>> responseData = value.data;
    //     print('This is my getMyTeam data: $responseData');
    //     teamNameItems = responseData;
    //   },
    // ).onError(
    //   (error, stackTrace) {
    //     print('error is $error');
    //   },
    // );
    try {
      final List<dynamic> response = await teamrepo.getMyTeam();
      // final List<Map<String, dynamic>> responseData = response.data;

      print('This is my getMyTeam data: $response');

      teamNameItems = response.cast<Map<String, dynamic>>();
      notifyListeners(); // Notify listeners so UI updates
    } catch (error) {
      print('Error fetching team data: $error');
    }
  }

//   // my team enrolled in which team
//   Future<List<Map<String, dynamic>>> getenrolledTeam() async {
//     try {
//       final token = await TokenManager.getToken();
//       dio.options.headers['Authorization'] = 'Bearer $token';
//       final response =
//           await dio.get('$baseUrl/team/Register_team/enrolled/getAll');
//       final entities = (response.data as List).cast<Map<String, dynamic>>();
//       return entities;
//     } catch (e) {
//       throw Exception('Failed to get enrolled Team: $e');
//     }
//   }

// // get all team by tournament id
//   Future<List<Map<String, dynamic>>> getMyTeamBytourId(int tourId) async {
//     try {
//       final token = await TokenManager.getToken();
//       dio.options.headers['Authorization'] = 'Bearer $token';
//       final response = await dio
//           .get('$baseUrl/tournament/Register_tournament/teams/$tourId');
//       final entities = (response.data as List).cast<Map<String, dynamic>>();
//       return entities;
//     } catch (e) {
//       throw Exception('Failed to get all Teams: $e');
//     }
//   }

// // get all member by team id
//   Future<List<Map<String, dynamic>>> getallmember(int teamId) async {
//     try {
//       final token = await TokenManager.getToken();
//       dio.options.headers['Authorization'] = 'Bearer $token';
//       final response =
//           await dio.get('$baseUrl/team/Register_team/member/$teamId');
//       final entities = (response.data as List).cast<Map<String, dynamic>>();
//       return entities;
//     } catch (e) {
//       throw Exception('Failed to get all Member: $e');
//     }
//   }

// // enroll in team
  Future<dynamic> enrollInTeam(Map<String, dynamic> entity) async {
    teamrepo.enrollInTeam(entity).then(
      (value) {
        Map<String, dynamic> responseData = value.data;
        return responseData;
      },
    ).onError(
      (error, stackTrace) {
        Map<String, dynamic> responseData = {};
        return responseData;
      },
    );
  }

// // send invitation to player
//   // Future<dynamic> invitePlayer(String mobNo, int teamId) async {
//   //   final token = await TokenManager.getToken();

//   //   Map<String, dynamic> entity = {};
//   //   try {
//   //     print("in post api$entity");
//   //     dio.options.headers['Authorization'] = 'Bearer $token';
//   //     final response = await dio.post(
//   //         '$baseUrl/Teams/Teams/invite?Mob_number=$mobNo&TeamId=$teamId',
//   //         data: entity);

//   //     print(entity);

//   //     // Assuming the response is a Map<String, dynamic>
//   //     // Map<String, dynamic> responseData = response.data;

//   //     return Future.delayed(Duration(seconds: 2), () => true);
//   //   } catch (e) {
//   //     throw Exception('Failed to Invite Player : $e');
//   //   }
//   // }

// // send invitation to player
  List<Map<String, dynamic>> invitedPlayers = [];

  bool _privateisInvited = false;
  bool get isInvited => _privateisInvited;
  setInvited(bool value) {
    _privateisInvited = value;
    notifyListeners();
  }

  // Future<dynamic> invitePlayer(String mobNo, int teamId) async {
  //   Map<String, dynamic> entity = {};
  //   teamrepo.invitePlayer(mobNo, teamId, entity).then(
  //     (value) {
  //       invitedPlayers = value.data;

  //       if (response == 'Invitation  Sent') {
  //         // Update invite status and show snack bar
  //         setState(() {
  //           isInvited = true;
  //         });
  //         _showCustomSnackBar2(context, 'Invitation sent successfully!', true);
  //       } else if (response == 'Invitation Already Sent') {
  //         // Update invite status and show snack bar
  //         setState(() {
  //           isInvited = true;
  //         });
  //         _showCustomSnackBar2(context, 'Invitation Already Sent!', false);
  //       } else {
  //         // Handle failed invite
  //         _showCustomSnackBar2(context, 'Failed to send invite.', false);
  //       }
  //     },
  //   ).onError(
  //     (error, stackTrace) {
  //       print('error is $error');
  //     },
  //   );
  // }
// // send invitation to team
//   Future<dynamic> inviteteam(int tournamentId, int teamId) async {
//     print("invite service method is calling");
//     final token = await TokenManager.getToken();

//     Map<String, dynamic> entity = {};
//     try {
//       print("in post API $entity");
//       dio.options.headers['Authorization'] = 'Bearer $token';
//       final response = await dio.post(
//         '$baseUrl/My_Tournament/My_Tournament/invite?tournamentId=$tournamentId&TeamId=$teamId',
//         data: entity,
//       );

//       print('Response status: ${response.statusCode}');
//       print('Response data: ${response.data}');

//       // Assuming the response data is a string indicating the invitation status
//       if (response.statusCode == 200) {
//         return response.data; // Return the actual response data
//       } else {
//         throw Exception('Failed to invite team: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Exception: $e');
//       return 'An error occurred'; // Return an error message or handle as needed
//     }
//   }

//   // update player tag (C,VC,Wk)
//   Future<void> updateTag({required String playerTag, required int id}) async {
//     final token = await TokenManager.getToken();

//     try {
//       dio.options.headers['Authorization'] = 'Bearer $token';

//       final response = await dio.put(
//         '$baseUrl/team/Register_team/updatetag?data=$playerTag&id=$id',
//       );

//       if (response.statusCode == 200) {
//         print("Player tag updated successfully");
//       } else {
//         print(
//             "Failed to update player tag: ${response.statusCode} - ${response.data}");
//       }
//     } catch (e) {
//       print("Error updating player tag: $e");
//     }
//   }

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<dynamic> getAllInvitedPlayers(String teamId) async {
    setLoading(true);

    teamrepo.getAllInvitedPlayers(teamId).then(
      (value) {
        List<dynamic> data =
            value.data; // Access the 'data' property of the response
        print('data-$data');

        List<Map<String, dynamic>> responseData =
            List<Map<String, dynamic>>.from(data);
        setLoading(false);

        return responseData;
      },
    ).onError(
      (error, stackTrace) {
        setLoading(false);

        print('error is $error');
        return []; // Return an empty list or handle the error appropriately
      },
    );
  }

// // send invitation to team
//   // Future<dynamic> inviteteam(String tournamentId, int teamId) async {
//   //   final token = await TokenManager.getToken();

//   //   Map<String, dynamic> entity = {};
//   //   try {
//   //     print("in post api$entity");
//   //     dio.options.headers['Authorization'] = 'Bearer $token';
//   //     final response = await dio.post(
//   //         '$baseUrl/My_Tournament/My_Tournament/invite?tournamentId=$tournamentId&TeamId=$teamId',
//   //         data: entity);

//   //     // print(entity);

//   //     // // Assuming the response is a Map<String, dynamic>
//   //     // Map<String, dynamic> responseData = response.data;

//   //     return Future.delayed(Duration(seconds: 2), () => true);
//   //   } catch (e) {
//   //     throw Exception('Failed to Invite Team : $e');
//   //   }
//   // }
}
