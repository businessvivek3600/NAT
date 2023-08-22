import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:go_router/go_router.dart';
import 'package:my_global_tools/constants/asset_constants.dart';
import 'package:my_global_tools/route_management/route_name.dart';
import 'package:my_global_tools/screens/BottomNav/dash_setting_page.dart';
import 'package:my_global_tools/utils/sized_utils.dart';
import 'package:my_global_tools/utils/text.dart';

import '../../utils/color.dart';
import '../../utils/picture_utils.dart';

class Explore extends StatefulWidget {
  const Explore({super.key, this.backAllowed = true});
  final bool backAllowed;
  @override
  State<Explore> createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // return const NFTDetails();
    return Scaffold(
      appBar: widget.backAllowed ? AppBar(title: const Text('Explore')) : null,
      body: SafeArea(
        child: Stack(
          children: [
            // Background gradient with two colors
            SizedBox(
              height: getHeight * 0.5,
              width: double.maxFinite,
              child: buildCachedNetworkImage(
                  'https://www.nathorizon.com/public/user/images/thumb-pagetitle.png',
                  fit: BoxFit.cover),
            ),
            Container(
              height: getHeight * 0.5,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  getTheme.colorScheme.background,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              )),
            ),
            // Apply blur effect to the gradient
            // BackdropFilter(
            //   filter: ui.ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
            //   child: Container(
            //     color: Colors.transparent,
            //   ),
            // ),
            // ui
            Scaffold(
              backgroundColor: Colors.transparent,
              body: Stack(
                children: [
                  CustomScrollView(
                    slivers: [
                      // buildAppBar(context),
                      SliverToBoxAdapter(
                          child: GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              padding: const EdgeInsets.only(
                                  top: kToolbarHeight * 2),
                              shrinkWrap: true,
                              itemCount: 19,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                                childAspectRatio: 0.7,
                              ),
                              itemBuilder: (context, index) {
                                return LayoutBuilder(builder: (context, bound) {
                                  return GestureDetector(
                                    onTap: () =>
                                        context.pushNamed(RouteName.nftDetails),
                                    child: Card(
                                      child: Container(
                                        padding: EdgeInsets.all(paddingDefault),
                                        decoration: BoxDecoration(
                                            // border: Border.all(color: Colors.grey),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const CircleAvatar(
                                                  radius: 8,
                                                  backgroundImage: NetworkImage(
                                                      'https://www.nathorizon.com/public/user/images/avatars/logo-com.png'),
                                                ),
                                                width5(),
                                                Expanded(
                                                    child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    capText('Creator', context,
                                                        fontSize: 10),
                                                    capText('NFT-9f96dc39feb2',
                                                        context,
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        maxLines: 1),
                                                  ],
                                                ))
                                              ],
                                            ),
                                            height10(),
                                            Expanded(
                                              child: SizedBox(
                                                height: bound.maxHeight,
                                                width: bound.maxWidth,
                                                child: buildCachedNetworkImage(
                                                    'https://www.nathorizon.com/public/images/userNft/gemichan_logo_4x.jpg',
                                                    borderRadius: 10),
                                              ),
                                            ),
                                            height10(),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                assetImages(PNGAssets.appLogo,
                                                    width: 15),
                                                capText(
                                                    '${Random().nextInt(10000)} TBCC',
                                                    context,
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w500,
                                                    maxLines: 1),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                });
                              })),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NFTDetails extends StatelessWidget {
  const NFTDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            buildAppBar(context),
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildTabs(context),
                    height10(),
                    TimerBasic(
                      format: CountDownTimerFormat.daysHoursMinutesSeconds,
                      inverted: true,
                      description: 'Current Price   💎 35 TBCC',
                      onEnd: () {},
                      dateTime: DateTime.now().add(const Duration(seconds: 30)),
                    ),
                    const SizedBox(height: 16.0),
                    buildNFTDetails(),
                    height20(),
                    buildExploreMore(context),
                    height50(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  SizedBox buildExploreMore(BuildContext context) {
    return SizedBox(
      height: 250,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          titleLargeText('Explore More', context),
          height10(),
          Expanded(
              child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              ...List.generate(
                5,
                (index) => LayoutBuilder(builder: (context, bound) {
                  return Card(
                    margin: EdgeInsets.only(
                        right: spaceDefault, bottom: paddingDefault * 2),
                    child: Container(
                      width: 180,
                      padding: EdgeInsets.all(paddingDefault),
                      decoration: BoxDecoration(
                          // border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: bodyLargeText('Monkey Fashion', context,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    maxLines: 1,
                                    textAlign: TextAlign.end),
                              ),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const CircleAvatar(
                                radius: 8,
                                backgroundImage: NetworkImage(
                                    'https://www.nathorizon.com/public/user/images/avatars/logo-com.png'),
                              ),
                              width5(),
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  capText('Creator', context, fontSize: 10),
                                  width5(),
                                  capText('NFT-9f96dc39feb2', context,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                      maxLines: 1),
                                ],
                              ))
                            ],
                          ),
                          height10(),
                          Expanded(
                            child: SizedBox(
                              height: bound.maxHeight,
                              width: bound.maxWidth,
                              child: buildCachedNetworkImage(
                                  'https://www.nathorizon.com/public/images/userNft/gemichan_logo_4x.jpg',
                                  borderRadius: 10),
                            ),
                          ),
                          height10(),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              assetImages(PNGAssets.appLogo, width: 15),
                              width5(),
                              capText(
                                  '${Random().nextInt(10000)} TBCC', context,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                  maxLines: 1),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              )
            ],
          )),
        ],
      ),
    );
  }

