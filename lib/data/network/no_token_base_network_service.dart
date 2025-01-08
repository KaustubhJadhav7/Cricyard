abstract class NoTokenBaseNetworkService {
  Future<dynamic> getGetApiResponse(String? url);
  Future<dynamic> getPostApiResponse(String? url, dynamic body);
  Future<dynamic> getPutApiResponse(String? url, dynamic body);

  Future<dynamic> getDeleteApiResponse(String? url);
}
