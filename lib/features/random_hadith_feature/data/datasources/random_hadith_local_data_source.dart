import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../../core/errors/exceptions.dart';
import '../models/random_hadith_model.dart';

abstract class RandomHadithLocalDataSource {
  Future<void> cacheRandomHadith(
      {required RandomHadithModel? randomHadithToCache});
  Future<RandomHadithModel> getLastRandomHadith();
}

const cachedRandomHadith = 'CACHED_RANDOM_HADITH';

class RandomHadithLocalDataSourceImpl implements RandomHadithLocalDataSource {
  final SharedPreferences sharedPreferences;

  RandomHadithLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<RandomHadithModel> getLastRandomHadith() {
    final jsonString = sharedPreferences.getString(cachedRandomHadith);

    if (jsonString != null) {
      return Future.value(
          RandomHadithModel.fromJson(json: json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheRandomHadith(
      {required RandomHadithModel? randomHadithToCache}) async {
    if (randomHadithToCache != null) {
      sharedPreferences.setString(
        cachedRandomHadith,
        json.encode(
          randomHadithToCache.toJson(),
        ),
      );
    } else {
      throw CacheException();
    }
  }
}