  Column buildNFTDetails() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://www.nathorizon.com/public/images/userNft/Screenshot%202023-08-10%20122239.png'), // Replace with the actual image URL
              radius: 18.0,
            ),
            SizedBox(width: 12.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('NATPRO',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                Text('Current Owner'),
              ],
            ),
          ],
        ),
        SizedBox(height: 16.0),
        Text('New Ape Club',
            style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold)),
        Text('Quick and easy breakfast recipes to start your day',
            style: TextStyle(fontSize: 16.0)),
        SizedBox(height: 16.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Hash Power', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('0.0004'),
          ],
        ),
        SizedBox(height: 16.0),
        // Tabs and content here
        // Add code for tabs and content
        SizedBox(height: 16.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Current Price',
                style: TextStyle(fontWeight: FontWeight.bold)),
            Row(
              children: [
                Icon(Icons.attach_money),
                Text('35 TBCC'),
              ],
            ),
          ],
        ),
        SizedBox(height: 16.0),
      ],
    );
  }

  Column buildTabs(BuildContext context) {
    return Column(
      children: [
        const TabBar(
          tabs: [
            Tab(
              text: 'Details',
            ),
            Tab(
              text: 'Order History',
            ),
          ],
        ),
        SizedBox(
          height: 200,
          child: TabBarView(
            children: [
              // Content for the "Details" tab
              // Replace this with your Details content
              Container(
                padding: EdgeInsets.all(paddingDefault),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          capText('Current Owner', context),
                          height5(),
                          Row(
                            children: [
                              const CircleAvatar(
                                  radius: 10,
                                  backgroundImage: NetworkImage(
                                      'https://www.nathorizon.com/public/user/images/avatars/logo-com.png')),
                              width10(),
                              titleLargeText('NATPRO', context),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          capText('Creator', context),
                          height5(),
                          Row(
                            children: [
                              const CircleAvatar(
                                  radius: 10,
                                  backgroundImage: NetworkImage(
                                      'https://www.nathorizon.com/public/user/images/author-detail-3.png')),
                              width10(),
                              titleLargeText('TBCC', context),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Content for the "Order History" tab
              // Replace this with your Order History content
              Container(
                  child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  ...List.generate(
                    5,
                    (index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const CircleAvatar(
                              radius: 15,
                              backgroundImage: NetworkImage(
                                  'https://www.nathorizon.com/public/user/images/author-detail-3.png')),
                          width10(),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                titleLargeText('57750092', context),
                                capText('1 week ago', context),
                              ],
                            ),
                          ),
                          width10(),
                          bodyMedText('20 TBCC', context),
                        ],
                      ),
                    ),
                  )
                ],
              )),
            ],
          ),
        ),
      ],
    );
  }

  SliverAppBar buildAppBar(BuildContext context) {
    return SliverAppBar(
      // title: Text(getLang.helloWorld),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(35),
        bottomRight: Radius.circular(35),
      )),
      // expandedHeight: (getWidth > 500 ? 180 : 150) + 120,
      collapsedHeight: 120,
      leading: IconButton.filled(
          onPressed: () {
            context.pop();
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              color: Colors.white)),
      pinned: true,
      /*title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          titleLargeText('NFT-0c08e55dd907', context),
          capText('NFT created by NATPRO', context),
        ],
      ),*/
      backgroundColor: getTheme.colorScheme.primary,
      actions: [
        const ToggleBrightnessButton(),
        const CircleAvatar(
          backgroundImage: NetworkImage(
              'https://www.nathorizon.com/public/images/userNft/Screenshot%202023-08-10%20122239.png'), // Replace with the actual image URL
          radius: 18.0,
        ),
        width10(),
      ],
      flexibleSpace: FlexibleSpaceBar(
        expandedTitleScale: 1.2,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            titleLargeText('Hash Power', context, color: Colors.white),
            width10(),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(4.0),
              ),
              padding:
                  EdgeInsets.symmetric(horizontal: paddingDefault, vertical: 4),
              child: bodyMedText(
                '0.004',
                context,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        // Column(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   mainAxisAlignment: MainAxisAlignment.end,
        //   children: [
        //     titleLargeText('NFT-0c08e55dd907', context, color: Colors.white),
        //     capText('NFT created by NATPRO', context, color: Colors.white),
        //   ],
        // ),
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

            /* Padding(
              padding: EdgeInsets.symmetric(horizontal: paddingDefault * 2),
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(vertical: paddingDefault),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          titleLargeText('Hash Power', context,
                              color: Colors.white),
                          width10(),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: paddingDefault, vertical: 4),
                            child: bodyMedText(
                              '0.004',
                              context,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),*/
          ],
        ),
      ),
    );
  }
}

