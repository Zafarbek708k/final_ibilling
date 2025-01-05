import 'package:final_ibilling/assets/themes/theme.dart';
import 'package:final_ibilling/feature/contracts/presentation/bloc/contract_bloc.dart';
import 'package:final_ibilling/feature/history/presentation/bloc/history_bloc.dart';
import 'package:final_ibilling/feature/main_wrapper/main_wrap.dart';
import 'package:final_ibilling/feature/new/presentation/bloc/add_new_contract_bloc.dart';
import 'package:final_ibilling/feature/profile/presentation/bloc/profile_bloc.dart';
import 'package:final_ibilling/feature/saved/presentation/bloc/saved_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/singletons/di/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=> ProfileBloc()),
        BlocProvider(create: (context)=> SavedBloc()),
        BlocProvider(create: (context)=> AddNewContractBloc()),
        BlocProvider(create: (context)=> HistoryBloc()),
        BlocProvider(create: (context)=> ContractBloc()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: AppTheme.lightTheme,
        darkTheme: DarkTheme.darkTheme,
        themeMode: ThemeMode.system,
        home: const MainWrap(),
      ),
    );
  }
}
