abstract class Serializable {}

abstract class Serializer<T extends Serializable> {
  T serialize(Map<String, dynamic> json);
}
