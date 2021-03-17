extension ListExtension<T> on List<T> {
  bool get isNullOrEmpty => this == null || isEmpty;
}
