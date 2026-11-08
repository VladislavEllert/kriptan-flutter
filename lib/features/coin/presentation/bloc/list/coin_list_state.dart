import 'package:kriptan/common/network/load_exception.dart';
import 'package:kriptan/features/coin/domain/coin_model.dart';

sealed class CoinListState {
  const CoinListState({required this.query});

  final String query;
}

final class CoinListLoading extends CoinListState {
  const CoinListLoading({required super.query});
}

final class CoinListFailure extends CoinListState {
  const CoinListFailure({required super.query, required this.error});

  final LoadException error;
}

final class CoinListLoaded extends CoinListState {
  const CoinListLoaded({
    required super.query,
    required this.loadedCoins,
    required this.loadedPages,
    required this.hasMore,
    this.isLoadingMore = false,
    this.loadMoreError,
  });

  // Every coin loaded so far, without the search filter.
  final List<CoinModel> loadedCoins;
  final int loadedPages;
  final bool hasMore;
  final bool isLoadingMore;

  // The next page failed: loaded coins stay, "Retry" is shown under the list.
  final LoadException? loadMoreError;

  // Search filters only the loaded coins: CoinGecko /coins/markets has no
  // search by name.
  List<CoinModel> get coins {
    final text = query.trim().toLowerCase();
    if (text.isEmpty) return loadedCoins;
    return loadedCoins
        .where(
          (coin) =>
              coin.name.toLowerCase().contains(text) ||
              coin.symbol.toLowerCase().contains(text),
        )
        .toList();
  }

  bool get isSearching => query.trim().isNotEmpty;

  CoinListLoaded copyWith({
    String? query,
    List<CoinModel>? loadedCoins,
    int? loadedPages,
    bool? hasMore,
    bool? isLoadingMore,
    LoadException? loadMoreError,
  }) => CoinListLoaded(
    query: query ?? this.query,
    loadedCoins: loadedCoins ?? this.loadedCoins,
    loadedPages: loadedPages ?? this.loadedPages,
    hasMore: hasMore ?? this.hasMore,
    isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    loadMoreError: loadMoreError,
  );
}
