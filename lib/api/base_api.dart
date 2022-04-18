import 'package:dio/dio.dart';

abstract class NetworkApi {
  NetworkApi();

  Future<Map<String, dynamic>> makeRequest(
    String path, [
    Map<dynamic, dynamic> params = const {},
  ]) async {
    final requestParams =
        params.map((key, value) => MapEntry(key.toString(), value.toString()));
    return {
      'path': path,
      'params': params,
    };
  }
}
