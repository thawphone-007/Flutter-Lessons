import 'dart:convert';

import 'package:dio/dio.dart';
import '../../const/api_const.dart';
import '../models/request_model.dart';
import '../models/response_model.dart';

class ChatApiServices {
  final Dio _dio = Dio();

  Future<ResponseModel> sendChat({required RequestModel requestModel}) async {
    final response = await _dio.post(
      ApiConst.baseUrl,
      options: Options(headers: {"Content-Type": "application/json"}),
      data: requestModel,
    );
    return ResponseModel.fromJson(response.data);
  }

  Stream<ResponseModel> sendChatStream({
    required RequestModel requestModel,
  }) async* {
    final response = await _dio.post<ResponseBody>(
      ApiConst.baseUrl,
      options: Options(
        headers: {"Content-Type": "application/json"},
        responseType: ResponseType.stream,
      ),
      data: requestModel,
    );

    final lines = response.data!.stream
        .cast<List<int>>()
        .transform(utf8.decoder)
        .transform(LineSplitter());

    await for (String line in lines) {
      if (line.trim().isEmpty) continue;
      yield ResponseModel.fromJson(jsonDecode(line));
    }
  }
}
