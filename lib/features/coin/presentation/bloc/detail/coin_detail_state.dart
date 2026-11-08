import 'package:kriptan/features/coin/domain/coin_model.dart';

sealed class CoinDetailState {
  const CoinDetailState();
}

final class CoinDetailLoading extends CoinDetailState {
  const CoinDetailLoading();
}

final class CoinDetailLoaded extends CoinDetailState {
  const CoinDetailLoaded({required this.coin, required this.neighbours});

  final CoinModel coin;

  // Coins one place above and one place below in the market cap ranking.
  final List<CoinModel> neighbours;
}

final class CoinDetailNotFound extends CoinDetailState {
  const CoinDetailNotFound();
}
