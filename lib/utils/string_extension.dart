extension StringExtension on String? {
  String unWrappedOr(String fallback) => this ?? fallback;
  String orEmpty() => unWrappedOr('');
}
