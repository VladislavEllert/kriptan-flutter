import 'package:json_annotation/json_annotation.dart';

part 'coin_market_dto.g.dart';

// One item of GET /coins/markets.
@JsonSerializable()
class CoinMarketDto {
  const CoinMarketDto({
    required this.id,
    required this.symbol,
    required this.name,
    required this.image,
    required this.currentPrice,
    required this.marketCap,
    required this.marketCapRank,
    required this.totalVolume,
    required this.high24h,
    required this.low24h,
    required this.priceChangePercentage24h,
    required this.circulatingSupply,
    required this.totalSupply,
    required this.maxSupply,
    required this.ath,
    required this.athDate,
    required this.lastUpdated,
  });

  factory CoinMarketDto.fromJson(Map<String, dynamic> json) =>
      _$CoinMarketDtoFromJson(json);

  final String id;
  final String symbol;
  final String name;
  final String image;
  final double currentPrice;
  final num marketCap;
  final int? marketCapRank;
  final double totalVolume;
  @JsonKey(name: 'high_24h')
  final double? high24h;
  @JsonKey(name: 'low_24h')
  final double? low24h;
  @JsonKey(name: 'price_change_percentage_24h')
  final double? priceChangePercentage24h;
  final double? circulatingSupply;
  final double? totalSupply;
  final double? maxSupply;
  final double ath;
  final String athDate;
  final String lastUpdated;
}
