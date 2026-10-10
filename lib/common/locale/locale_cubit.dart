import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocaleCubit extends Cubit<Locale> {
  LocaleCubit() : super(_russian);

  static const Locale _russian = Locale('ru');
  static const Locale _english = Locale('en');

  void toggle() {
    emit(state == _russian ? _english : _russian);
  }
}
