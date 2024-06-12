import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_z_rabota/blocs/user_bloc.dart';
import 'package:t_z_rabota/blocs/user_event.dart';
import 'package:t_z_rabota/generated/codegen_loader.g.dart';
import 'package:t_z_rabota/repositories/user_repository.dart';
import 'package:t_z_rabota/screens/splash_screen.dart';
import 'package:t_z_rabota/screens/user_detail_screen.dart';
import 'package:t_z_rabota/screens/user_list_screen.dart';
import 'package:t_z_rabota/service/connectivity_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(
    EasyLocalization(
        assetLoader: CodegenLoader(),
        supportedLocales: const [Locale('en'), Locale('ru')],
        path:
            'assets/translations', // <-- change the path of the translation files
        fallbackLocale: const Locale('en'),
        child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  final UserRepository userRepository = UserRepository();
  final ConnectivityService connectivityService = ConnectivityService();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserBloc>(
          create: (context) => UserBloc(
            userRepository: userRepository,
            connectivityService: connectivityService,
          )..add(FetchUsers()),
        ),
      ],
      child: MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        home: SplashScreen(),
        debugShowCheckedModeBanner: false,
        routes: {
          '/usersList': (context) => UsersListScreen(),
          '/userDetail': (context) => UserDetailScreen(),
        },
      ),
    );
  }
}
