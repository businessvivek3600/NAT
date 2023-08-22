import 'dart:math';

import 'package:animated_toast_list/animated_toast_list.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:my_global_tools/screens/BottomNav/dash_setting_page.dart';
import '../../repo_injection.dart';
import '../components/shop_card_widget.dart';
import '/constants/asset_constants.dart';
import '/route_management/route_animation.dart';
import '/route_management/route_name.dart';
import '/screens/components/service_card_widget.dart';
import '/utils/color.dart';
import '/utils/picture_utils.dart';
import '/providers/auth_provider.dart';
import '/providers/dashboard_provider.dart';
import '/providers/setting_provider.dart';
import '/route_management/route_path.dart';
import '/screens/chat/ChatPageExample.dart';
import '/screens/send_mail_page.dart';
import '/utils/default_logger.dart';
import '/utils/my_toasts.dart';
import 'dart:ui' as ui;
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:elegant_notification/resources/arrays.dart';
import '/utils/sized_utils.dart';
import '/widgets/activity_list_widget.dart';
import '/widgets/custom_bottom_sheet_dialog.dart';
import '/widgets/MultiStageButton.dart';
import '/widgets/FadeScaleTransitionWidget.dart';
import '/widgets/buttonStyle.dart';
import '/widgets/custom_steps_and_pages.dart';
import '/widgets/dialogs_page.dart';
import '/providers/connectivity_provider.dart';
import '/utils/my_advanved_toasts.dart';
import '/utils/text.dart';
import 'package:provider/provider.dart';

import '../../services/auth_service.dart';
import '../CachedMediaFileExamplePage.dart';
import '../FastCacheNetworkImageExamplePage.dart';
import '../concentric_onboarding.dart';
import '../container_overlay_example.dart';
import '../container_overlay_example2.dart';
import '../container_overlay_example3.dart';
import '../time_line_page/time_line_main_page.dart';

class DashHomePage extends StatefulWidget {
  DashHomePage({super.key});

  @override
  State<DashHomePage> createState() => _DashHomePageState();
}

class _DashHomePageState extends State<DashHomePage> {
  int tag = 1;
  final _dashProvider = sl.get<DashboardProvider>();
  @override
  void initState() {
    super.initState();
    _dashProvider.scrollController.addListener(_dashProvider.onScroll);
  }

