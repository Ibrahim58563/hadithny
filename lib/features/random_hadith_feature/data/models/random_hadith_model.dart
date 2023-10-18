import '../../../../../../core/constants/constants.dart';
import '../../business/entities/random_hadith_entity.dart';

class RandomHadithModel extends RandomHadithEntity {
  const RandomHadithModel({
    required super.chapterTitle,
    required super.hadithBody,
  });

  factory RandomHadithModel.fromJson({required Map<String, dynamic> json}) {
    final hadith = json['hadith'][1];
    return RandomHadithModel(
      chapterTitle: hadith[KChapterTitle],
      hadithBody: hadith[Kbody],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      KChapterTitle: chapterTitle,
      Kbody: hadithBody,
    };
  }
}
