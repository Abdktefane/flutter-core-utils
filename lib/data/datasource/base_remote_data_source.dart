// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:tawreed_customer/common/data/models/netwrok/base_response_model.dart';
// import 'package:tawreed_customer/common/data/models/netwrok/list_base_response_model.dart';
// import 'package:tawreed_customer/common/data/models/netwrok/pagination_response.dart';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

enum METHOD { GET, POST, PUT, DELETE }

typedef Mapper<T> = T Function(Object?);

abstract class BaseRemoteDataSource {
  Future<Response> performGetRequest({
    required String endpoint,
    Map<String, dynamic>? params,
    Options? options,
  });

  Future<Response> performPostRequest({
    required String endpoint,
    required data,
    Map<String, dynamic>? params,
    Options? options,
  });

  Future<Response> performPutRequest({
    required String endpoint,
    required data,
    Map<String, dynamic>? params,
    Options? options,
  });

  Future<Response> performDeleteRequest({
    required String endpoint,
    Map<String, dynamic>? params,
    Options? options,
  });

  Map<String, dynamic> wrapWithBaseData(dynamic data);
}
