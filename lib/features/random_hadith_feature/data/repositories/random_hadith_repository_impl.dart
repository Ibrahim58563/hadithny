import 'dart:developer';

import 'package:dartz/dartz.dart';

import '../../../../../../core/connection/network_info.dart';
import '../../../../../../core/errors/exceptions.dart';
import '../../../../../../core/errors/failure.dart';
import '../../../../../../core/params/params.dart';
import '../../business/repositories/random_hadith_repository.dart';
import '../datasources/random_hadith_local_data_source.dart';
import '../datasources/random_hadith_remote_data_source.dart';
import '../models/random_hadith_model.dart';

class RandomHadithRepositoryImpl implements RandomHadithRepository {
  final RandomHadithRemoteDataSource remoteDataSource;
  final RandomHadithLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  RandomHadithRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, RandomHadithModel>> getRandomHadith(
      {required RandomHadithParams randomHadithParams}) async {
    if (await networkInfo.isConnected!) {
      try {
        log("trying to get data from remote api");
        RandomHadithModel remoteRandomHadith = await remoteDataSource
            .getRandomHadith(randomHadithParams: randomHadithParams);

        localDataSource.cacheRandomHadith(
            randomHadithToCache: remoteRandomHadith);

        return Right(remoteRandomHadith);
      } on ServerException {
        return Left(ServerFailure(errorMessage: 'This is a server exception'));
      }
    } else {
      try {
        RandomHadithModel localRandomHadith =
            await localDataSource.getLastRandomHadith();
        return Right(localRandomHadith);
      } on CacheException {
        return Left(CacheFailure(errorMessage: 'This is a cache exception'));
      }
    }
  }
}
