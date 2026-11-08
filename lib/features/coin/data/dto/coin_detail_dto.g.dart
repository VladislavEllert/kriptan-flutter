// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coin_detail_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CoinDetailDto _$CoinDetailDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'CoinDetailDto',
      json,
      ($checkedConvert) {
        final val = CoinDetailDto(
          id: $checkedConvert('id', (v) => v as String),
          symbol: $checkedConvert('symbol', (v) => v as String),
          name: $checkedConvert('name', (v) => v as String),
          image: $checkedConvert(
            'image',
            (v) => CoinImageDto.fromJson(v as Map<String, dynamic>),
          ),
          marketCapRank: $checkedConvert(
            'market_cap_rank',
            (v) => (v as num?)?.toInt(),
          ),
          marketData: $checkedConvert(
            'market_data',
            (v) => MarketDataDto.fromJson(v as Map<String, dynamic>),
          ),
          lastUpdated: $checkedConvert('last_updated', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {
        'marketCapRank': 'market_cap_rank',
        'marketData': 'market_data',
        'lastUpdated': 'last_updated',
      },
    );

CoinImageDto _$CoinImageDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('CoinImageDto', json, ($checkedConvert) {
      final val = CoinImageDto(
        large: $checkedConvert('large', (v) => v as String),
      );
      return val;
    });

MarketDataDto _$MarketDataDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'MarketDataDto',
      json,
      ($checkedConvert) {
        final val = MarketDataDto(
          currentPrice: $checkedConvert(
            'current_price',
            (v) => (v as Map<String, dynamic>).map(
              (k, e) => MapEntry(k, (e as num).toDouble()),
            ),
          ),
          marketCap: $checkedConvert(
            'market_cap',
            (v) => Map<String, num>.from(v as Map),
          ),
          totalVolume: $checkedConvert(
            'total_volume',
            (v) => (v as Map<String, dynamic>).map(
              (k, e) => MapEntry(k, (e as num).toDouble()),
            ),
          ),
          high24h: $checkedConvert(
            'high_24h',
            (v) => (v as Map<String, dynamic>).map(
              (k, e) => MapEntry(k, (e as num).toDouble()),
            ),
          ),
          low24h: $checkedConvert(
            'low_24h',
            (v) => (v as Map<String, dynamic>).map(
              (k, e) => MapEntry(k, (e as num).toDouble()),
            ),
          ),
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
          ath: $checkedConvert(
            'ath',
            (v) => (v as Map<String, dynamic>).map(
              (k, e) => MapEntry(k, (e as num).toDouble()),
            ),
          ),
          athDate: $checkedConvert(
            'ath_date',
            (v) => Map<String, String>.from(v as Map),
          ),
        );
        return val;
      },
      fieldKeyMap: const {
        'currentPrice': 'current_price',
        'marketCap': 'market_cap',
        'totalVolume': 'total_volume',
        'high24h': 'high_24h',
        'low24h': 'low_24h',
        'priceChangePercentage24h': 'price_change_percentage_24h',
        'circulatingSupply': 'circulating_supply',
        'totalSupply': 'total_supply',
        'maxSupply': 'max_supply',
        'athDate': 'ath_date',
      },
    );
