import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '1.CONFIG/Theme/app_theme.dart';
import '2.FEATURES/SIL/Presentation/bloc/cubit_language/language_cubit.dart';
import '2.FEATURES/SIL/Presentation/bloc/cubit_recordatorio/recordatorio_cubit.dart';
import '2.FEATURES/SIL/Presentation/bloc/cubit_theme/theme_cubit.dart';
import '2.FEATURES/SIL/Presentation/bloc/cubit_username/username_cubit.dart';
import '2.FEATURES/SIL/Presentation/views/splash_screen_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //*~~~~~Esta linea de codigo oculta la barra de navegación en android.~~~~~.
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
    return MultiBlocProvider(
      providers: [
        BlocProvider(lazy: false, create: (_) => ThemeCubit()),
        BlocProvider(create: (_) => RecordatorioCubit()),
        BlocProvider(create: (_) => UsernameCubit()),
        BlocProvider(create: (_) => LanguageMethodsCubit()),
      ],
      child: BlocBuilder<ThemeCubit, bool>(
        builder: (context, isDarkTheme) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: "App San Ignacio",
            theme: isDarkTheme ? AppTheme.themeDark : AppTheme.themeLight,
            home: const SplashScreen(),
            // home: const NavigatorBarView(),
          );
        },
      ),
    );
  }
}
