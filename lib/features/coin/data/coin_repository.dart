import 'package:kriptan/features/coin/data/data_sources/i_coin_data_source.dart';
import 'package:kriptan/features/coin/data/mappers/coin_mapper.dart';
import 'package:kriptan/features/coin/domain/coin_model.dart';
import 'package:kriptan/features/coin/domain/i_coin_repository.dart';

final class CoinRepository implements ICoinRepository {
  const CoinRepository(this._dataSource);

  final ICoinDataSource _dataSource;

  @override
  Future<List<CoinModel>> getCoins({
    required int page,
    required int perPage,
  }) async {
    final dtos = await _dataSource.getMarkets(page: page, perPage: perPage);
    return dtos.map((dto) => dto.toModel()).toList();
  }

  @override
  Future<CoinModel> getCoin(String id) async =>
      (await _dataSource.getCoin(id)).toModel();
}
