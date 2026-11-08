import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kriptan/common/network/load_exception.dart';
import 'package:kriptan/features/coin/domain/i_coin_repository.dart';
import 'package:kriptan/features/coin/presentation/bloc/list/coin_list_state.dart';

class CoinListCubit extends Cubit<CoinListState> {
  CoinListCubit(this._repository) : super(const CoinListLoading(query: ''));

  final ICoinRepository _repository;

  static const int pageSize = 50;

  Future<void> load() async {
    emit(CoinListLoading(query: state.query));
    try {
      final coins = await _repository.getCoins(page: 1, perPage: pageSize);
      if (isClosed) return;
      emit(
        CoinListLoaded(
          query: state.query,
          loadedCoins: coins,
          loadedPages: 1,
          hasMore: coins.length == pageSize,
        ),
      );
    } on LoadException catch (error) {
      if (isClosed) return;
      emit(CoinListFailure(query: state.query, error: error));
    }
  }

  void search(String query) {
    final current = state;
    emit(switch (current) {
      CoinListLoaded() => current.copyWith(
        query: query,
        loadMoreError: current.loadMoreError,
      ),
      CoinListLoading() => CoinListLoading(query: query),
      CoinListFailure(:final error) => CoinListFailure(
        query: query,
        error: error,
      ),
    });
  }

  // The screen calls this many times while scrolling near the end;
  // extra calls are dropped here.
  Future<void> loadMore() async {
    final current = state;
    if (current is! CoinListLoaded ||
        !current.hasMore ||
        current.isLoadingMore ||
        current.isSearching) {
      return;
    }
    emit(current.copyWith(isLoadingMore: true));
    // The page counter moves only after success, so retry asks for the same
    // page instead of skipping it.
    final nextPage = current.loadedPages + 1;
    try {
      final next = await _repository.getCoins(
        page: nextPage,
        perPage: pageSize,
      );
      if (isClosed) return;
      final known = {for (final coin in current.loadedCoins) coin.id};
      // Prices move between requests, so a coin can shift to the next page.
      final fresh = next.where((coin) => !known.contains(coin.id));
      emit(
        _latest.copyWith(
          loadedCoins: [...current.loadedCoins, ...fresh],
          loadedPages: nextPage,
          hasMore: next.length == pageSize,
          isLoadingMore: false,
        ),
      );
    } on LoadException catch (error) {
      if (isClosed) return;
      emit(_latest.copyWith(isLoadingMore: false, loadMoreError: error));
    }
  }

  // The search query may have changed while the page was loading.
  CoinListLoaded get _latest => state as CoinListLoaded;
}
