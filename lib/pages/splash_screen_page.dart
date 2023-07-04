import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tmdb_movie/base/base_image.dart' as baseImage;
import 'package:tmdb_movie/base/base_colors.dart' as baseColors;
import 'package:tmdb_movie/base/base_dimens.dart' as baseDimens;
import 'package:tmdb_movie/pages/home_page.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  Widget build(BuildContext context) {
    var assetImage = const AssetImage(baseImage.appLogo);
    var logoImage = Image(
      image: assetImage,
      height: 300,
    );

    var screenHeigth = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    Timer(
        const Duration(seconds: 3),
        (() => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => const HomePage()))));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          color: Colors.white,
          child: Stack(
            children: [
              Center(
                child: logoImage,
              ),
              Positioned(
                bottom: screenHeigth / 25,
                left: 7 * screenWidth / 20,
                right: 7 * screenWidth / 20,
                child: Column(children: [
                  Container(
                    width: baseDimens.versionWidth,
                    height: baseDimens.versionHeight,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(
                            baseDimens.circularBorderVersionButton),
                        border: Border.all(
                            color: const Color(baseColors.primaryColor),
                            width: 2)),
                    child: const Center(
                      child: Text('v1.0.0',
                          style:
                              TextStyle(color: Color(baseColors.primaryColor))),
                    ),
                  ),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
