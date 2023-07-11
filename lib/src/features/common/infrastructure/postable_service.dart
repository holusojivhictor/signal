import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:signal/src/features/common/domain/models/models.dart';

class PostableService {
  PostableService({
    Dio? dio,
    this.authority = 'vbatest.metrdev.com:2472',
  }) : _dio = dio ?? Dio();

  final Dio _dio;
  @protected
  final String authority;

  @protected
  Future<bool> performDefaultPost(
    Uri uri,
    PostDataMixin data, {
    String? cookie,
    bool Function(String?)? validateLocation,
  }) async {
    try {
      final response = await performPost<void>(
        uri,
        data,
        cookie: cookie,
        validateStatus: (int? status) => status == HttpStatus.ok,
      );

      if (validateLocation != null) {
        return validateLocation(response.headers.value('location'));
      }

      return true;
    } on ServiceException {
      return false;
    }
  }

  @protected
  Future<Response<T>> performPost<T>(
    Uri uri,
    PostDataMixin data, {
    String? cookie,
    ResponseType? responseType,
    bool Function(int?)? validateStatus,
  }) async {
    try {
      return await _dio.postUri<T>(
        uri,
        data: data.toJson(),
        options: Options(
          headers: <String, dynamic>{if (cookie != null) 'cookie': cookie},
          responseType: responseType,
          contentType: Headers.jsonContentType,
          validateStatus: validateStatus,
        ),
      );
    } on DioException catch (e) {
      throw ServiceException(e.message);
    }
  }
}
