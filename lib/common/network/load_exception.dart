sealed class LoadException implements Exception {
  const LoadException();
}

// In the browser a response without CORS headers also ends up here.
final class NoConnectionException extends LoadException {
  const NoConnectionException();
}

final class TimeoutLoadException extends LoadException {
  const TimeoutLoadException();
}

final class NotFoundException extends LoadException {
  const NotFoundException();
}

// CoinGecko's free plan allows only a few requests per minute.
final class TooManyRequestsException extends LoadException {
  const TooManyRequestsException();
}

final class ServerException extends LoadException {
  const ServerException(this.statusCode);

  final int? statusCode;
}

final class BadResponseException extends LoadException {
  const BadResponseException();
}
