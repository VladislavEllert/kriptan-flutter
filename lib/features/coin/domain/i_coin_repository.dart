import 'package:kriptan/features/coin/domain/coin_model.dart';

// Methods throw LoadException when data cannot be loaded.
abstract interface class ICoinRepository {
  // Pages start at 1 and go in market cap order. An empty page means the end.
  Future<List<CoinModel>> getCoins({required int page, required int perPage});

  Future<CoinModel> getCoin(String id);
}
