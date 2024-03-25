import 'package:dio/dio.dart';
import 'interceptor.dart';
import 'model01.dart';
import 'dart:convert';

class DioClient {
  final Dio _dio = Dio(
    BaseOptions(
      //  baseUrl: 'https://andronio.net/medidor/service',
      baseUrl: 'http://192.168.1.1',
      connectTimeout: Duration(seconds: 5),
      receiveTimeout: Duration(seconds: 5),
      responseType: ResponseType.json,
    ),
  );

  Future<DataApi?> getApi({String? url, String? upData}) async {
    DataApi? dataApi;
    String urlData = url! + '?data=' + upData!;
    try {
      Response respData = await _dio.get(urlData);

      print('User Info: ${respData.data}');

      dataApi = DataApi.fromJson(jsonDecode(respData.data));
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print('Dio error!');
        print('STATUS: ${e.response?.statusCode}');
        print('DATA: ${e.response?.data}');
        print('HEADERS: ${e.response?.headers}');
      } else {
        // Error due to setting up or sending the request
        print('Error sending request!');
        print(e.message);
      }
    }

    return dataApi;
  }

  Future<DataApi?> getApi01(
      {required String url, required DataApi request}) async {
    const JsonEncoder encoder = JsonEncoder();
    DataApi? answer; //respuesta
    dynamic jsonRequest = request.toJson();
    String stringRequest = encoder.convert(jsonRequest);
    String urlData = url + '?data=' + stringRequest;

    try {
      Response respData = await _dio.get(urlData);

      print('User Info: ${respData.data}');

      //  answer = DataApi.fromJson(jsonDecode(respData.data));
      answer = DataApi.fromJson(respData.data);
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print('Dio error!');
        print('STATUS: ${e.response?.statusCode}');
        print('DATA: ${e.response?.data}');
        print('HEADERS: ${e.response?.headers}');
        return DataApi(
            comando: request.comando,
            tipo: request.tipo,
            status: "Error",
            data: Data(
                funcion: "ErrorApi",
                status: "Error",
                data: '${e.response?.statusCode}'));
      } else {
        // Error due to setting up or sending the request
        print('Error sending request!');
        print(e.message);
        return DataApi(
            comando: request.comando,
            tipo: request.tipo,
            status: "Error",
            data: Data(funcion: "ErrorApi", status: "Null", data: 'e.message'));
      }
    }

    return answer;
  }

  Future<String> getApi02(
      {required String url, required DataApi request}) async {
    const JsonEncoder encoder = JsonEncoder();
    //  DataApi? answer;
    String? answer; //respuesta
    dynamic jsonRequest = request.toJson();
    String stringRequest = encoder.convert(jsonRequest);
    String urlData = url + '?data=' + stringRequest;

    try {
      Response respData = await _dio.get(urlData);

      print('User Info: ${respData.data}');
      answer = 'User Info: ${respData.data}';
      // answer = DataApi.fromJson(jsonDecode(respData.data));
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print('Dio error!');
        print('STATUS: ${e.response?.statusCode}');
        print('DATA: ${e.response?.data}');
        print('HEADERS: ${e.response?.headers}');
        return '${e.response?.statusCode}';
      } else {
        // Error due to setting up or sending the request
        print('Error sending request!');
        print(e.message);
        return "e.message";
      }
    }

    return answer;
  }

  Future<DataApi?> postApi01(
      {required String url, required DataApi request}) async {
    const JsonEncoder encoder = JsonEncoder();
    DataApi? answer; //respuesta
    dynamic jsonRequest = request.toJson();
    String stringRequest = encoder.convert(jsonRequest);
    print(stringRequest);

    try {
      Response response =
          await _dio.post(url, queryParameters: {'Data': stringRequest});

      print('User created: ${response.data}');

      answer = DataApi.fromJson(jsonDecode(response.data));
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print('Dio error!');
        print('STATUS: ${e.response?.statusCode}');
        print('DATA: ${e.response?.data}');
        print('HEADERS: ${e.response?.headers}');
        return DataApi(
            comando: request.comando,
            tipo: request.tipo,
            status: "Error",
            data: Data(
                funcion: "ErrorApi",
                status: "Error",
                data: '${e.response?.statusCode}'));
      } else {
        // Error due to setting up or sending the request
        print('Error sending request!');
        print(e.message);
        return DataApi(
            comando: request.comando,
            tipo: request.tipo,
            status: "Error",
            data: Data(funcion: "ErrorApi", status: "Null", data: 'e.message'));
      }
    }

    return answer;
  }

  Future<DataApi?> postApi(
      {required String url, required String upData}) async {
    DataApi? dataApi;

    try {
      Response response =
          await _dio.post(url, queryParameters: {'data': upData});

      print('User created: ${response.data}');

      dataApi = DataApi.fromJson(jsonDecode(response.data));
    } catch (e) {
      print('Error creating user: $e');
    }

    return dataApi;
  }

  Future<DataApi?> putApi({
    required DataApi upData,
  }) async {
    DataApi? updateddata;

    try {
      Response response = await _dio.put(
        '/apidata',
        data: upData.toJson(),
      );

      print('User updated: ${response.data}');

      updateddata = DataApi.fromJson(response.data);
    } catch (e) {
      print('Error updating user: $e');
    }

    return updateddata;
  }

  Future<void> deleteUser({required String id}) async {
    try {
      await _dio.delete('/users/$id');
      print('User deleted!');
    } catch (e) {
      print('Error deleting user: $e');
    }
  }
}

class ApiClient extends DioClient {
  // String myurl;
  // String mydato;
  static final ApiClient _singleton = ApiClient._internal();

  factory ApiClient() {
    return _singleton;
  }
  ApiClient._internal();
}
