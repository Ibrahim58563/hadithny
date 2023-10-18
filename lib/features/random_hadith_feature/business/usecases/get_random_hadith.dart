import 'package:dartz/dartz.dart';

import '../../../../../../core/errors/failure.dart';
import '../../../../../../core/params/params.dart';
import '../entities/random_hadith_entity.dart';
import '../repositories/random_hadith_repository.dart';

class GetRandomHadith {
  final RandomHadithRepository randomHadithRepository;

  GetRandomHadith({required this.randomHadithRepository});

  Future<Either<Failure, RandomHadithEntity>> call({
    required RandomHadithParams randomHadithParams,
  }) async {
    return await randomHadithRepository.getRandomHadith(
        randomHadithParams: randomHadithParams);
  }
}
