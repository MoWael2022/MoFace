import 'package:dio/dio.dart';

Future<T> handleDioError<T>(Future<T> Function() request) async {
  try {
    return await request();
  } on DioException catch (e) {
    //print(e.response.runtimeType);
    if (e.response != null ) {
      print("here");
      print(e.response!.statusCode);
      throw Exception('${e.response!.data}');
    } else if (e.type == DioExceptionType.connectionTimeout) {
      // Connection timeout
      // print('Connection Timeout Exception');
      throw Exception('Connection Timeout');
    } else if (e.type == DioExceptionType.sendTimeout) {
      // Send timeout
      // print('Send Timeout Exception');
      throw Exception('Send Timeout');
    } else if (e.type == DioExceptionType.receiveTimeout) {
      // Receive timeout
      // print('Receive Timeout Exception');
      throw Exception('Receive Timeout');
    } else if (e.type == DioExceptionType.cancel) {
      // Request was cancelled
      // print('Request Cancelled Exception');
      throw Exception('Request Cancelled');
    } else if (e.type == DioExceptionType.badResponse) {
      // Handle bad request error
      // print('Bad Request Exception');
      throw Exception('Bad Request: ${e.message}');
    } else {
      // Handle other Dio errors
      // print('DioError: ${e.message}');
      //print(e.response!.statusCode);
      print(e.error);
      throw Exception(e);
    }
  } catch (e) {
    // Handle other types of exceptions
    //print('General Exception: $e');
    throw Exception(e);
  }
}
