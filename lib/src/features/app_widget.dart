import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signal/src/features/common/application/bloc.dart';
import 'package:signal/src/features/common/domain/enums/enums.dart';
import 'package:signal/src/features/common/presentation/extensions/extensions.dart';
import 'package:signal/src/routing/app_router.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (BuildContext ctx, AppState s) {
        final auto = s.autoThemeMode == AutoThemeModeType.on;

        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: AppRouter.router,
          title: s.appTitle,
          theme: auto ? s.theme.lightTheme() : s.theme.getThemeData(),
          darkTheme: auto ? s.theme.darkTheme() : null,
        );
      },
    );
  }
}
