import 'package:kriptan/features/coin/data/dto/coin_detail_dto.dart';
import 'package:kriptan/features/coin/data/dto/coin_market_dto.dart';

// Throws only LoadException.
abstract interface class ICoinDataSource {
  Future<List<CoinMarketDto>> getMarkets({
    required int page,
    required int perPage,
  });

  Future<CoinDetailDto> getCoin(String id);
}
