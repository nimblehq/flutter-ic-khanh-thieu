import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:survey_flutter/api/response_decoder.dart';
import 'package:survey_flutter/model/meta_model.dart';

part 'meta_response.g.dart';

@JsonSerializable()
class MetaResponse {
  final int? page;
  final int? pages;
  final int? pageSize;
  final int? records;

  MetaResponse({
    required this.page,
    required this.pages,
    required this.pageSize,
    required this.records,
  });

  factory MetaResponse.fromJson(Map<String, dynamic> json) =>
      _$MetaResponseFromJson(ResponseDecoder.decode(json));

  MetaModel toMetaModel() => MetaModel(
        page: page ?? 0,
        pages: pages ?? 0,
        pageSize: pageSize ?? 0,
        records: records ?? 0,
      );
}
