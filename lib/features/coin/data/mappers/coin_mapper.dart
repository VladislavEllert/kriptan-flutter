import 'package:kriptan/features/coin/data/dto/coin_detail_dto.dart';
import 'package:kriptan/features/coin/data/dto/coin_market_dto.dart';
import 'package:kriptan/features/coin/domain/coin_model.dart';

const String _currency = 'usd';

extension CoinMarketDtoMapper on CoinMarketDto {
  CoinModel toModel() => CoinModel(
    id: id,
    symbol: symbol,
    name: name,
    image: image,
    currentPrice: currentPrice,
    marketCap: marketCap.toInt(),
    marketCapRank: marketCapRank,
    totalVolume: totalVolume,
    high24h: high24h,
    low24h: low24h,
    priceChangePercentage24h: priceChangePercentage24h,
    circulatingSupply: circulatingSupply,
    totalSupply: totalSupply,
    maxSupply: maxSupply,
    ath: ath,
    athDate: athDate,
    lastUpdated: lastUpdated,
  );
}

extension CoinDetailDtoMapper on CoinDetailDto {
  CoinModel toModel() => CoinModel(
    id: id,
    symbol: symbol,
    name: name,
    image: image.large,
    currentPrice: marketData.currentPrice[_currency] ?? 0,
    marketCap: marketData.marketCap[_currency]?.toInt() ?? 0,
    marketCapRank: marketCapRank,
    totalVolume: marketData.totalVolume[_currency] ?? 0,
    high24h: marketData.high24h[_currency],
    low24h: marketData.low24h[_currency],
    priceChangePercentage24h: marketData.priceChangePercentage24h,
    circulatingSupply: marketData.circulatingSupply,
    totalSupply: marketData.totalSupply,
    maxSupply: marketData.maxSupply,
    ath: marketData.ath[_currency] ?? 0,
    athDate: marketData.athDate[_currency] ?? lastUpdated,
    lastUpdated: lastUpdated,
  );
}
