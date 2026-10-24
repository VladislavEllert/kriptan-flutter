import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kriptan/features/coin/domain/coin_model.dart';
import 'package:kriptan/features/coin/domain/i_coin_repository.dart';
import 'package:kriptan/features/coin/presentation/bloc/detail/coin_detail_state.dart';

class CoinDetailCubit extends Cubit<CoinDetailState> {
  CoinDetailCubit(this._repository) : super(const CoinDetailLoading());

  final ICoinRepository _repository;

  Future<void> load(String coinId) async {
    final coin = await _repository.getCoin(coinId);
    if (isClosed) return;
    if (coin == null) {
      emit(const CoinDetailNotFound());
      return;
    }

    final coins = await _repository.getCoins();
    if (isClosed) return;
    emit(
      CoinDetailLoaded(coin: coin, neighbours: _rankNeighbours(coin, coins)),
    );
  }

  // Looked up by marketCapRank, not by list position: the repository
  // does not promise any order of getCoins().
  List<CoinModel> _rankNeighbours(CoinModel coin, List<CoinModel> coins) {
    final rank = coin.marketCapRank;
    if (rank == null) return [];
    final above = coins.where((other) => other.marketCapRank == rank - 1);
    final below = coins.where((other) => other.marketCapRank == rank + 1);
    return [...above.take(1), ...below.take(1)];
  }
}
