import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kriptan/common/network/load_exception.dart';
import 'package:kriptan/features/coin/domain/coin_model.dart';
import 'package:kriptan/features/coin/domain/i_coin_repository.dart';
import 'package:kriptan/features/coin/presentation/bloc/detail/coin_detail_state.dart';

class CoinDetailCubit extends Cubit<CoinDetailState> {
  CoinDetailCubit(this._repository, this._coinId)
    : super(const CoinDetailLoading());

  final ICoinRepository _repository;
  final String _coinId;

  // Neighbours are looked up in the top of the ranking.
  static const int _rankingSize = 250;

  Future<void> load() async {
    emit(const CoinDetailLoading());
    try {
      // Both requests go at the same time. Future.wait on a list rethrows the
      // original LoadException, unlike (a, b).wait with its ParallelWaitError.
      final results = await Future.wait([
        _repository.getCoin(_coinId),
        _repository.getCoins(page: 1, perPage: _rankingSize),
      ]);
      if (isClosed) return;
      final coin = results[0] as CoinModel;
      final ranking = results[1] as List<CoinModel>;
      emit(
        CoinDetailLoaded(
          coin: coin,
          neighbours: _rankNeighbours(coin, ranking),
        ),
      );
    } on LoadException catch (error) {
      if (isClosed) return;
      emit(CoinDetailFailure(error));
    }
  }

  // Looked up by marketCapRank, not by list position: the API does not
  // promise any order.
  List<CoinModel> _rankNeighbours(CoinModel coin, List<CoinModel> coins) {
    final rank = coin.marketCapRank;
    if (rank == null) return [];
    final above = coins.where((other) => other.marketCapRank == rank - 1);
    final below = coins.where((other) => other.marketCapRank == rank + 1);
    return [...above.take(1), ...below.take(1)];
  }
}
