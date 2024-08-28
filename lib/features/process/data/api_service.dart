import 'package:dio/dio.dart';

import '../../../core/index.dart';
import '../index.dart';

abstract class ProcessApiService {
  Future<List<SendResult>> sendData(List<Map<String, dynamic>> data);
}

class ProcessApiServiceImpl implements ProcessApiService {
  @override
  Future<List<SendResult>> sendData(List<Map<String, dynamic>> data) async {
    const sendUrl = baseUrl;
    try {
      final response = await Dio().post(sendUrl, data: data);

      if (response.statusCode == 200) {
        return (response.data['data'] as List)
            .map((i) => SendResult.fromJson(i))
            .toList();
      }
      throw 'error';
    } catch (_) {
      throw 'error';
    }
  }
}
