final class CoinModel {
  const CoinModel({
    required this.id,
    required this.symbol,
    required this.name,
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

  final String id;
  final String symbol;
  final String name;
  final double currentPrice;
  final int marketCap;
  final int? marketCapRank;
  final double totalVolume;
  final double? high24h;
  final double? low24h;
  final double? priceChangePercentage24h;
  final double? circulatingSupply;
  final double? totalSupply;
  final double? maxSupply;
  final double ath;
  final String athDate;
  final String lastUpdated;
}
