import 'dart:async';
import 'dart:ui';

import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:my_global_tools/constants/asset_constants.dart';
import 'package:my_global_tools/route_management/route_path.dart';
import 'package:my_global_tools/screens/BottomNav/dash_setting_page.dart';
import 'package:my_global_tools/utils/picture_utils.dart';
import 'package:my_global_tools/utils/sized_utils.dart';
import 'package:my_global_tools/utils/text.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

bool showOnBoarding = false;

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage>
    with SingleTickerProviderStateMixin {
  late PageController controller;
  final CarouselController _carouselController = CarouselController();
  // Auto-play parameters
  final Duration autoPlayInterval = const Duration(seconds: 4);
  final Duration fadeDuration = const Duration(milliseconds: 1000);
  Timer? _autoPlayTimer;

  //Animation
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    controller = PageController(initialPage: 0);
    _autoPlayTimer = Timer.periodic(autoPlayInterval, (_) {
      if (currentPage < images.length - 1) {
        controller.nextPage(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      } else {
        controller.animateToPage(0,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut);
      }
    });
    _animationController =
        AnimationController(vsync: this, duration: fadeDuration);
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));
    super.initState();
  }

  List<String> images = [
    /*"https://images.pexels.com/photos/1191403/pexels-photo-1191403.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
    "https://images.pexels.com/photos/9020063/pexels-photo-9020063.png?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
    "https://images.pexels.com/photos/12437389/pexels-photo-12437389.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
    "https://images.pexels.com/photos/58997/pexels-photo-58997.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"*/
    "onBoardingSaloon.png",
    "onBoarding2.png",
    "onBoarding3.png",
    "verifyOTP.jpeg",
  ];
  final List<_OnboardingData> onBoardingData = [
    _OnboardingData(
      title: "Welcome to Our App",
      subtitle:
          "Discover new features, exciting content, and much more with our app. Get ready for an amazing experience.",
    ),
    _OnboardingData(
      title: "Easy Navigation",
      subtitle:
          "Our app provides a user-friendly and intuitive navigation system that helps you find what you need quickly and easily.",
    ),
    _OnboardingData(
      title: "Stay Informed",
      subtitle:
          "Receive real-time notifications about updates, news, and events so you never miss out on important information.",
    ),
    _OnboardingData(
      title: "Start Exploring",
      subtitle:
          "It's time to dive into the world of our app. Start exploring and enjoy the endless possibilities!",
    ),
  ];
  int currentPage = 0;
  @override
  void dispose() {
    _autoPlayTimer?.cancel();
    controller.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              buildPageView(context),
              Expanded(child: contentSlider(onBoardingData, currentPage)),
              Visibility(
                visible: currentPage == images.length - 1,
                child: Expanded(
                    child: Column(
                  children: [
                    FilledButton(
                        onPressed: () {
                          showOnBoarding = false;
                          context.go(RoutePath.login);
                        },
                        child: const Text('Get Started')),
                  ],
                )),
              ),
            ],
          ),
          Visibility(
            visible: currentPage < images.length - 1,
            child: Positioned(
              bottom: Get.height - 70,
              right: 20,
              child: GestureDetector(
                  onTap: () {
                    if (currentPage < images.length - 1) {
                      controller.jumpToPage(
                        images.length - 1,
                        // duration: const Duration(seconds: 1),
                        // curve: Curves.fastOutSlowIn,
                      );
                      return;
                    }
                    showOnBoarding = false;
                    context.go(RoutePath.login);
                  },
                  child: bodyLargeText(
                      currentPage < images.length - 1 ? 'Skip' : 'Login',
                      context,
                      color: getTheme.colorScheme.primary)),
            ),
          ),
          Positioned(
              bottom: Get.height - 90,
              left: 10,
              child: const ToggleBrightnessButton()),
          Positioned(
            bottom: 30,
            right: 0,
            left: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SmoothPageIndicator(
                  controller: controller,
                  count: images.length,
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey[300]!,
                    activeDotColor: getTheme.colorScheme.primary,
                    dotHeight: 12,
                    dotWidth: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  SizedBox buildPageView(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: getHeight * 0.6,
      child: PageView.builder(
          itemCount: images.length,
          pageSnapping: true,
          controller: controller,
          onPageChanged: (page) {
            setState(() => currentPage = page);
            _animationController.reset();
            _animationController.forward();
          },
          itemBuilder: (context, pagePosition) {
            bool active = pagePosition == currentPage;
            return imageSlider(images, pagePosition, active);
          }),
    );
  }

// Animated imageSlider widget
  Widget imageSlider(images, pagePosition, active) {
    double margin = active ? 10 : 20;

    return AnimatedBuilder(
      animation: _fadeAnimation,
      builder: (context, child) {
        return Opacity(opacity: _fadeAnimation.value, child: child);
      },
      child: Container(
        // duration: const Duration(milliseconds: 500),
        // curve: Curves.easeInOutCubic,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: assetImageProvider(images[pagePosition]),
              fit: BoxFit.contain),
        ),
      ),
    );
  }

// Animated contentSlider widget
  Widget contentSlider(List<_OnboardingData> onBoardingData, pagePosition) {
    return AnimatedBuilder(
      animation: _fadeAnimation,
      builder: (context, child) {
        return Opacity(opacity: _fadeAnimation.value, child: child);
      },
      child: Container(
        // duration: const Duration(milliseconds: 500),
        // curve: Curves.easeInOutCubic,
        padding: EdgeInsets.all(spaceDefault),
        decoration: const BoxDecoration(),
        child: Column(
          children: [
            titleLargeText(onBoardingData[pagePosition].title, context,
                fontWeight: FontWeight.bold,
                fontSize: 32,
                textAlign: TextAlign.center,
                maxLines: 2,
                color: getTheme.colorScheme.primary),
            height10(),
            Expanded(
              child: bodyLargeText(
                  onBoardingData[pagePosition].subtitle, context,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  textAlign: TextAlign.center,
                  maxLines: 100),
            )
          ],
        ),
      ),
    );
  }
}

class _OnboardingData {
  final String title;
  final String subtitle;

  _OnboardingData({
    required this.title,
    required this.subtitle,
  });
}
