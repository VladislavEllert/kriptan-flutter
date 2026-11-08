import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kriptan/features/coin/domain/i_coin_repository.dart';
import 'package:kriptan/features/coin/presentation/bloc/list/coin_list_state.dart';

class CoinListCubit extends Cubit<CoinListState> {
  CoinListCubit(this._repository) : super(const CoinListLoading());

  final ICoinRepository _repository;

  Future<void> load() async {
    final coins = await _repository.getCoins();
    if (isClosed) return;
    emit(CoinListLoaded(query: '', coins: coins));
  }

  Future<void> search(String query) async {
    final coins = await _repository.searchCoins(query);
    if (isClosed) return;
    emit(CoinListLoaded(query: query, coins: coins));
  }
}
