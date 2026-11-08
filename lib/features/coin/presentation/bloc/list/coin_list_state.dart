import 'package:kriptan/features/coin/domain/coin_model.dart';

sealed class CoinListState {
  const CoinListState();
}

final class CoinListLoading extends CoinListState {
  const CoinListLoading();
}

final class CoinListLoaded extends CoinListState {
  const CoinListLoaded({required this.query, required this.coins});

  final String query;
  final List<CoinModel> coins;
}