class TimerBasic extends StatelessWidget {
  final CountDownTimerFormat format;
  final VoidCallback onEnd;
  final String description;
  final bool inverted;
  final DateTime dateTime;

  const TimerBasic({
    required this.format,
    required this.description,
    this.inverted = false,
    Key? key,
    required this.onEnd,
    required this.dateTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: inverted ? 20 : 30),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: inverted ? CupertinoColors.white : purple,
          border: Border.all(
            width: 2,
            color: inverted ? purple : Colors.transparent,
          ),
        ),
        child: Column(children: [
          Text(
            description,
            style: TextStyle(
              fontSize: 20,
              letterSpacing: 0,
              color: inverted ? purple : CupertinoColors.white,
            ),
          ),
          const SizedBox(height: 20),
          TimerCountdown(
            format: format,
            endTime: dateTime,
            onEnd: onEnd,
            timeTextStyle: TextStyle(
              color: (inverted) ? purple : CupertinoColors.white,
              fontWeight: FontWeight.w300,
              fontSize: 40,
              fontFeatures: const <FontFeature>[
                FontFeature.tabularFigures(),
              ],
            ),
            colonsTextStyle: TextStyle(
              color: (inverted) ? purple : CupertinoColors.white,
              fontWeight: FontWeight.w300,
              fontSize: 40,
              fontFeatures: const <FontFeature>[
                FontFeature.tabularFigures(),
              ],
            ),
            descriptionTextStyle: TextStyle(
              color: (inverted) ? purple : CupertinoColors.white,
              fontSize: 10,
              fontFeatures: const <FontFeature>[
                FontFeature.tabularFigures(),
              ],
            ),
            spacerWidth: 0,
            daysDescription: "days",
            hoursDescription: "hours",
            minutesDescription: "minutes",
            secondsDescription: "seconds",
          ),
        ]));
  }
}

const Color purple = Color.fromARGB(255, 63, 45, 149);
