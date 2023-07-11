class ServiceException implements Exception {
  ServiceException([this.message]);

  final String? message;

  @override
  String toString() {
    var result = 'ServiceException';
    if (message != null) {
      result = '$result: $message';
    }
    return result;
  }
}
