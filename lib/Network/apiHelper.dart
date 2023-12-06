import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiHelper {
  Future postApi(BuildContext context, String url, String params) async {
    print('Api post, url $url');
    var responseJson;
    try {
      final response = await http.post(Uri.parse(url),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json'
          },
          body: params);

      responseJson = _returnResponse(response);
    } catch (e) {
      print(e.toString());
    }
    print('api get recieved!');
    return responseJson;
  }

  dynamic _returnResponse(http.Response response) {
    String responseJson;

    switch (response.statusCode) {
      case 200:
        responseJson = response.body;
        print(responseJson);
        return response;
      case 201:
        responseJson = response.body;
        print(responseJson);
        return response;
      case 400:
        responseJson = response.body;
        print(responseJson);
        return response;
        break;
      case 401:
        return response;

      case 404:
        responseJson = response.body;
        print(responseJson);
        return response;

        break;
      case 422:
        return response;

        break;
      case 401:
        responseJson = response.body;
        print(responseJson);

        return response;

        break;
      case 403:
        return response;
        break;

      case 500:
        return response;
      default:
        return response;
    }
  }
}

