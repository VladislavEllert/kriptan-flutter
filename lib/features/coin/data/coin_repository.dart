import 'package:kriptan/features/coin/data/mock_coins.dart';
import 'package:kriptan/features/coin/domain/coin_model.dart';
import 'package:kriptan/features/coin/domain/i_coin_repository.dart';

final class CoinRepository implements ICoinRepository {
  const CoinRepository();

  @override
  Future<List<CoinModel>> getCoins() async => mockCoins;

  @override
  Future<CoinModel?> getCoin(String id) async {
    for (final coin in mockCoins) {
      if (coin.id == id) return coin;
    }
    return null;
  }

  @override
  Future<List<CoinModel>> searchCoins(String query) async {
    final text = query.trim().toLowerCase();
    return mockCoins
        .where(
          (coin) =>
              coin.name.toLowerCase().contains(text) ||
              coin.symbol.toLowerCase().contains(text),
        )
        .toList();
  }
}
