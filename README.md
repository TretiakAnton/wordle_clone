# wordle_clone

Wordle clone

## Architecture

- Clean architecture 'https://itnext.io/flutter-clean-architecture-b53ce9e19d5a'

## State management

- Flutter bloc 7.1.0

## Test account 

email: qwe@qwe.com
password: test12

## Generating 

flutter pub run easy_localization:generate -S 'assets/translations'
flutter pub run easy_localization:generate -S assets/translations -f keys -o locale_keys.g.dart
flutter pub run build_runner build --delete-conflicting-outputs
