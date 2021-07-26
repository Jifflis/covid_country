import 'package:covid/cubit/country_info_cubit.dart';
import 'package:covid/cubit/covid_info_cubit.dart';
import 'package:covid/cubit/main_cubit.dart';
import 'package:covid/repository/api.dart';
import 'package:covid/repository/country_repository.dart';
import 'package:covid/repository/covid_repository.dart';
import 'package:covid/view/page/details_screen.dart';
import 'package:covid/view/page/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'constant/routes.dart';
import 'env.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Env.initEnv();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      initialRoute: Routes.initial,
      routes: {
        Routes.screen_detail: (context) => MultiBlocProvider(providers: [
              BlocProvider<CovidInfoCubit>(
                create: (_) => CovidInfoCubit(
                  CovidRepository(ApiProvider()),
                ),
              ),
              BlocProvider<CountryInfoCubit>(
                create: (_) => CountryInfoCubit(
                  CountryRepository(ApiProvider()),
                ),
              ),
            ], child: DetailsScreen()),
      },
      home: BlocProvider<MainCubit>(
        create: (_) => MainCubit(CovidRepository(ApiProvider()))..getInfectedCountry(),
        child: MainScreen(),
      ),
    );
  }
}
