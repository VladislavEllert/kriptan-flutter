import 'package:kriptan/common/network/load_exception.dart';
import 'package:kriptan/features/coin/domain/coin_model.dart';

sealed class CoinDetailState {
  const CoinDetailState();
}

final class CoinDetailLoading extends CoinDetailState {
  const CoinDetailLoading();
}

final class CoinDetailFailure extends CoinDetailState {
  const CoinDetailFailure(this.error);

  final LoadException error;
}

final class CoinDetailLoaded extends CoinDetailState {
  const CoinDetailLoaded({required this.coin, required this.neighbours});

  final CoinModel coin;

  // Coins one place above and one place below in the market cap ranking.
  final List<CoinModel> neighbours;
}
