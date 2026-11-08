# Kriptan (Flutter)

Каталог криптовалют: список монет с поиском и экран монеты. Лабораторные работы по курсу
«Кроссплатформенная разработка», трек Flutter. Данные — публичный API CoinGecko
(`/coins/markets` для списка по страницам, `/coins/{id}` для экрана монеты), без ключа.

Flutter 3.47, flutter_bloc (Cubit), go_router, dio, json_serializable, локализация через ARB (ru/en).

## Запуск

```bash
flutter pub get               # заодно генерирует lib/l10n/app_localizations.dart
dart run build_runner build --delete-conflicting-outputs  # после правки DTO
flutter run -d chrome         # браузер
flutter run -d macos          # второй таргет
dart run tool/check_arb.dart  # сверка ключей ru/en
```

## Структура

```
lib/
  main.dart, app.dart
  common/         navigation/, network/ (Dio, LoadException), theme/, locale/, widgets/
  features/coin/
    data/         api/ → data_sources/ → coin_repository.dart, dto/, mappers/
    domain/       модель и интерфейс репозитория
    presentation/ bloc/, view/, view/widgets/, utils/
```

## Данные

Цепочка: `CoinApi` (dio, один метод на адрес, возвращает DTO) → `NetworkCoinDataSource`
(`DioException` и ошибки разбора превращаются в `LoadException`) → `CoinRepository` (DTO → модель)
→ Cubit → экран. Базовый адрес задан один раз в `lib/common/network/dio_client.dart`.

Бесплатный CoinGecko пропускает 5–15 запросов в минуту. Если прокручивать и открывать монеты
слишком быстро, сервер отвечает 429: в браузере это выглядит как «нет связи» (на ответ 429 сервер
не ставит заголовок CORS), на macOS — как «слишком много запросов». Кнопка «Повторить» через
минуту помогает.
