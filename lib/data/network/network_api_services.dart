import 'dart:convert';
import 'dart:io';
import 'package:BookMate_Pro/data/app_exception.dart';
import 'package:BookMate_Pro/data/network/base_api_services.dart';
import 'package:http/http.dart' as http;

class NetworkApiServices extends BaseApiServices {
  @override
  Future getGetApiRequest(
    String url, {
    Map<String, String>? headers,
    Map<String, String>? queryParameters,
  }) async {
    dynamic apiResponse;
    try {
      Uri uri = Uri.parse(url);
      if (queryParameters != null && queryParameters.isNotEmpty) {
        uri = uri.replace(queryParameters: queryParameters);
      }
      final http.Response response =
          await http.get(uri, headers: headers).timeout(
                const Duration(seconds: 15),
              );

      apiResponse = checkAndReturnResponse(response);
    } on SocketException {
      throw FetchDataException('No internet connection!');
    }
    return apiResponse;
  }

  @override
  Future getPostApiRequest(
    String url,
    Map<String, dynamic> header,
    Map<String, dynamic> body,
  ) async {
    dynamic apiResponse;
    try {
      final http.Response response = await http.post(
        Uri.parse(url),
        headers: header.map((key, value) => MapEntry(key, value.toString())),
        body: jsonEncode(body),
      );

      apiResponse = checkAndReturnResponse(response);
    } on SocketException {
      throw FetchDataException('No internet Connection!');
    }
    return apiResponse;
  }
}

dynamic checkAndReturnResponse(http.Response response) {
  switch (response.statusCode) {
    case 200:
      var jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    case 400:
      // Handle bad request error
      throw BadRequestException('Bad request Response: ${response.body}');
    case 401:
    case 403:
      throw UnauthorizedRequestException('Unauthorized request Exception!');
    case 500:
    default:
      throw FetchDataException(
          'Error during communication with statusCode: ${response.statusCode} Response: ${response.body}');
  }
}
