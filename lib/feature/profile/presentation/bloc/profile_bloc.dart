import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:final_ibilling/core/singletons/storage/storage.dart';
import 'package:final_ibilling/core/singletons/storage/storage_keys.dart';
import 'package:final_ibilling/feature/main_wrapper/main_wrap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../setting/localization_cubit.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(const ProfileState()) {
    on<ProfileEvent>((event, emit) {});
    on<ChangeLocaleInProfile>((event, emit)=> _changeLocaleInProfile(event, emit));
    getLanguage();
  }

  Future<void>_changeLocaleInProfile(ChangeLocaleInProfile event, Emitter<ProfileState>emit)async{
    emit(state.copyWith(status: ProfileStateStatus.loading));
    try{
      log("chage to locale => ${event.locale}");
      await StorageRepository.putString(StorageKeys.locale, event.locale);
      emit(state.copyWith(status: ProfileStateStatus.loaded, locale: event.locale));
      event.context.read<LocalizationCubit>().changeLocale(_getLocaleFromCode(event.locale), event.context);
      event.context.setLocale(_getLocaleFromCode(event.locale));
    }catch(e){
      emit(state.copyWith(status: ProfileStateStatus.error, errorMsg: "Something went wrong"));
    }
  }


  Future<void> getLanguage()async{
    emit(state.copyWith(status: ProfileStateStatus.loading));
    String? result =  StorageRepository.getString(StorageKeys.locale);
    if(result != null){
      emit(state.copyWith(status: ProfileStateStatus.loaded, locale: result));
    }else{
      emit(state.copyWith(status: ProfileStateStatus.error, errorMsg: "Locale is not find"));
    }
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
