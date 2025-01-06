import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:final_ibilling/core/singletons/storage/storage.dart';
import 'package:final_ibilling/core/singletons/storage/storage_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocalizationCubit extends Cubit<Locale> {
  LocalizationCubit() : super(const Locale('uz')) {
    log("localization cubit constructor");
  }

  Future<void> loadLocale(BuildContext context) async {
    final savedLocale = StorageRepository.getString(StorageKeys.locale);
    if (savedLocale != null) {
      final locale = _getLocaleFromCode(savedLocale);
      log("load locale = $locale");
      emit(locale);
      context.setLocale(locale);
    }
  }

  Future<void> changeLocale(Locale locale, BuildContext context) async {
    log("$locale");
    emit(locale);
    context.setLocale(locale);
    await StorageRepository.putString(StorageKeys.locale, locale.languageCode);
    log("change locale in localization cubit =>  $locale");
  }

  Locale _getLocaleFromCode(String code) {
    switch (code) {
      case "ru":
        return const Locale("ru");
      case "en":
        return const Locale("en");
      default:
        return const Locale("uz");
    }
  }
}
