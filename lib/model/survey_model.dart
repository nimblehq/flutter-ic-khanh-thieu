import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'survey_model.g.dart';

@HiveType(typeId: 0)
class SurveyModel extends Equatable {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final String coverImageUrl;

  const SurveyModel({
    required this.id,
    required this.title,
    required this.description,
    required this.coverImageUrl,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        coverImageUrl,
      ];

  SurveyModel toSurveyModel() => SurveyModel(
        id: id,
        title: title,
        description: description,
        coverImageUrl: coverImageUrl,
      );

  const SurveyModel.dummy()
      : this(
          id: "id",
          title: "title",
          description: "description",
          coverImageUrl: "coverImageUrl",
        );
}
