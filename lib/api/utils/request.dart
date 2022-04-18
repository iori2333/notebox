import 'package:dio/dio.dart';

final client = Dio();

class Error {
  final String message;
  final int statusCode;

  Error(this.statusCode, this.message);
}

typedef ResponseType = Result<Map<String, dynamic>, Error>;

class Result<T, E> {
  final T? _data;
  final E? _err;

  Result.ok(T data)
      : _data = data,
        _err = null;

  Result.err(E err)
      : _data = null,
        _err = err;

  bool get isOk => _err == null;

  T get data => _data!;
  E get err => _err!;
}

Future<ResponseType> request(String path, Map<String, dynamic> params,
    [String method = "get"]) async {
  final res = await client.request(
    path,
    data: params,
    options: Options(method: method),
  );
  if (res.statusCode == 200) {
    return Result.ok(res.data);
  } else {
    return Result.err(Error(
      res.statusCode ?? 500,
      res.statusMessage ?? "Unknown error",
    ));
  }
}
