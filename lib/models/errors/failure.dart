class Failure {
  // Use something like "int code;" if you want to translate error messages
  int? code;
  final String message;

  Failure(this.message, {this.code});

  @override
  String toString() => message;
}
