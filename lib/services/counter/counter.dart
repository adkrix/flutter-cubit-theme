import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _counterStoreName = 'app_counter';

class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0) {
    _loadSettings();
  }

  void _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getInt(_counterStoreName);

    emit(saved ?? 0);
  }

  void increment() async {
    final prefs = await SharedPreferences.getInstance();
    final newCount = state + 1;
    await prefs.setInt(_counterStoreName, newCount);
    emit(newCount);
  }

  void decrement() async {
    final prefs = await SharedPreferences.getInstance();
    final newCount = state - 1;
    await prefs.setInt(_counterStoreName, newCount);
    emit(newCount);
  }
}
