extension DoubleExtension on double? {
  String get toStringFormat {
    if (this == null) {
      return "";
    } else {
      return this!.toStringAsFixed(1);
    }
  }
}
