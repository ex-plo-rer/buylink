import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart';
// import 'package:logging/logging.dart';

import '../../core/constants/strings.dart';
import '../base/network_exception.dart';
import 'package:http/http.dart' as http;

class NetworkService {
  // final log = Logger('HttpService');

  void throwExceptionOnFail(http.Response response) {
    if (response.statusCode != 200 && response.statusCode != 201) {
      print('response.body ${response.body}');
      print('response.statusCode ${response.statusCode}');
      throw NetworkException(
        jsonDecode(response.body)['message'],
        error: jsonDecode(response.body)['data'],
        // errors: jsonDecode(response.body)['data'],
        statusCode: response.statusCode,
      );
    }
  }

  Future<dynamic> get(String url, {Map<String, String>? headers}) async {
    try {
      print('${AppStrings.API_BASE_URL}/$url');
      var response = await http
          .get(
            Uri.parse('${AppStrings.API_BASE_URL}/$url'),
            headers: headers,
          )
          .timeout(Duration(minutes: 2));

      throwExceptionOnFail(response);
      return jsonDecode(response.body);
    } on TimeoutException {
      print('Request timeout');
      throw NetworkException('Request timeout');
    } on SocketException {
      throw NetworkException('There is no internet');
    } on HttpException {
      throw NetworkException('There is an http exception');
    } on FormatException {
      throw NetworkException('There is a format exception');
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> post(
    String url, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) async {
    try {
      var response = await http
          .post(
            Uri.parse('${AppStrings.API_BASE_URL}/$url'),
            body: jsonEncode(body),
            headers: headers,
          )
          .timeout(Duration(minutes: 2));

      print(Uri.parse('${AppStrings.API_BASE_URL}/$url'));

      throwExceptionOnFail(response);
      return jsonDecode(response.body);
    } on TimeoutException {
      print('Request timeout');
      throw NetworkException('Request timeout');
    } on SocketException {
      throw NetworkException('There is no internet');
    } on HttpException {
      throw NetworkException('There is an http exception');
    } on FormatException {
      throw NetworkException('There is a format exception');
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> put(
    String url, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) async {
    try {
      var response = await http
          .put(
            Uri.parse('${AppStrings.API_BASE_URL}/$url'),
            body: jsonEncode(body),
            headers: headers,
          )
          .timeout(Duration(minutes: 2));

      print(Uri.parse('${AppStrings.API_BASE_URL}/$url'));

      throwExceptionOnFail(response);
      return jsonDecode(response.body);
    } on TimeoutException {
      print('Request timeout');
      throw NetworkException('Request timeout');
    } on SocketException {
      throw NetworkException('There is no internet');
    } on HttpException {
      throw NetworkException('There is an http exception');
    } on FormatException {
      throw NetworkException('There is a format exception');
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> postMultipart(
    String url, {
    Map<String, dynamic>? files,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) async {
    try {
      var request = http.MultipartRequest(
          "POST", Uri.parse('${AppStrings.API_BASE_URL}/$url'));

      request.headers.addAll(headers!);

      if (body != null) {
        for (var data in body.entries) {
          // if (data.value.runtimeType == int) {
          //   data.value.toString();
          //   // print('${data.key} ######## ${data.value}');
          //   // request.fields[data.key] = data.value;
          // }
          print('${data.key} ######## ${data.value}');
          request.fields[data.key] = data.value.toString();
        }
      }

      if (files != null) {
        for (var data in files.entries) {
          if (data.value != null) {
            print('${data.key} ######## ${data.value}');
            request.files.add(await http.MultipartFile.fromPath(
              data.key,
              data.value,
              // contentType: new MediaType('application', 'x-tar'),
            ));
          }
        }
      }

      final http.StreamedResponse streamedResponse = await request.send();

      var response = await http.Response.fromStream(streamedResponse)
          .timeout(Duration(minutes: 2));

      throwExceptionOnFail(response);
      return jsonDecode(response.body);
    } on TimeoutException {
      print('Request timeout');
      throw NetworkException('Request timeout');
    } on SocketException {
      throw NetworkException('There is no internet');
    } on HttpException {
      throw NetworkException('There is an http exception');
    } on FormatException {
      throw NetworkException('There is a format exception');
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> delete(
    String url, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) async {
    try {
      var response = await http
          .delete(
            Uri.parse('${AppStrings.API_BASE_URL}/$url'),
            body: jsonEncode(body),
            headers: headers,
          )
          .timeout(Duration(minutes: 2));

      throwExceptionOnFail(response);
      return jsonDecode(response.body);
    } on TimeoutException {
      print('Request timeout');
      throw NetworkException('Request timeout');
    } on SocketException {
      throw NetworkException('There is no internet');
    } on HttpException {
      throw NetworkException('There is an http exception');
    } on FormatException {
      throw NetworkException('There is a format exception');
    } catch (e) {
      rethrow;
    }
  }
}

final networkServiceProvider = Provider((ref) => NetworkService());
