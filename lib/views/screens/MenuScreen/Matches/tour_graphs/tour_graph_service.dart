// import 'package:fl_chart/fl_chart.dart';
// import '../../../../../utilities/make_api_request.dart';


// class TourGraphService {
//   Future<List<FlSpot>> fetchDataFromApi(int matchId) async {
//     try {
//       final res = await dio.get('$baseUrl/token/Practice/score/everyOver/$matchId');
//       print("OVERS-DATA--${res.data}");

//       if (res.statusCode == 200) {
//         if (res.data is Map) {
//           final List<FlSpot> result = [];

//           (res.data as Map).forEach((overNumber, overData) {
//             if (overData is Map<String, dynamic>) {
//               final int over = int.parse(overNumber); // Convert the overNumber to int
//               final double totalRuns = (overData['totalRun'] as num?)?.toDouble() ?? 0.0; // Convert totalRun to double

//               result.add(FlSpot(over.toDouble(), totalRuns));
//             }
//           });

//           print("FINAL-DATA--$result");
//           return result;
//         } else {
//           print("Error: Response data is not a Map");
//         }
//       } else {
//         print("Error Fetching everyOver: ${res.statusCode}");
//       }
//     } catch (e) {
//       print("Error fetching scoreboard: $e");
//     }
//     return [];
//   }
// }
import 'package:fl_chart/fl_chart.dart';
import '../../../../../utilities/make_api_request.dart';
import 'package:cricyard/data/network/network_api_service.dart';
  // Import your NetworkApiService

class TourGraphService {
  final NetworkApiService _networkApiService = NetworkApiService(); // Use the instance of NetworkApiService

  Future<List<FlSpot>> fetchDataFromApi(int matchId) async {
    try {
      // Using NetworkApiService to make the GET request
      final response = await _networkApiService.getGetApiResponse('$baseUrl/token/Practice/score/everyOver/$matchId');

      if (response != null && response is Map) {
        final List<FlSpot> result = [];

        // Process the response data
        (response as Map).forEach((overNumber, overData) {
          if (overData is Map<String, dynamic>) {
            final int over = int.parse(overNumber); // Convert overNumber to int
            final double totalRuns = (overData['totalRun'] as num?)?.toDouble() ?? 0.0; // Convert totalRun to double

            result.add(FlSpot(over.toDouble(), totalRuns));
          }
        });

        print("FINAL-DATA--$result");
        return result;
      } else {
        print("Error: Response data is not a Map or is null");
      }
    } catch (e) {
      print("Error fetching scoreboard: $e");
    }
    return [];
  }
}
