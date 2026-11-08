import 'package:json_annotation/json_annotation.dart';

part 'coin_detail_dto.g.dart';

// GET /coins/{id}. Prices come as maps keyed by currency: {"usd": 75977, ...}.
@JsonSerializable()
class CoinDetailDto {
  const CoinDetailDto({
    required this.id,
    required this.symbol,
    required this.name,
    required this.image,
    required this.marketCapRank,
    required this.marketData,
    required this.lastUpdated,
  });

  factory CoinDetailDto.fromJson(Map<String, dynamic> json) =>
      _$CoinDetailDtoFromJson(json);

  final String id;
  final String symbol;
  final String name;
  final CoinImageDto image;
  final int? marketCapRank;
  final MarketDataDto marketData;
  final String lastUpdated;
}

@JsonSerializable()
class CoinImageDto {
  const CoinImageDto({required this.large});

  factory CoinImageDto.fromJson(Map<String, dynamic> json) =>
      _$CoinImageDtoFromJson(json);

  final String large;
}

@JsonSerializable()
class MarketDataDto {
  const MarketDataDto({
    required this.currentPrice,
    required this.marketCap,
    required this.totalVolume,
    required this.high24h,
    required this.low24h,
    required this.priceChangePercentage24h,
    required this.circulatingSupply,
    required this.totalSupply,
    required this.maxSupply,
    required this.ath,
    required this.athDate,
  });

  factory MarketDataDto.fromJson(Map<String, dynamic> json) =>
      _$MarketDataDtoFromJson(json);

  final Map<String, double> currentPrice;
  final Map<String, num> marketCap;
  final Map<String, double> totalVolume;
  @JsonKey(name: 'high_24h')
  final Map<String, double> high24h;
  @JsonKey(name: 'low_24h')
  final Map<String, double> low24h;
  @JsonKey(name: 'price_change_percentage_24h')
  final double? priceChangePercentage24h;
  final double? circulatingSupply;
  final double? totalSupply;
  final double? maxSupply;
  final Map<String, double> ath;
  final Map<String, String> athDate;
}
