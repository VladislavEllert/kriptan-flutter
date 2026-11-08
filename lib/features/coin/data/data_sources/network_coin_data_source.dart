import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:kriptan/common/network/load_exception.dart';
import 'package:kriptan/features/coin/data/api/coin_api.dart';
import 'package:kriptan/features/coin/data/data_sources/i_coin_data_source.dart';
import 'package:kriptan/features/coin/data/dto/coin_detail_dto.dart';
import 'package:kriptan/features/coin/data/dto/coin_market_dto.dart';

final class NetworkCoinDataSource implements ICoinDataSource {
  const NetworkCoinDataSource(this._api);

  final CoinApi _api;

  @override
  Future<List<CoinMarketDto>> getMarkets({
    required int page,
    required int perPage,
  }) => _guard(() => _api.getMarkets(page: page, perPage: perPage));

  @override
  Future<CoinDetailDto> getCoin(String id) => _guard(() => _api.getCoin(id));

  // The await inside try matters: without it a failed Future skips the catch.
  Future<T> _guard<T>(Future<T> Function() request) async {
    try {
      return await request();
    } on DioException catch (error) {
      throw _fromDio(error);
    } on CheckedFromJsonException {
      throw const BadResponseException();
    } on FormatException {
      throw const BadResponseException();
    } on TypeError {
      throw const BadResponseException();
    }
  }

  LoadException _fromDio(DioException error) => switch (error.type) {
    DioExceptionType.connectionTimeout ||
    DioExceptionType.sendTimeout ||
    DioExceptionType.receiveTimeout => const TimeoutLoadException(),
    DioExceptionType.badResponse => switch (error.response?.statusCode) {
      404 => const NotFoundException(),
      429 => const TooManyRequestsException(),
      final statusCode => ServerException(statusCode),
    },
    DioExceptionType.unknown when error.error is FormatException =>
      const BadResponseException(),
    _ => const NoConnectionException(),
  };
}
