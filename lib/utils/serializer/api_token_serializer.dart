import 'package:survey_flutter/model/api_token.dart';
import 'package:survey_flutter/utils/serializer/serializable.dart';

class ApiTokenSerializer extends Serializer<ApiToken> {
  @override
  ApiToken serialize(Map<String, dynamic> json) {
    return ApiToken.fromJson(json);
  }
}
