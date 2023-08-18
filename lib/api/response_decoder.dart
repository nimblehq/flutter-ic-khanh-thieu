import 'package:japx/japx.dart';

class ResponseDecoder {
  static Map<String, dynamic> decodeData(Map<String, dynamic> json) {
    return Japx.decode(json)['data'];
  }

  static Map<String, dynamic> decode(Map<String, dynamic> json) =>
      Japx.decode(json);
}
