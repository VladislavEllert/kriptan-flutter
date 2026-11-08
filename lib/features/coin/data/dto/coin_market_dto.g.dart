// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coin_market_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CoinMarketDto _$CoinMarketDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'CoinMarketDto',
      json,
      ($checkedConvert) {
        final val = CoinMarketDto(
          id: $checkedConvert('id', (v) => v as String),
          symbol: $checkedConvert('symbol', (v) => v as String),
          name: $checkedConvert('name', (v) => v as String),
          image: $checkedConvert('image', (v) => v as String),
          currentPrice: $checkedConvert(
            'current_price',
            (v) => (v as num).toDouble(),
          ),
          marketCap: $checkedConvert('market_cap', (v) => v as num),
          marketCapRank: $checkedConvert(
            'market_cap_rank',
            (v) => (v as num?)?.toInt(),
          ),
          totalVolume: $checkedConvert(
            'total_volume',
            (v) => (v as num).toDouble(),
          ),
          high24h: $checkedConvert('high_24h', (v) => (v as num?)?.toDouble()),
          low24h: $checkedConvert('low_24h', (v) => (v as num?)?.toDouble()),
          priceChangePercentage24h: $checkedConvert(
            'price_change_percentage_24h',
            (v) => (v as num?)?.toDouble(),
          ),
          circulatingSupply: $checkedConvert(
            'circulating_supply',
            (v) => (v as num?)?.toDouble(),
          ),
          totalSupply: $checkedConvert(
            'total_supply',
            (v) => (v as num?)?.toDouble(),
          ),
          maxSupply: $checkedConvert(
            'max_supply',
            (v) => (v as num?)?.toDouble(),
          ),
          ath: $checkedConvert('ath', (v) => (v as num).toDouble()),
          athDate: $checkedConvert('ath_date', (v) => v as String),
          lastUpdated: $checkedConvert('last_updated', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {
        'currentPrice': 'current_price',
        'marketCap': 'market_cap',
        'marketCapRank': 'market_cap_rank',
        'totalVolume': 'total_volume',
        'high24h': 'high_24h',
        'low24h': 'low_24h',
        'priceChangePercentage24h': 'price_change_percentage_24h',
        'circulatingSupply': 'circulating_supply',
        'totalSupply': 'total_supply',
        'maxSupply': 'max_supply',
        'athDate': 'ath_date',
        'lastUpdated': 'last_updated',
      },
    );
