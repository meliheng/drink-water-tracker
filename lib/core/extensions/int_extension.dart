extension IntExtension on int? {
  String get toStringFormat {
    if (this == null) {
      return "";
    } else {
      return toString();
    }
  }
}
