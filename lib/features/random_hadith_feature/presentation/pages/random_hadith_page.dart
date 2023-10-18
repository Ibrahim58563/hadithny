import 'package:flutter/material.dart';
import 'package:hadithny/core/errors/failure.dart';
import 'package:hadithny/features/random_hadith_feature/business/entities/random_hadith_entity.dart';
import 'package:hadithny/features/random_hadith_feature/presentation/providers/random_hadith_provider.dart';
import 'package:provider/provider.dart';
import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart' as dom;

class RandomHadithPage extends StatefulWidget {
  const RandomHadithPage({Key? key}) : super(key: key);

  @override
  State<RandomHadithPage> createState() => _RandomHadithPageState();
}

class _RandomHadithPageState extends State<RandomHadithPage> {
  @override
  void initState() {
    super.initState();
  }

  String removeHtmlTags(String htmlString) {
    // Regular expression to match HTML tags
    final RegExp exp = RegExp(r"<[^>]*>");

    // Use the replaceAll method to remove HTML tags
    return htmlString.replaceAll(exp, '');
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await Provider.of<RandomHadithProvider>(context, listen: false)
            .eitherFailureOrRandomHadith();
      },
      child: FutureBuilder(
        future: Provider.of<RandomHadithProvider>(context, listen: false)
            .eitherFailureOrRandomHadith(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              // Handle error

              throw Exception(snapshot.error);
            } else {
              // Provider data is available
              final randomHadithEntity =
                  Provider.of<RandomHadithProvider>(context).randomHadithEntity;
              final hadith = removeHtmlTags(randomHadithEntity!.hadithBody);
              print(hadith);
              if (randomHadithEntity != null) {
                return Scaffold(
                  backgroundColor: Colors.black,
                  appBar: AppBar(
                    centerTitle: true,
                    title: const Text(
                      "Random Hadith",
                    ),
                  ),
                  body: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: Center(
                        child: Text(
                          hadith,
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                );
              } else {
                return Scaffold(
                  backgroundColor: Colors.black,
                  appBar: AppBar(
                    title: const Text("Random Hadith"),
                  ),
                  body: const Center(
                    child: Text('Random Hadith'),
                  ),
                );
              }
            }
          } else {
            // Loading indicator
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
