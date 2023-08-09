import 'package:japx/japx.dart';

Map<String, dynamic> decode(Map<String, dynamic> json) {
  return Japx.decode(json)['data'];
}
