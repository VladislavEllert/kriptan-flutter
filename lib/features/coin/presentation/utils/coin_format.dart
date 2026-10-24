import 'package:intl/intl.dart';
import 'package:kriptan/common/theme/image_sources.dart';
import 'package:kriptan/features/coin/domain/coin_model.dart';

const String _noValue = '—';

// Numbers look the same in both interface languages, so the locale is fixed.
const String _numberLocale = 'en_US';

extension CoinFormat on CoinModel {
  String get logo => ImageSources.coinLogo(id);

  String get displaySymbol => symbol.toUpperCase();

  String get displayPrice => _formatPrice(currentPrice);

  String get displayHigh24h => _formatPrice(high24h);

  String get displayLow24h => _formatPrice(low24h);

  String get displayAth => '${_formatPrice(ath)} · ${athDate.substring(0, 10)}';

  String get displayChange {
    final percent = priceChangePercentage24h;
    if (percent == null) return _noValue;
    final sign = percent >= 0 ? '+' : '';
    return '$sign${percent.toStringAsFixed(2)}%';
  }

  String get displayVolume => _formatCompact(totalVolume);

  String get displayMarketCap => '\$${_formatCompact(marketCap.toDouble())}';

  String get displayTotalVolume => '\$${_formatCompact(totalVolume)}';

  String get displayCirculatingSupply => _formatSupply(circulatingSupply);

  String get displayTotalSupply => _formatSupply(totalSupply);

  String get displayMaxSupply => _formatSupply(maxSupply);

  // 2026-09-25T15:27:10.000Z -> 2026-09-25 15:27 UTC
  String get displayLastUpdated =>
      '${lastUpdated.substring(0, 16).replaceFirst('T', ' ')} UTC';

  String _formatSupply(double? amount) =>
      amount == null ? _noValue : '${_formatCompact(amount)} $displaySymbol';
}

String _formatPrice(double? price) {
  if (price == null) return _noValue;
  final pattern = switch (price) {
    >= 1 => '#,##0.00',
    >= 0.01 => '0.0000',
    _ => '0.000000',
  };
  return '\$${NumberFormat(pattern, _numberLocale).format(price)}';
}

String _formatCompact(double value) {
  final (divider, suffix) = switch (value) {
    >= 1e12 => (1e12, 'T'),
    >= 1e9 => (1e9, 'B'),
    >= 1e6 => (1e6, 'M'),
    _ => (1.0, ''),
  };
  return '${NumberFormat('#,##0.00', _numberLocale).format(value / divider)}$suffix';
}
