# Kriptan (Flutter)

Каталог криптовалют: список монет с поиском и экран монеты. Лабораторные работы по курсу
«Кроссплатформенная разработка», трек Flutter. Данные — моки, снятые с CoinGecko
(`/coins/markets`), сети нет.

Flutter 3.47, flutter_bloc (Cubit), go_router, локализация через ARB (ru/en).

## Запуск

```bash
flutter pub get               # заодно генерирует lib/l10n/app_localizations.dart
flutter run -d chrome         # браузер
flutter run -d macos          # второй таргет
dart run tool/check_arb.dart  # сверка ключей ru/en
```

## Структура

```
lib/
  main.dart, app.dart
  common/         navigation/, theme/, locale/, widgets/
  features/coin/
    data/         моки и реализация репозитория
    domain/       модель и интерфейс репозитория
    presentation/ bloc/, view/, view/widgets/, utils/
```
