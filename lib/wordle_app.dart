import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordle_clone/core/navigation/app_router.dart';

final GlobalKey<ScaffoldMessengerState> materialAppKey =
GlobalKey<ScaffoldMessengerState>();

class WordleApp extends StatelessWidget {
  WordleApp({Key? key}) : super(key: key);
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
       // BlocProvider<LoginCubit>(create: (context) => LoginCubit()),
       // BlocProvider<StoreCubit>(create: (context) => StoreCubit()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        scaffoldMessengerKey: materialAppKey,
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
        routerDelegate: _appRouter.delegate(),
        routeInformationParser: _appRouter.defaultRouteParser(),
      ),
    );
  }
}