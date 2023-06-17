import 'package:FurEverHome/cubit/fur_ever_home_cubit.dart';
import 'package:FurEverHome/screens/splash_screen.dart';
import 'package:FurEverHome/utils/app_colors.dart';
import 'package:FurEverHome/utils/constants.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const FurEverHome());
}

class FurEverHome extends StatelessWidget {
  const FurEverHome({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FurEverHomeCubit(),
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: AppColors.primaryTheme,
          fontFamily: Constants.FONT_FAMILY_PLUS_JAKARTA_SANS,
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
            systemOverlayStyle: SystemUiOverlayStyle.dark,
            iconTheme: IconThemeData(color: AppColors.primary),
          ),
          primaryIconTheme: const IconThemeData(color: AppColors.primary),
        ),
        builder: BotToastInit(),
        navigatorObservers: [BotToastNavigatorObserver()],
        home: const SplashScreen(),
      ),
    );
  }
}
