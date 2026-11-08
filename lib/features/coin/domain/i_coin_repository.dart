import 'package:kriptan/features/coin/domain/coin_model.dart';

abstract interface class ICoinRepository {
  Future<List<CoinModel>> getCoins();

  Future<CoinModel?> getCoin(String id);

  Future<List<CoinModel>> searchCoins(String query);
}
