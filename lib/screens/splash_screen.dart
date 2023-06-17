import 'package:FurEverHome/utils/app_assets_path.dart';
import 'package:FurEverHome/utils/constants.dart';
import 'package:FurEverHome/widgets/custom_bottom_navigation_bar.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 50),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromRGBO(4, 4, 104, 1),
                Color.fromRGBO(20, 16, 170, 1),
                Color.fromRGBO(4, 2, 104, 1),
              ]),
        ),
        child: Stack(
          children: [
            Positioned(
              top: MediaQuery.of(context).size.height / 1.8,
              left: MediaQuery.of(context).size.width / 9,
              child: AnimatedTextKit(
                totalRepeatCount: 1,
                isRepeatingAnimation: false,
                animatedTexts: [
                  TypewriterAnimatedText(Constants.furEverHome,
                      speed: const Duration(milliseconds: 100),
                      textStyle: const TextStyle(
                          fontFamily: Constants.FONT_FAMILY_FOLDIT,
                          color: Colors.white,
                          fontSize: 36,
                          fontWeight: FontWeight.bold))
                ],
              ),
            ),
            Positioned(
                top: MediaQuery.of(context).size.height * 0.25,
                right: -MediaQuery.of(context).size.width * 0.12,
                child: loadLottie()),
          ],
        ),
      ),
    );
  }

  Widget loadLottie() {
    return Lottie.asset(
      AppAssetsPath.splashLottie,
      controller: _animationController,
      height: MediaQuery.of(context).size.height * 0.3,
      width: MediaQuery.of(context).size.width,
      fit: BoxFit.contain,
      animate: true,
      onLoaded: ((composition) {
        _animationController
          ..duration = composition.duration
          ..forward().whenComplete(() {
            //return RouteHelper.pushReplacement(Routes.LOGIN);
            Navigator.of(context).pushReplacement(
              MaterialPageRoute<void>(
                builder: (BuildContext context) =>
                    const CustomBottomNavigationBar(),
              ),
            );
          });
      }),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
