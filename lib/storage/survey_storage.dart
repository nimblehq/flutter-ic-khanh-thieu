import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:survey_flutter/model/survey_model.dart';

const String surveysBoxKey = 'surveys';
Box<SurveyModel>? surveysBox;

Future<void> setupHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(SurveyModelAdapter());
}

final surveyStorageProvider = Provider((ref) {
  _setupBox();
  ref.onDispose(() {
    surveysBox?.close();
  });
  return SurveyStorageImpl();
});

void _setupBox() async {
  surveysBox = await Hive.openBox(surveysBoxKey);
}

abstract class SurveyStorage {
  Future<void> saveSurveys(List<SurveyModel> surveys);

  Future<List<SurveyModel>> getSurveys();

  Future<int> clear();
}

class SurveyStorageImpl extends SurveyStorage {
  @override
  Future<void> saveSurveys(List<SurveyModel> surveys) async {
    await surveysBox?.addAll(surveys);
  }

  @override
  Future<List<SurveyModel>> getSurveys() async {
    final surveys = surveysBox?.values.toList();
    return surveys ?? List.empty();
  }

  @override
  Future<int> clear() async {
    return await surveysBox?.clear() ?? 0;
  }
}
