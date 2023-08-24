import 'package:japx/japx.dart';

class ResponseDecoder {
  static Map<String, dynamic> decodeData(Map<String, dynamic> json) {
    return json.containsKey('data') ? Japx.decode(json)['data'] : json;
  }

  static Map<String, dynamic> decode(Map<String, dynamic> json) {
    return Japx.decode(json);
  }
}
