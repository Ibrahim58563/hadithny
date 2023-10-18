import 'dart:developer';

import 'package:dio/dio.dart';
import '../../../../../../core/errors/exceptions.dart';
import '../../../../../../core/params/params.dart';
import '../models/random_hadith_model.dart';

abstract class RandomHadithRemoteDataSource {
  Future<RandomHadithModel> getRandomHadith(
      {required RandomHadithParams randomHadithParams});
}

class RandomHadithRemoteDataSourceImpl implements RandomHadithRemoteDataSource {
  final Dio dio;

  RandomHadithRemoteDataSourceImpl({required this.dio});

  @override
  Future<RandomHadithModel> getRandomHadith(
      {required RandomHadithParams randomHadithParams}) async {
    dio.options.headers['X-API-Key'] =
        'SqD712P3E82xnwOAEOkGd5JZH8s9wRR24TqNFzjk';
    final response = await dio.get(
      'https://api.sunnah.com/v1/hadiths/random',
      queryParameters: {
        // 'X-API-Key': 'SqD712P3E82xnwOAEOkGd5JZH8s9wRR24TqNFzjk',
      },
    );

    if (response.statusCode == 200) {
      log("data should come here");
      print(response.data);
      return RandomHadithModel.fromJson(json: response.data);
    } else {
      throw ServerException();
    }
  }
}
