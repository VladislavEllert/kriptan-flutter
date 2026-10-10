import 'package:flutter_bloc/flutter_bloc.dart';
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
    final index = coins.indexWhere((other) => other.id == coinId);
    emit(
      CoinDetailLoaded(
        coin: coin,
        neighbours: [
          if (index > 0) coins[index - 1],
          if (index < coins.length - 1) coins[index + 1],
        ],
      ),
    );
  }
}
