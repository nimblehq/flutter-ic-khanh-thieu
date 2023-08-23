abstract class Serializable {}

abstract class Serializer<T extends Serializable> {
  T fromJson(Map<String, dynamic> json);
}
