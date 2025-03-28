abstract class BaseApiServices {
  Future<dynamic> getGetApiRequest(
    String url, {
    Map<String, String>? headers, // ✅ Optional headers
    Map<String, String>? queryParameters, // ✅ Optional query params
  });
  Future<dynamic> getPostApiRequest(
      String url, Map<String, dynamic> header, Map<String, dynamic> body);
}
