import 'package:dartz/dartz.dart';
import 'package:hadithny/core/errors/failure.dart';
import 'package:hadithny/core/params/params.dart';
import '../entities/random_hadith_entity.dart';

abstract class RandomHadithRepository {
  Future<Either<Failure, RandomHadithEntity>> getRandomHadith({
    required RandomHadithParams randomHadithParams,
  });
}
