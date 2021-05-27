class HttpsException implements Exception {
  final String message;

  HttpsException(this.message); // Pass your message in constructor.

  @override
  String toString() {
    return message;
  }
}
