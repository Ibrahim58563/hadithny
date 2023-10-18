import 'package:data_connection_checker_tv/data_connection_checker.dart';

import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:hadithny/features/random_hadith_feature/business/repositories/random_hadith_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../../core/connection/network_info.dart';
import '../../../../../../core/errors/failure.dart';
import '../../../../../../core/params/params.dart';
import '../../business/entities/random_hadith_entity.dart';
import '../../business/usecases/get_random_hadith.dart';
import '../../data/datasources/random_hadith_local_data_source.dart';
import '../../data/datasources/random_hadith_remote_data_source.dart';
import '../../data/repositories/random_hadith_repository_impl.dart';

class RandomHadithProvider extends ChangeNotifier {
  RandomHadithEntity? randomHadithEntity;
  Failure? failure;

  RandomHadithProvider({
    this.randomHadithEntity,
    this.failure,
  });

  Future<void> eitherFailureOrRandomHadith() async {
    RandomHadithRepositoryImpl randomHadithRepositoryImpl =
        RandomHadithRepositoryImpl(
      remoteDataSource: RandomHadithRemoteDataSourceImpl(
        dio: Dio(),
      ),
      localDataSource: RandomHadithLocalDataSourceImpl(
        sharedPreferences: await SharedPreferences.getInstance(),
      ),
      networkInfo: NetworkInfoImpl(
        DataConnectionChecker(),
      ),
    );

    final failureOrRandomHadith = await GetRandomHadith(
            randomHadithRepository: randomHadithRepositoryImpl)
        .call(
      randomHadithParams: RandomHadithParams(
        chapterNumber: randomHadithEntity?.chapterTitle,
        hadithBody: randomHadithEntity?.hadithBody,
      ),
    );

    failureOrRandomHadith.fold(
      (Failure newFailure) {
        randomHadithEntity = null;
        failure = newFailure;
        notifyListeners();
      },
      (RandomHadithEntity newRandomHadith) {
        randomHadithEntity = newRandomHadith;
        failure = null;
        notifyListeners();
      },
    );
  }
}
