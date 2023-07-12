import 'package:hive_flutter/hive_flutter.dart';
import 'package:wordle_clone/data/repository/menu_repository.dart';

class MenuUseCase {
  final MenuRepository _repository = MenuRepository();

  Future<void> checkWords() async {
    Hive.openBox('name');
  }
}
