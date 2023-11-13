import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:pharma_clients_app/data/network/base_api_services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../app_excaptions.dart';

class NetworkApiServices extends BaseApiServices {

  @override
  Future deleteApiResponse(String url) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? token = sp.getString('token');

    dynamic responseJson;
    try {
      Client client = InterceptedClient.build(interceptors: [LoggingInterceptor()],);

      final response = await client.delete(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          "Authorization": "Bearer ${token ?? ''}"
        },
      );
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  @override
  Future getApiResponse(String url) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? token = sp.getString('token');

    dynamic responseJson;
    try {
      Client client = InterceptedClient.build(interceptors: [LoggingInterceptor()]);

      final response = await client.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        "Authorization": "Bearer ${token ?? ''}"});
      // }).timeout(const Duration(seconds: 20));

      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  @override
  Future postApiResponse(String url, data) async {
    dynamic responseJson;
    try {
      Client client = InterceptedClient.build(interceptors: [LoggingInterceptor()]);

      final sp = await SharedPreferences.getInstance();
      String? token = sp.getString('token');

      final response = await client.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          "Authorization": "Bearer ${token ?? ''}"
        },
        body: data != null ? jsonEncode(data.toJson()): '',
      );

      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  @override
  Future postEmptyParmApiResponse(String url, bodyParms) async {
    final sp = await SharedPreferences.getInstance();
    String? token = sp.getString('token');

    dynamic responseJson;
    try {
      Client client = InterceptedClient.build(interceptors: [LoggingInterceptor()]);

      final response = await client.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          "Authorization": "Bearer ${token ?? ''}"
        },
        body: bodyParms.isNotEmpty ? jsonEncode(bodyParms.toJson()) : '',
      );

      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  @override
  Future putApiResponse(String url, bodyParms) async {
    //
    // final sp = await SharedPreferences.getInstance();
    // String? token = sp.getString('token');

    dynamic responseJson;
    try {
      final client =
          InterceptedClient.build(interceptors: [LoggingInterceptor()]);

      final response = await client.put(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json', "Authorization": ""},
        body: jsonEncode(bodyParms.toJson()),
      );
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  dynamic _returnResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        return responseJson;

      case 400:
        var responseJson = json.decode(response.body.toString());
        return responseJson;

      case 401:
        var responseJson = json.decode(response.body.toString());
        return responseJson;

      case 403:
        var responseJson = json.decode(response.body.toString());
        return responseJson;

      case 404:
        var responseJson = json.decode(response.body.toString());
        return responseJson;

      case 422:
        var responseJson = json.decode(response.body.toString());
        return responseJson;

      case 500:
        var responseJson = json.decode(response.body.toString());
        return responseJson;

      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}

class LoggingInterceptor implements InterceptorContract {
  @override
  Future<BaseRequest> interceptRequest({required BaseRequest request}) async {
    if (kDebugMode) {
      print("----- Request -----");
      log('Url hit: ${request.url}');
    //  log('Required: ${data.body}');
    }
    return request;
  }

  @override
  Future<BaseResponse> interceptResponse({required BaseResponse response}) async {
    if (kDebugMode) {
      print("------- Response -------");
      print(response.toString());
    }
    return response;
  }

  Future<bool> shouldInterceptRequest() async => true;

  Future<bool> shouldInterceptResponse() async => true;

}