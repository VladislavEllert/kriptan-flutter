import 'package:dio/dio.dart';
import 'package:kriptan/features/coin/data/dto/coin_detail_dto.dart';
import 'package:kriptan/features/coin/data/dto/coin_market_dto.dart';

// One method per server address. Errors are handled by the data source.
final class CoinApi {
  const CoinApi(this._dio);

  final Dio _dio;

  Future<List<CoinMarketDto>> getMarkets({
    required int page,
    required int perPage,
  }) async {
    final response = await _dio.get<List<dynamic>>(
      '/coins/markets',
      queryParameters: {
        'vs_currency': 'usd',
        'order': 'market_cap_desc',
        'page': page,
        'per_page': perPage,
      },
    );
    final items = response.data ?? (throw const FormatException('Empty body'));
    return items
        .map((item) => CoinMarketDto.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<CoinDetailDto> getCoin(String id) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/coins/$id',
      queryParameters: {
        'localization': false,
        'tickers': false,
        'community_data': false,
        'developer_data': false,
      },
    );
    final json = response.data ?? (throw const FormatException('Empty body'));
    return CoinDetailDto.fromJson(json);
  }
}
