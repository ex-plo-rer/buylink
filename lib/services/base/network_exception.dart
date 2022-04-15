class NetworkException {
  final int? statusCode;
  final String? error;
  // final Map? errors;
  final String message;

  NetworkException(
      this.message, {
        this.statusCode,
        this.error,
        // this.errors,
      });
}