  @override
  void dispose() {
    _dashProvider.scrollController.removeListener(_dashProvider.onScroll);
    // _dashProvider.scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final StreamAuth info = StreamAuthScope.of(context);
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        return Consumer<SettingProvider>(
          builder: (context, settingProvider, child) {
            return Stack(
              children: [
                // Background gradient with two colors
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        appLogoColor.withOpacity(0.1),
                        getTheme.colorScheme.primary.withOpacity(0.1),
                        // Color(0x66d0d4fc),
                        // Color(0x66d0d4fc),
                        // Color(0x7bfbe6cc),

                        // Color(0xFFFBE6CB),
                        // Color(0xFFD0D4FA),
                        // Color(0xFFF9D0DC),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
                // Apply blur effect to the gradient
                /*    BackdropFilter(
                  filter: ui.ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                  child: Container(
                    color: Colors.transparent,
                  ),
                ),*/
                // ui
                Scaffold(
                  backgroundColor: Colors.transparent,
                  body: Stack(
                    children: [
                      CustomScrollView(
                        controller: Provider.of<DashboardProvider>(context,
                                listen: true)
                            .scrollController,
                        slivers: [
                          buildAppBar(info, settingProvider, context),
                          SliverToBoxAdapter(child: buildBody(authProvider)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Consumer<ConnectivityProvider> buildBody(AuthProvider authProvider) {
    return Consumer<ConnectivityProvider>(
      builder: (context, provider, _) {
        return Padding(
          padding: const EdgeInsetsDirectional.symmetric(
              horizontal: 10, vertical: 20),
          child: Column(
            children: [
              buildTopCollections(context),
              height30(),
              buildHotTradings(context),
              height30(),
              buildJoinUs(context),
              height100(),
            ],
          ),
        );
      },
    );
  }

  Column buildBestServices(BuildContext context, List<String> options) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            bodyLargeText('Best Services Near You', context),
            TextButton(
                onPressed: () => context.pushNamed(RouteName.services,
                        queryParameters: {
                          'animation': RouteTransition.fromBottom.name,
                          'service': 'saloon'
                        }),
                child: capText('See All', context,
                    color: getTheme.colorScheme.primary))
          ],
        ),
        Container(
          height: 35.0,
          decoration: const BoxDecoration(),
          alignment: Alignment.centerLeft,
          child: ChipsChoice<int>.single(
            padding: EdgeInsets.zero,
            value: tag,
            onChanged: (val) => setState(() => tag = val),
            choiceItems: C2Choice.listFrom<int, String>(
              source: options,
              value: (i, v) => i,
              label: (i, v) => '$v $i (${Random().nextInt(100)})',
            ),
            choiceStyle: C2ChipStyle.toned(
                foregroundStyle: const TextStyle(fontSize: 10)),
          ),
        ),
        SizedBox(
          height: 200,
          child: ListView(
            padding: EdgeInsets.all(paddingDefault),
            scrollDirection: Axis.horizontal,
            children: [
              ...List.generate(
                  12,
                  (index) => Padding(
                        padding: EdgeInsets.only(right: paddingDefault),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: ServiceCard(index: index, applyBound: true),
                        ),
                      ))
            ],
          ),
        )
      ],
    );
  }

  Column buildBestShops(BuildContext context, List<String> options) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            bodyLargeText('Best Shops Near You', context),
            TextButton(
                onPressed: () => context.pushNamed(RouteName.services,
                        queryParameters: {
                          'animation': RouteTransition.fromBottom.name,
                          'service': 'saloon'
                        }),
                child: capText('See All', context,
                    color: getTheme.colorScheme.primary))
          ],
        ),
        Container(
          height: 35.0,
          decoration: const BoxDecoration(),
          alignment: Alignment.centerLeft,
          child: ChipsChoice<int>.single(
            padding: EdgeInsets.zero,
            value: tag,
            onChanged: (val) => setState(() => tag = val),
            choiceItems: C2Choice.listFrom<int, String>(
              source: options,
              value: (i, v) => i,
              label: (i, v) => '$v $i (${Random().nextInt(100)})',
            ),
            choiceStyle: C2ChipStyle.toned(
                foregroundStyle: const TextStyle(fontSize: 10)),
          ),
        ),
        SizedBox(
          height: 200,
          child: ListView(
            padding: EdgeInsets.all(paddingDefault),
            scrollDirection: Axis.horizontal,
            children: [
              ...List.generate(
                  12,
                  (index) => Padding(
                        padding: EdgeInsets.only(right: paddingDefault),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: ShopCard(index: index, applyBound: true),
                        ),
                      ))
            ],
          ),
        )
      ],
    );
  }

  Column buildJoinUs(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Container(
              height: getHeight > mobHeight ? 500 : 400,
              width: getWidth > mobWidth ? 400 : double.maxFinite,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                      color: getTheme.colorScheme.primary.withOpacity(0.5),
                      width: 5)),
              padding: EdgeInsets.only(top: spaceDefault),
            ),
            Positioned(
              top: spaceDefault,
              bottom: 0,
              left: 0,
              right: 0,
              child: buildCachedNetworkImage(
                  'https://www.nathorizon.com/public/user/images/thumb-banner.png',
                  fit: BoxFit.contain),
            ),
          ],
        ),
        height20(),
        Row(
          children: [
            assetImages(PNGAssets.appLogo, width: 50),
            width10(),
            titleLargeText('Join Us', context,
                fontSize: getWidth > mobWidth ? 32 : 25),
          ],
        ),
        height10(),
        titleLargeText('Create And Sell NFT With Cesea', context,
            fontSize: getWidth > mobWidth ? 32 : 25),
        height10(),
        bodyLargeText(
            'Create your own NFT and sell it on Cesea. You can also buy NFTs from other creators.',
            context),
        height10(),
        Wrap(
          runSpacing: 10,
          spacing: 10,
          children: [
            FilledButton(
              onPressed: () {},
              child: const Text('Create Item'),
            ),
            OutlinedButton(
              onPressed: () {},
              child: const Text('Sell Item'),
            ),
          ],
        )
      ],
    );
  }

  Column buildHotTradings(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  titleLargeText('Hot Trading', context),
                  bodyMedText(
                      'The most creative creator - Based on the last 30 days',
                      context),
                ],
              ),
            ),
            PopupMenuButton(
                onSelected: (val) {
                  // context.pushNamed(RouteName.categories, queryParameters: {
                  //   'animation': RouteTransition.fromBottom.name,
                  // });
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                color: getTheme.colorScheme.primary,
                position: PopupMenuPosition.under,
                offset: const Offset(0, 10),
                itemBuilder: (BuildContext context) {
                  return ['Recently Created', 'New Created']
                      .map((e) => PopupMenuItem(
                          value: e,
                          child: bodyLargeText(e, context,
                              color: darkMode ? Colors.black : Colors.white)))
                      .toList();
                },
                child: Icon(Icons.more_vert_rounded,
                    color: getTheme.colorScheme.primary))
          ],
        ),
        height10(),
        SizedBox(
          height: 30,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FilledButton(
                onPressed: () {},
                child: const Text('New NFT'),
              ),
              TextButton(
                  onPressed: () =>
                      context.pushNamed(RouteName.categories, queryParameters: {
                        'animation': RouteTransition.fromBottom.name,
                      }),
                  child: capText('View All', context,
                      color: getTheme.colorScheme.primary))
            ],
          ),
        ),
        height10(),
        GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: 10,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 0.7,
            ),
            itemBuilder: (context, index) {
              return LayoutBuilder(builder: (context, bound) {
                return Container(
                  padding: EdgeInsets.all(paddingDefault),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: bound.maxHeight * 0.7,
                        width: bound.maxWidth,
                        child: buildCachedNetworkImage(
                            'https://www.nathorizon.com/public/images/userNft/gemichan_logo_4x.jpg',
                            borderRadius: 10),
                      ),
                      height10(),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const CircleAvatar(
                                  radius: 8,
                                  backgroundImage: NetworkImage(
                                      'https://www.nathorizon.com/public/images/category/istockphoto-1022344990-612x612.jpg'),
                                ),
                                width5(),
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    capText('Owner', context, fontSize: 10),
                                    capText('NAPTdfdh RO', context,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500,
                                        maxLines: 1),
                                  ],
                                ))
                              ],
                            ),
                          ),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              capText('Current Price', context,
                                  fontSize: 10, maxLines: 1),
                              capText('1534 TBCC', context,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                  maxLines: 1),
                            ],
                          ))
                        ],
                      ),
                    ],
                  ),
                );
              });
            })
      ],
    );
  }

  Column buildTopCollections(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  titleLargeText('Top Collection', context),
                  bodyMedText(
                      'The most well-known Collection - Based on the last 30 days',
                      context),
                ],
              ),
            ),
            PopupMenuButton(
                onSelected: (val) {
                  // context.pushNamed(RouteName.categories, queryParameters: {
                  //   'animation': RouteTransition.fromBottom.name,
                  // });
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                color: getTheme.colorScheme.primary,
                position: PopupMenuPosition.under,
                offset: const Offset(0, 10),
                itemBuilder: (BuildContext context) {
                  return ['New Listed', 'New Created']
                      .map((e) => PopupMenuItem(
                          value: e,
                          child: bodyLargeText(e, context,
                              color: darkMode ? Colors.black : Colors.white)))
                      .toList();
                },
                child: Icon(Icons.more_vert_rounded,
                    color: getTheme.colorScheme.primary))
          ],
        ),
        height10(),
        SizedBox(
          height: 30,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FilledButton(
                onPressed: () {},
                child: const Text('New'),
              ),
              TextButton(
                  onPressed: () =>
                      context.pushNamed(RouteName.categories, queryParameters: {
                        'animation': RouteTransition.fromBottom.name,
                      }),
                  child: capText('View All', context,
                      color: getTheme.colorScheme.primary))
            ],
          ),
        ),
        height10(),
        ...List.generate(3, (index) {
          return Container(
            padding: EdgeInsets.all(paddingDefault),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://www.nathorizon.com/public/images/category/istockphoto-1022344990-612x612.jpg'),
                    ),
                    width10(),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        bodyLargeText('New NFT', context),
                        capText('created by NAPTRO', context),
                      ],
                    ))
                  ],
                ),
                height10(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        child: Container(
                      height: getHeight > mobHeight ? 200 : 150,
                      // width: getWidth > mobWidth ? 200 : getWidth * 0.6,
                      child: buildCachedNetworkImage(
                          'https://www.nathorizon.com/public/images/userNft/gemichan_logo_4x.jpg',
                          borderRadius: 10),
                    )),
                    width10(),
                    Expanded(child: LayoutBuilder(builder: (context, bound) {
                      return Column(
                        children: [
                          Container(
                            height: getHeight > mobHeight ? 95 : 70,
                            width: getWidth > mobWidth ? 200 : getWidth * 0.6,
                            child: buildCachedNetworkImage(
                                'https://www.nathorizon.com/public/images/userNft/Screenshot%202023-08-10%20122239.png',
                                borderRadius: 10),
                          ),
                          height10(),
                          Container(
                            height: getHeight > mobHeight ? 95 : 70,
                            width: getWidth > mobWidth ? 200 : getWidth * 0.6,
                            child: buildCachedNetworkImage(
                                'https://www.nathorizon.com/public/images/userNft/boredape_nft-1024x577.jpg',
                                borderRadius: 10),
                          ),
                        ],
                      );
                    })),
                  ],
                )
              ],
            ),
          );
        })
      ],
    );
  }

  SliverAppBar buildAppBar(
      StreamAuth info, SettingProvider settingProvider, BuildContext context) {
    return SliverAppBar(
      // title: Text(getLang.helloWorld),
      expandedHeight: (getWidth > 500 ? 180 : 150) + 120,
      pinned: true,
      title: Row(
        children: [
          buildCachedNetworkImage(
              'https://www.nathorizon.com/public/images/logomain.png',
              ph: 70,
              pw: 120,
              fit: BoxFit.contain),
        ],
      ),
      actions: [
        if (!Provider.of<DashboardProvider>(context, listen: true)
            .showTextField)
          IconButton(
              onPressed: () => goToHomeSearch(),
              icon: const Icon(Icons.search)),
        const ToggleBrightnessButton(),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    getTheme.colorScheme.primary.withOpacity(0.1),
                    appLogoColor.withOpacity(0.1),

                    // Color(0x7bfbe6cc),
                    // Color(0x66d0d4fc),
                    // Color(0xFFF9D0DC),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
            // Apply blur effect to the gradient

            Positioned(
              right: 0,
              bottom: 0,
              top: 0,
              left: getWidth * 0.1,
              child: buildCachedNetworkImage(
                  'https://www.nathorizon.com/public/user/images/slider-5.png',
                  opacity: 0.4,
                  fit: BoxFit.contain),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: paddingDefault * 2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  titleLargeText(
                      'Defined, Collect And Sell Super Rate NFT ', context,
                      fontSize: getWidth > 500 ? 32 : 25),
                  bodyMedText(
                      "Huge collection of NFTs from the world's best artists and creators.",
                      context),
                  height10(),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: GestureDetector(
                      onTap: () {
                        goToHomeSearch();
                      },
                      child: InputDecorator(
                        decoration: InputDecoration(
                            prefixIcon: SizedBox(
                              width: 100,
                              child: Row(
                                children: [
                                  width5(),
                                  SizedBox(
                                      width: 25,
                                      child: assetImages(PNGAssets.appLogo,
                                          color: getTheme.colorScheme.primary)),
                                  width5(),
                                  bodyLargeText('NAT', context),
                                  SizedBox(
                                      height: 25,
                                      child: VerticalDivider(
                                          color: getTheme.colorScheme.primary)),
                                ],
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: const BorderSide(
                                    color: Colors.transparent)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: const BorderSide(
                                    color: Colors.transparent))),
                        child: bodyMedText('Search Keywords...', context),
                      ),
                    ),
                  ),
                  height10(),
                  FilledButton(
                    onPressed: () {},
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('Explore'),
                        width10(),
                        const Icon((Icons.arrow_forward)),
                      ],
                    ),
                    // label: Text('Explore'),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void goToHomeSearch() {
  Get.context!.pushNamed(RouteName.search, queryParameters: {
    'animation': RouteTransition.fromBottom.name,
    'query': "apple"
  });
}

class _SliderWidget extends StatefulWidget {
  const _SliderWidget({super.key});

  @override
  State<_SliderWidget> createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<_SliderWidget> {
  int currentIndex = 0;
  late PageController controller;
  final CarouselController _controller = CarouselController();
  setIndex(int index, CarouselPageChangedReason reason) =>
      setState(() => currentIndex = index);
  @override
  void initState() {
    controller = PageController(initialPage: 0);
    controller.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<String> imgList = [
      'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
      'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
      'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
      'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
      'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
      'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
    ];
    final List<Widget> imageSliders = imgList
        .map((item) => Container(
              child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                  child: Stack(
                    children: <Widget>[
                      buildCachedNetworkImage(item, fit: BoxFit.cover),
                      Positioned(
                        bottom: 0.0,
                        left: 0.0,
                        right: 0.0,
                        child: Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color.fromARGB(200, 0, 0, 0),
                                Color.fromARGB(0, 0, 0, 0)
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          child: Text(
                            'No. ${imgList.indexOf(item)} image',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
            ))
        .toList();
    return Stack(
      children: [
        Container(
            constraints: const BoxConstraints(
                maxHeight: 120, maxWidth: 500, minWidth: 400, minHeight: 100),
            child: CarouselSlider(
              options: CarouselOptions(
                  // height: Get.height * 0.15,
                  aspectRatio: 16 / 9,
                  viewportFraction: 1,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  enlargeFactor: 0.3,
                  scrollDirection: Axis.horizontal,
                  onPageChanged: setIndex),
              items: imageSliders,
            )),
        Positioned(
          bottom: 0,
          right: 0,
          left: 0,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, getTheme.secondaryHeaderColor],
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: imgList.asMap().entries.map((entry) {
                return GestureDetector(
                  onTap: () => _controller.animateToPage(entry.key),
                  child: Container(
                    width: 8.0,
                    height: 8.0,
                    margin: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 4.0),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: getTheme.colorScheme.primary.withOpacity(
                            currentIndex == entry.key ? 0.9 : 0.4)),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}

//demos

Column buildDemoColumn(ConnectivityProvider provider, BuildContext context,
    AuthProvider authProvider) {
  return Column(
    children: [
      Center(
        child: Text(
          provider.getOnline ? 'Online' : 'Offline',
          style: const TextStyle(fontSize: 24),
        ),
      ),
      TextFormField(),
      FilledButton(
          onPressed: () => Toasts.warningBanner(),
          child: const Icon(Icons.add)),
      FilledButton(
        onPressed: () => Toasts.showAwesomeToast(context,
            title: 'title',
            content: 'content',
            contentType: ContentType.success,
            asBanner: true),
        child: const Icon(Icons.add_a_photo),
      ),
      FilledButton(
        onPressed: () => context
            .showToast(MyToastModel(ToastType.failed.name, ToastType.success)),
        child: const Icon(Icons.add_a_photo),
      ),
      bodyLargeText('Elegant Notifications', context),
      MyCustomAnimatedWidget(
        child: FilledButton(
          onPressed: () => AdvanceToasts.showNormalElegant(
              context, 'An elegant notification to display important',
              showProgressIndicator: false,
              notificationType: NotificationType.success),
          child: const Icon(Icons.animation),
        ),
      ),
      FilledButton(
        onPressed: () => AdvanceToasts.showNormalElegant(
            context, 'An elegant notification to display important',
            showProgressIndicator: false,
            notificationType: NotificationType.info),
        child: const Icon(Icons.add_a_photo),
      ),
      FilledButton(
        onPressed: () => AdvanceToasts.showNormalElegant(
            context, 'An elegant notification to display important',
            aDuration: 300,
            tDuration: 7000,
            action: linkifyText(
                'Contact Us: https://www.mycarclub.com/refCode?sponsor=tds'),
            onActionPressed: () =>
                logD('https://www.mycarclub.com/refCode?sponsor=tds'),
            notificationType: NotificationType.error),
        child: const Icon(Icons.add_a_photo),
      ),
      FilledButton(
        onPressed: () => AdvanceToasts.showNormalElegant(context,
            'An elegant notification to display important messages to users',
            showProgressIndicator: false,
            showLeading: false,
            showTrailing: false),
        child: const Icon(Icons.add_a_photo),
      ),
      FilledButton(
        onPressed: () => AdvanceToasts.showNormalElegant(
            context, 'An elegant notification to display important',
            // aDuration: 300,
            // tDuration: 7000,
            // action: linkifyText(
            //     'https://www.mycarclub.com/refCode?sponsor=tds'),
            // onActionPressed: () => log(
            //     'https://www.mycarclub.com/refCode?sponsor=tds'),
            // showLeading: false,
            // showTrailing: false,
            showProgressIndicator: false,
            notificationType: NotificationType.error),
        child: const Icon(Icons.add_a_photo),
      ),
      const Divider(),
      bodyLargeText('Dialogs', context),
      FilledButton(
        onPressed: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => const DialogPage())),
        child: const Icon(Icons.add_a_photo),
      ),
      const Divider(),
      bodyLargeText('Web View', context),
      FilledButton(
        onPressed: () => context.goNamed(RoutePath.web, queryParameters: {
          'url': 'https://vimeo.com/event/3582236/embed',
          'showAppBar': '1',
          'showToast': '0',
          'changeOrientation': '0',
        }),
        child: const Icon(Icons.map_sharp),
      ),
      const Divider(),
      /*GestureDetector(
                onTap: () =>
                    context.goNamed(RoutePath.explore, queryParameters: {
                  'url': 'https://vimeo.com/event/3582236/embed',
                  'showAppBar': '0',
                  'changeOrientation': '1',
                  'showToast': '0',
                }),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: SizedBox(
                    height: Get.width * 0.5,
                    child: Stack(
                      children: [
                        const WebViewExample(
                          url: 'https://vimeo.com/event/3582236/embed',
                          showAppBar: '0',
                          changeOrientation: '0',
                          showToast: '0',
                        ),
                        Container(
                          color: Colors.transparent,
                          width: double.maxFinite,
                          height: double.maxFinite,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const Divider(),*/
      bodyLargeText('Multi Stage Button', context),
      Row(
        children: [
          Expanded(
            child: MultiStageButton(
                // idleIcon: const Icon(Icons.start,color: Colors.black),
                // completedIcon: SizedBox(
                //     height: 30,
                //     width: 30,
                //     child: assetRive(RiveAssets.successDone)),
                loadingText: 'Loading...',
                buttonLoadingState: authProvider.loginStatus,
                // idleColor: Colors.white,
                // completedColor: Colors.white,
                // failColor: Colors.white,
                // idleTextColor: Colors.black,
                // failTextColor: Colors.red,
                // completedTextColor: Colors.green,
                helperText: authProvider.errorText,
                onPressed: () => authProvider.login(status: false)),
          ),
        ],
      ),
      const Divider(),
      bodyLargeText('Bottom Sheets', context),
      FilledButton(
          onPressed: () => showCustomBottomSheet(context),
          child: const Text('Custom Bottom Sheet')),
      const Divider(),
      bodyLargeText('Multi Step Widget', context),
      FilledButton(
        onPressed: () => Navigator.push(context,
            MaterialPageRoute(builder: (_) => const MultiStepWidget())),
        child: const Text('Multi Step Widget'),
      ),
      const Divider(),
      bodyLargeText('Custom Activity Widget', context),
      FilledButton(
        onPressed: () => Navigator.push(context,
            MaterialPageRoute(builder: (_) => const CustomActivityList())),
        child: const Text('Multi Step Widget'),
      ),
      const Divider(),
      bodyLargeText('My TimeLine App', context),
      FilledButton(
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (_) => const MyTimeLineApp())),
        child: const Text('My TimeLine App'),
      ),
      const Divider(),
      bodyLargeText('Container Overlay Example', context),
      FilledButton(
        onPressed: () => Navigator.push(context,
            MaterialPageRoute(builder: (_) => ContainerOverlayExample())),
        child: const Text('Container Overlay Example'),
      ),
      FilledButton(
        onPressed: () => Navigator.push(context,
            MaterialPageRoute(builder: (_) => const MyShowcaseViewApp())),
        child: const Text('Container Overlay Example 2'),
      ),
      FilledButton(
        onPressed: () => Navigator.push(context,
            MaterialPageRoute(builder: (_) => const MyTutorialCoachMarkPage())),
        child: const Text('Container Overlay Example 3'),
      ),
      const Divider(),
      bodyLargeText('Concentric OnBoarding Example', context),
      FilledButton(
        onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => const ConcentricOnBoardingExample())),
        child: const Text('Concentric OnBoarding Example'),
      ),
      const Divider(),
      bodyLargeText('OnBoarding Screen Package', context),
      FilledButton(
        onPressed: () {},
        child: const Text('flutter_overboard: ^3.1.1'),
      ),
      const Divider(),
      bodyLargeText('Chat App Example', context),
      FilledButton(
        onPressed: () {
          Get.to(const ChatScreen());
        },
        child: const Text('Chat App Example'),
      ),
      const Divider(),
      bodyLargeText('Fast Cache NetworkImage ExamplePage', context),
      FilledButton(
        onPressed: () {
          Get.to(const FastCacheNetworkImageExamplePage());
        },
        child: const Text('Fast Cache Network Image ExamplePage'),
      ),
      const Divider(),
      bodyLargeText('Cached Media File ExamplePage', context),
      FilledButton(
        onPressed: () {
          Get.to(const CachedMediaFileExamplePage());
        },
        child: const Text('Cached Media File ExamplePage'),
      ),
      const Divider(),
      bodyLargeText('Email Sender Page ExamplePage', context),
      FilledButton(
        onPressed: () {
          Get.to(const EmailSenderPage());
        },
        child: const Text('Email Sender Page ExamplePage'),
      ),
      height100(),
    ],
  );
}

void showCustomBottomSheet(BuildContext context) {
  CustomBottomSheet.show(
    context: context,
    curve: Curves.bounceIn,
    duration: 200,
    dismissible: false,
    onDismiss: () async {
      bool? willPop = await CustomBottomSheet.show<bool>(
        context: context,
        // backgroundColor: Colors.transparent,
        showCloseIcon: false,
        curve: Curves.bounceIn,
        builder: (context) => Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              children: [
                Expanded(
                  child: FilledButton(
                    style: buttonStyle(bgColor: Colors.green),
                    onPressed: () => Navigator.pop(context, true),
                    child: const Text('Confirm'),
                  ),
                ),
              ],
            ),
            const Divider(),
            Row(
              children: [
                Expanded(
                  child: FilledButton(
                    style: buttonStyle(bgColor: Colors.red),
                    onPressed: () => Navigator.pop(context, false),
                    child: const Text('Cancel'),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
      logD('will pop scope $willPop');
      return willPop ?? false;
    },
    builder: (context) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Custom Bottom Sheet',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          const FlutterLogo(size: 100),
          const SizedBox(height: 20),
          ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close')),
        ],
      );
    },
  );
}
