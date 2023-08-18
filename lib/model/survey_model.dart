import 'package:equatable/equatable.dart';

class SurveyModel extends Equatable {
  final String id;
  final String title;
  final String description;
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
}
