import 'dart:math';

import 'package:collapsible_sidebar/collapsible_sidebar.dart';
import 'package:collapsible_sidebar/collapsible_sidebar/collapsible_container.dart';
import 'package:collapsible_sidebar/collapsible_sidebar/collapsible_item_selection.dart';
import 'package:collapsible_sidebar/collapsible_sidebar/collapsible_item_widget.dart';
import 'package:elegant_notification/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:loadmore/loadmore.dart';
import '../../../functions/functions.dart';
import '../../../widgets/time_line/src/connector_theme.dart';
import '../../../widgets/time_line/src/connectors.dart';
import '../../../widgets/time_line/src/indicator_theme.dart';
import '../../../widgets/time_line/src/indicators.dart';
import '../../../widgets/time_line/src/timeline_theme.dart';
import '../../../widgets/time_line/src/timeline_tile_builder.dart';
import '../../../widgets/time_line/src/timelines.dart';
import '/utils/my_advanved_toasts.dart';
import '/utils/my_toasts.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:share_plus/share_plus.dart';
import 'package:simple_progress_indicators/simple_progress_indicators.dart';
import '../../BottomNav/dash_setting_page.dart';
import '/utils/picture_utils.dart';
import '/utils/sized_utils.dart';
import '/utils/text.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key, required this.service, required this.shop});
  final String service;
  final String shop;

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late List<CollapsibleItem> items;
  String? _headline;
  late int tabIndex;

  @override
  void initState() {
    super.initState();
    items = _generateItems;
    _headline = items.firstWhere((item) => item.isSelected).text;
    tabIndex = items.indexWhere((item) => item.isSelected);
  }

  setTab(String title, String s) async {
    setState(() {
      _headline = s;
      tabIndex = _generateItems.indexWhere((element) => element.text == title);
    });
    scaffoldKey.currentState!.closeDrawer();
  }

  List<CollapsibleItem> get _generateItems {
    return [
      CollapsibleItem(
        text: 'Dashboard',
        icon: Icons.assessment,
        onPressed: () => setTab('Dashboard', 'Dashboard'),
        onHold: () => ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Dashboard"))),
        isSelected: true,
      ),
      CollapsibleItem(
        text: 'Inventory',
        icon: Icons.photo_library,
        onPressed: () => setTab('Inventory', 'NFT Gallery'),
        onHold: () => ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("NFT Gallery"))),
      ),
      CollapsibleItem(
        text: 'NAT Wallet',
        icon: Icons.wallet,
        onPressed: () => setTab('NAT Wallet', 'NAT Wallet'),
        onHold: () => ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("NAT Wallet"))),
      ),
      CollapsibleItem(
        text: 'Staking Wallets',
        icon: Icons.wallet,
        onPressed: () => setTab('Staking Wallets', 'Staking Wallet'),
        onHold: () => ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Staking Wallets"))),
      ),
      CollapsibleItem(
        text: 'Commission Wallet',
        icon: Icons.account_balance_wallet_rounded,
        onPressed: () => setTab('Commission Wallet', 'Commission Wallet'),
        onHold: () => ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Commission Wallet"))),
      ),
      CollapsibleItem(
        text: 'TBCC Wallet',
        icon: Icons.account_balance_wallet_sharp,
        onPressed: () => setTab('TBCC Wallet', 'TBCC Wallet'),
        onHold: () => ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("TBCC Wallet"))),
      ),
      CollapsibleItem(
        text: 'My Team',
        icon: Icons.people,
        onPressed: () => setTab('My Team', 'My Team'),
        onHold: () => ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("TBCC Wallet"))),
      ),
      CollapsibleItem(
        text: 'Account Setting',
        icon: Icons.manage_accounts_rounded,
        onPressed: () => setTab('Account Setting', 'Edit Profile'),
        onHold: () => ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Account Setting"))),
      ),
      CollapsibleItem(
        text: 'Subscription',
        icon: Icons.subscriptions_outlined,
        onPressed: () => setTab('Subscription', 'NAT Subscription'),
        onHold: () => ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Subscription"))),
      ),
    ];
  }

  double iconSize = 25;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => primaryFocus?.unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        drawer: buildDrawer(scaffoldKey),
        body: Stack(
          children: [
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
            SizedBox(height: getHeight, width: double.maxFinite),
            Positioned(
                top: kToolbarHeight,
                left: spaceDefault,
                child: IconButton(
                    onPressed: () async {
                      scaffoldKey.currentState?.openDrawer();

                      // context.pop();
                      // Future.delayed(Duration(seconds: 1),
                      //     () => scaffoldKey.currentState?.closeDrawer());
                      // await future(
                      //     1000, () => scaffoldKey.currentState?.closeDrawer());
                    },
                    icon: const Icon(Icons.menu_open, color: Colors.white))),
            Positioned(
                top: getHeight * 0.1,
                right: 0,
                left: 0,
                bottom: 0,
                child: _DashBoardBodyWidget(
                    tabIndex: tabIndex,
                    title: items[tabIndex].text,
                    headline: _headline)),
            const Positioned(
                top: kToolbarHeight,
                right: 20,
                child: ToggleBrightnessButton()),
          ],
        ),
      ),
    );
  }

  Drawer buildDrawer(GlobalKey<ScaffoldState> scaffoldKey) {
    print(tabIndex);
    return Drawer(
      backgroundColor: Colors.transparent,
      child: Padding(
        padding:
            const EdgeInsets.only(left: 20, top: kToolbarHeight, bottom: 20),
        child: GestureDetector(
          // onHorizontalDragUpdate: _onHorizontalDragUpdate,
          // onHorizontalDragEnd: _onHorizontalDragEnd,
          child: CollapsibleContainer(
            height: double.maxFinite,
            width: 100,
            padding: 10,
            borderRadius: 10,
            color: getTheme.colorScheme.background,
            sidebarBoxShadow: const [
              BoxShadow(
                color: Colors.transparent,
                blurRadius: 0,
                spreadRadius: 0.01,
                offset: Offset(0, 0),
              ),
              BoxShadow(
                color: Colors.transparent,
                blurRadius: 0,
                spreadRadius: 0.01,
                offset: Offset(0, 0),
              ),
            ],
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    radius: 35,
                    backgroundImage: NetworkImage(
                        'https://www.nathorizon.com/public/user/images/author29.png'),
                  ),
                  height10(),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      reverse: false,
                      child: Stack(
                        children: [
                          CollapsibleItemSelection(
                            height: (10 * 2 + iconSize).toDouble(),
                            offsetY: (10 * 2 + iconSize) * (tabIndex),
                            color: getTheme.colorScheme.primary,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeIn,
                          ),
                          Column(
                            children: List.generate(items.length, (index) {
                              var item = items[index];
                              Color iconColor = Colors.grey;
                              Color textColor = Colors.grey;
                              if (tabIndex == index) {
                                iconColor = Colors.white;
                                textColor = Colors.white;
                              }
                              return CollapsibleItemWidget(
                                onHoverPointer: MouseCursor.defer,
                                padding: 10,
                                offsetX: 0,
                                scale: 0.9,
                                leading: item.iconImage != null
                                    ? CircleAvatar(
                                        radius: 40 / 2,
                                        backgroundImage: item.iconImage,
                                        backgroundColor: Colors.transparent,
                                      )
                                    : (item.icon != null
                                        ? Icon(
                                            item.icon,
                                            size: iconSize,
                                            color: iconColor,
                                          )
                                        : SizedBox(
                                            width: iconSize,
                                            height: iconSize,
                                          )),
                                iconSize: iconSize,
                                iconColor: iconColor,
                                title: item.text,
                                textStyle: TextStyle(
                                    color: textColor,
                                    fontWeight: FontWeight.bold),
                                isCollapsed: false,
                                minWidth: 100,
                                isSelected: item.isSelected,
                                parentComponent: true,
                                onTap: () {
                                  print('tab index is $tabIndex');
                                  if (tabIndex == index) return;
                                  item.onPressed();
                                  item.isSelected = true;
                                  items[tabIndex].isSelected = false;
                                  setState(() => tabIndex = index);
                                },
                                onLongPress: () {
                                  if (item.onHold != null) {
                                    item.onHold!();
                                  }
                                },
                                subItems: item.subItems,
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
                  ),
                  height10(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _DashBoardBodyWidget extends StatefulWidget {
  const _DashBoardBodyWidget(
      {super.key, required this.tabIndex, this.title, this.headline});
  final int tabIndex;
  final String? title;
  final String? headline;

  @override
  _DashBoardBodyWidgetState createState() => _DashBoardBodyWidgetState();
}

class _DashBoardBodyWidgetState extends State<_DashBoardBodyWidget> {
  // late List<CollapsibleItem> _items;
  // String? _headline;
  // late int tabIndex;

  @override
  void initState() {
    super.initState();
    // _items = _generateItems;
    // _headline = _items.firstWhere((item) => item.isSelected).text;
    // tabIndex = _items.indexWhere((item) => item.isSelected);
  }

/*  setTab(String title, index) => setState(() {
        _headline = title;
        // tabIndex = index;
      });
  List<CollapsibleItem> get _generateItems {
    return [
      CollapsibleItem(
          text: 'Dashboard',
          icon: Icons.assessment,
          onPressed: () => setTab('DashBoard'),
          onHold: () => ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Dashboard"))),
          isSelected: true,
          subItems: [
            CollapsibleItem(
              text: 'Menu',
              icon: Icons.menu_book,
              onPressed: () => setTab('Menu''),
              onHold: () => ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text("Menu"))),
              isSelected: true,
            ),
            CollapsibleItem(
                text: 'Shop',
                iconImage: const AssetImage("assets/shop_icon.png"),
                icon: Icons.ac_unit,
                onPressed: () => setTab('Shop''),
                onHold: () => ScaffoldMessenger.of(context)
                    .showSnackBar(const SnackBar(content: Text("Shop"))),
                isSelected: true,
                subItems: [
                  CollapsibleItem(
                    text: 'Cart',
                    icon: Icons.shopping_cart,
                    onPressed: () => setTab('Cart''),
                    onHold: () => ScaffoldMessenger.of(context)
                        .showSnackBar(const SnackBar(content: Text("Cart"))),
                    isSelected: true,
                  )
                ]),
          ]),
      CollapsibleItem(
        text: 'Inventory',
        icon: Icons.photo_library,
        onPressed: () => setTab('NFT Gallery'),
        onHold: () => ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("NFT Gallery"))),
      ),
      CollapsibleItem(
        text: 'NAT Wallet',
        icon: Icons.wallet,
        onPressed: () => setTab('NAT Wallet'),
        onHold: () => ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("NAT Wallet"))),
      ),
      CollapsibleItem(
        text: 'Commission Wallet',
        icon: Icons.account_balance_wallet_rounded,
        onPressed: () => setTab('Commission Wallet'),
        onHold: () => ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Commission Wallet"))),
      ),
      CollapsibleItem(
        text: 'TBCC Wallet',
        icon: Icons.account_balance_wallet_sharp,
        onPressed: () => setTab('TBCC Wallet'),
        onHold: () => ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("TBCC Wallet"))),
      ),
      CollapsibleItem(
        text: 'Account Setting',
        icon: Icons.manage_accounts_rounded,
        onPressed: () => setTab('Edit Profile'),
        onHold: () => ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Account Setting"))),
      ),
      CollapsibleItem(
        text: 'Subscription',
        icon: Icons.subscriptions_outlined,
        onPressed: () => setTab('NAT Subscription'),
        onHold: () => ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Subscription"))),
      ),
    ];
  }*/

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, bound) {
      return _body(Size(bound.maxWidth, bound.maxHeight), context);
      // Widget sidebar = Padding(
      //   padding: EdgeInsets.all(10),
      //   child: GestureDetector(
      //     // onHorizontalDragUpdate: _onHorizontalDragUpdate,
      //     // onHorizontalDragEnd: _onHorizontalDragEnd,
      //     child: CollapsibleContainer(
      //       height: bound.maxHeight,
      //       width: 150,
      //       padding: 10,
      //       borderRadius: 10,
      //       color: Colors.white,
      //       sidebarBoxShadow: [],
      //       child: Column(
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         children: [
      //          Text('title'),
      //           SizedBox(
      //             height: 10,
      //           ),
      //           Expanded(
      //             child: SingleChildScrollView(
      //               physics: BouncingScrollPhysics(),
      //               reverse: false,
      //               child: Stack(
      //                 children: [
      //                   CollapsibleItemSelection(
      //                     height: 60,
      //                     offsetY: 60 * 3,
      //                     color: Colors.red,
      //                     duration: Duration(seconds: 2),
      //                     curve: Curves.easeIn,
      //                   ),
      //                   Column(
      //                     // children: _items,
      //                   ),
      //                 ],
      //               ),
      //             ),
      //           ),
      //           SizedBox(
      //             height: 10,
      //           ),
      //
      //         ],
      //       ),
      //     ),
      //   ),
      // );
      // return sidebar;
      /*     return CollapsibleSidebar(
        isCollapsed: bound.maxWidth <= 800,
        items: _items,
        collapseOnBodyTap: true,
        avatarImg: const NetworkImage(
            'https://www.nathorizon.com/public/user/images/author29.png'),
        title: sl<AuthProvider>().user?.status ?? '',
        onTitleTap: () {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Yay! Flutter Collapsible Sidebar!')));
        },
        body: _body(Size(bound.maxWidth, bound.maxHeight), context),
        backgroundColor: getTheme.colorScheme.onPrimary,
        // selectedTextColor: Colors.limeAccent,
        textStyle: const TextStyle(fontSize: 15),
        sidebarBoxShadow: const [
          BoxShadow(
            color: Colors.transparent,
            blurRadius: 0,
            spreadRadius: 0.01,
            offset: Offset(0, 0),
          ),
          BoxShadow(
            color: Colors.transparent,
            blurRadius: 0,
            spreadRadius: 0.01,
            offset: Offset(0, 0),
          ),
        ],
        toggleButtonIcon: Icons.chevron_right,
        selectedIconBox: const Color(0xff2F4047),
        selectedIconColor: Colors.white,
        selectedTextColor: const Color(0xffF3F7F7),
        unselectedIconColor: const Color(0xffc3d8ec),
        unselectedTextColor: const Color(0xffC0C7D0),
        duration: const Duration(milliseconds: 500),
        iconSize: 25,
      );*/
    });
  }

  Widget _body(Size size, BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: paddingDefault),
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            height30(),
            Row(
              children: [
                titleLargeText(widget.headline ?? '', context,
                    fontSize: 25, color: Colors.white),
              ],
            ),
            height10(),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: widget.title == 'Dashboard'
                    ? buildDashBoard(context)
                    : widget.title == 'Inventory'
                        ? buildInventory(context)
                        : widget.title == 'NAT Wallet'
                            ? buildInventory(context)
                            : widget.title == 'Staking Wallets'
                                ? buildInventory(context)
                                : widget.title == 'Commission Wallet'
                                    ? buildCommissionWallet(context)
                                    : widget.title == 'TBCC Wallet'
                                        ? buildTBCWallet(context)
                                        : widget.title == 'My Team'
                                            ? buildInventory(context)
                                            : widget.title == 'Account Setting'
                                                ? buildProfileEditPage(context)
                                                : widget.title == 'Subscription'
                                                    ? buildSubscriptionContent(
                                                        context)
                                                    : Card(
                                                        child: Container(
                                                            width: double
                                                                .maxFinite,
                                                            height: double
                                                                .maxFinite),
                                                      ),
              ),
            )
          ],
        ),
      ),
    );
  }

  buildCommissionWallet(BuildContext context) {
    return _CommissionHistoryList();
  }

  Widget buildSubscriptionContent(BuildContext context) {
    return const _SubscriptionContent();
  }

  Widget buildProfileEditPage(BuildContext context) {
    return const ProfileEditPage();
  }

  Widget buildInventory(BuildContext context) {
    return const _PlutoGridExamplePage();
  }

  Widget buildDashBoard(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: paddingDefault),
      children: [
        height20(),
        const CircleAvatar(
          radius: 45,
          backgroundImage: NetworkImage(
              'https://www.nathorizon.com/public/user/images/author29.png',
              scale: 1),
        ),
        height20(),
        titleLargeText('ChandanKu-Singh', context,
            fontWeight: FontWeight.bold,
            textAlign: TextAlign.center,
            color: getTheme.colorScheme.primary),
        height10(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.person),
            width10(),
            bodyLargeText('ChandanKu-Singh', context,
                fontWeight: FontWeight.bold),
          ],
        ),
        height30(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildCachedNetworkImage(
                'https://chart.googleapis.com/chart?chs=300x300&cht=qr&chl=https://www.nathorizon.com/register?refer=NATPRO',
                pw: getWidth > mobWidth ? 400 : 300,
                ph: getWidth > mobWidth ? 400 : 300,
                borderRadius: 10),
          ],
        ),
        height30(),
        FilledButton.icon(
          onPressed: () {
            AdvanceToasts.showNormalElegant(
                context, 'Wallet address copied successfully!',
                showProgressIndicator: true,
                notificationType: NotificationType.success,
                trailing: IconButton(
                    onPressed: () {
                      Share.share(
                          'https://www.nathorizon.com/nft/0xb1862a737d8ae63baba65abe34895904');
                    },
                    icon: const Icon(Icons.share)));
          },
          label: Row(
            children: [
              Expanded(
                child: bodyMedText(
                    '0xb1862a737d8ae63baba65abe348959040xb1862a737d8ae63baba65abe348959040xb1862a737d8ae63baba65abe34895904',
                    context,
                    maxLines: 1,
                    color: Colors.white),
              ),
            ],
          ),
          icon: const Icon(
            Icons.copy,
            size: 15,
            color: Colors.white,
          ),
        ),
        height10(),
        FilledButton.icon(
          onPressed: () {
            AdvanceToasts.showNormalElegant(
                context, 'Referral Link copied successfully!',
                showProgressIndicator: true,
                notificationType: NotificationType.success,
                trailing: IconButton(
                    onPressed: () {
                      Share.share(
                          'https://www.nathorizon.com/register?refer=NATPRO');
                    },
                    icon: const Icon(Icons.share)));
          },
          label: bodyMedText('Referral Link', context,
              maxLines: 1, color: Colors.white),
          icon: const Icon(
            Icons.copy,
            size: 15,
            color: Colors.white,
          ),
        ),
        height50(),
      ],
    );
  }

  buildTBCWallet(BuildContext context) {
    return _TBCWalletHistoryList();
  }
}

List<DashboardWalletActivity> generateRandomActivities(int count) {
  final List<DashboardWalletActivity> activities = [];

  final random = Random();

  for (int i = 0; i < count; i++) {
    final activity = DashboardWalletActivity(
      id: i.toString(),
      date: '2023-06-22', // Replace with random date logic
      payoutId: 'Payout-$i',
      customerId: 'Customer-$i',
      balance: (1000 + random.nextInt(5000)).toString(),
      debit: random.nextInt(2) == 0 ? (random.nextInt(500)).toString() : '0',
      credit: random.nextInt(2) == 0 ? (random.nextInt(500)).toString() : '0',
      note: 'You received level income from level #1 #NAT77736773 $i',
      createdBy: 'User-$i',
      createdAt: '2023-06-22T12:00:00', // Replace with random date logic
    );

    activities.add(activity);
  }

  return activities;
}

class _CommissionHistoryList extends StatefulWidget {
  _CommissionHistoryList({Key? key});

  @override
  State<_CommissionHistoryList> createState() => _CommissionHistoryListState();
}

class _CommissionHistoryListState extends State<_CommissionHistoryList> {
  int activityCount = 20;

  @override
  Widget build(BuildContext context) {
    var activities = generateRandomActivities(activityCount);
    return RefreshIndicator(
      onRefresh: _refresh,
      child: LoadMore(
        isFinish: activityCount >= 60,
        onLoadMore: _loadMore,
        whenEmptyLoad: true,
        delegate: const MyLoadMoreDelegate(),
        textBuilder: DefaultLoadMoreTextBuilder.english,
        child: ListView(
          children: [
            DefaultTextStyle(
              style: const TextStyle(color: Color(0xff9b9b9b), fontSize: 12.5),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: FixedTimeline.tileBuilder(
                  theme: TimelineThemeData(
                    nodePosition: 0,
                    color: const Color(0xff989898),
                    indicatorTheme:
                        const IndicatorThemeData(position: 0, size: 20.0),
                    connectorTheme: const ConnectorThemeData(thickness: 2.5),
                  ),
                  builder: TimelineTileBuilder.connected(
                    connectionDirection: ConnectionDirection.before,
                    itemCount: activities.length,
                    contentsBuilder: (_, index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  bodyLargeText(
                                      DateFormat('MMM dd yyyy').format(
                                          DateTime.parse(
                                              activities[index].createdAt ??
                                                  '')),
                                      context,
                                      fontWeight: FontWeight.bold,
                                      textAlign: TextAlign.center),
                                  height5(),
                                  capText(
                                      parseHtmlString(
                                          activities[index].note ?? ''),
                                      context),
                                  if (index < activities.length - 1) height50(),
                                ],
                              ),
                            ),
                            Builder(builder: (context) {
                              bool credited = double.parse(
                                      activities[index].credit ?? '0') >
                                  double.parse(activities[index].debit ?? '0');
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  /*Container(
                                    decoration: BoxDecoration(
                                      color: credited
                                          ? Colors.green[500]
                                          : Colors.red[500]!,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 3),
                                    child: bodyMedText(
                                      credited ? 'Credit' : 'Debit',
                                      context,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ),
                                  height10(),*/
                                  capText(
                                      DateFormat().add_jm().format(
                                          DateTime.parse(
                                              activities[index].createdAt ??
                                                  '')),
                                      context,
                                      fontSize: 10),
                                ],
                              );
                            }),
                          ],
                        ),
                      );
                    },
                    indicatorBuilder: (_, index) {
                      bool credited =
                          double.parse(activities[index].credit ?? '0') >
                              double.parse(activities[index].debit ?? '0');
                      if (credited) {
                        return const OutlinedDotIndicator(
                          color: Color(0xff66c97f),
                          // child: Icon(Icons.check, color: Colors.white, size: 12.0),
                        );
                      } else {
                        return const OutlinedDotIndicator(color: Colors.red
                            // child: Icon(Icons.check, color: Colors.white, size: 12.0),
                            );
                      }
                    },
                    connectorBuilder: (_, index, ___) {
                      bool credited =
                          double.parse(activities[index].credit ?? '0') >
                              double.parse(activities[index].debit ?? '0');
                      return  SolidLineConnector(
                        // color: Colors.white,
                        thickness: 1,
                        color: credited
                            ? const Color(0xff66c97f)
                            : const Color(0xff6676c9),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> _loadMore() async {
    print("onLoadMore");
    await Future.delayed(const Duration(seconds: 0, milliseconds: 1000));
    setState(() {
      activityCount += 25;
    });
    return true;
  }

  Future<void> _refresh() async {
    await Future.delayed(const Duration(seconds: 0, milliseconds: 2000));
    setState(() {
      activityCount = 20;
    });
  }
}

class _TBCWalletHistoryList extends StatefulWidget {
  _TBCWalletHistoryList({Key? key}) : super(key: key);

  @override
  State<_TBCWalletHistoryList> createState() => _TBCWalletHistoryListState();
}

class _TBCWalletHistoryListState extends State<_TBCWalletHistoryList> {
  int activityCount = 20;
  @override
  Widget build(BuildContext context) {
    var activities = generateRandomActivities(activityCount);
    return RefreshIndicator(
      onRefresh: _refresh,
      child: LoadMore(
        isFinish: activityCount >= 60,
        onLoadMore: _loadMore,
        whenEmptyLoad: true,
        delegate: const MyLoadMoreDelegate(),
        textBuilder: DefaultLoadMoreTextBuilder.english,
        child: ListView(
          children: [
            DefaultTextStyle(
              style: const TextStyle(color: Color(0xff9b9b9b), fontSize: 12.5),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: FixedTimeline.tileBuilder(
                  theme: TimelineThemeData(
                    nodePosition: 0,
                    color: const Color(0xff989898),
                    indicatorTheme:
                        const IndicatorThemeData(position: 0, size: 20.0),
                    connectorTheme: const ConnectorThemeData(thickness: 2.5),
                  ),
                  builder: TimelineTileBuilder.connected(
                    connectionDirection: ConnectionDirection.before,
                    itemCount: activities.length,
                    contentsBuilder: (_, index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  bodyLargeText(
                                      DateFormat('MMM dd yyyy').format(
                                          DateTime.parse(
                                              activities[index].createdAt ??
                                                  '')),
                                      context,
                                      fontWeight: FontWeight.bold,
                                      textAlign: TextAlign.center),
                                  height5(),
                                  capText(
                                      parseHtmlString(
                                          activities[index].note ?? ''),
                                      context),
                                  if (index < activities.length - 1) height50(),
                                ],
                              ),
                            ),
                            Builder(builder: (context) {
                              bool credited = double.parse(
                                      activities[index].credit ?? '0') >
                                  double.parse(activities[index].debit ?? '0');
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  /*Container(
                                    decoration: BoxDecoration(
                                      color: credited
                                          ? Colors.green[500]
                                          : Colors.red[500]!,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 3),
                                    child: bodyMedText(
                                      credited ? 'Credit' : 'Debit',
                                      context,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ),
                                  height10(),*/
                                  capText(
                                      DateFormat().add_jm().format(
                                          DateTime.parse(
                                              activities[index].createdAt ??
                                                  '')),
                                      context,
                                      fontSize: 10),
                                ],
                              );
                            }),
                          ],
                        ),
                      );
                    },
                    indicatorBuilder: (_, index) {
                      bool credited =
                          double.parse(activities[index].credit ?? '0') >
                              double.parse(activities[index].debit ?? '0');
                      if (credited) {
                        return const OutlinedDotIndicator(
                          color: Color(0xff66c97f),
                          // child: Icon(Icons.check, color: Colors.white, size: 12.0),
                        );
                      } else {
                        return const OutlinedDotIndicator(
                          color: Colors.red,
                          // child: Icon(Icons.check, color: Colors.white, size: 12.0),
                        );
                      }
                    },
                    connectorBuilder: (_, index, ___) {
                      bool credited =
                          double.parse(activities[index].credit ?? '0') >
                              double.parse(activities[index].debit ?? '0');
                      return const SolidLineConnector(
                        color: Colors.white,
                        thickness: 1,
                        // color: credited
                        //     ? const Color(0xff66c97f)
                        //     : const Color(0xff6676c9),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> _loadMore() async {
    print("onLoadMore");
    await Future.delayed(const Duration(seconds: 0, milliseconds: 1000));
    setState(() {
      activityCount += 25;
    });
    return true;
  }

  Future<void> _refresh() async {
    await Future.delayed(const Duration(seconds: 0, milliseconds: 2000));
    setState(() {
      activityCount = 20;
    });
  }
}

class MyLoadMoreDelegate extends LoadMoreDelegate {
  const MyLoadMoreDelegate();

  @override
  Widget buildChild(LoadMoreStatus status,
      {LoadMoreTextBuilder builder = DefaultLoadMoreTextBuilder.english}) {
    String text = builder(status);
    if (status == LoadMoreStatus.fail) {
      return Text(text.capitalize!);
    } else if (status == LoadMoreStatus.idle) {
      return Text('');
    } else if (status == LoadMoreStatus.loading) {
      return Container(
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              width: 25,
              height: 25,
              child: CircularProgressIndicator(
                  backgroundColor: Colors.blue, strokeWidth: 1.5),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(text.capitalize!),
            ),
          ],
        ),
      );
    } else if (status == LoadMoreStatus.nomore) {
      return Text(text.capitalize!);
    } else {
      return Text(text.capitalize!);
    }
  }
}

class DashboardWalletActivity {
  String? id;
  String? date;
  String? payoutId;
  String? customerId;
  String? balance;
  String? debit;
  String? credit;
  String? note;
  String? createdBy;
  String? createdAt;

  DashboardWalletActivity(
      {this.id,
      this.date,
      this.payoutId,
      this.customerId,
      this.balance,
      this.debit,
      this.credit,
      this.note,
      this.createdBy,
      this.createdAt});

  DashboardWalletActivity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    payoutId = json['payout_id'];
    customerId = json['customer_id'];
    balance = json['balance'];
    debit = json['debit'];
    credit = json['credit'];
    note = json['note'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['date'] = date;
    data['payout_id'] = payoutId;
    data['customer_id'] = customerId;
    data['balance'] = balance;
    data['debit'] = debit;
    data['credit'] = credit;
    data['note'] = note;
    data['created_by'] = createdBy;
    data['created_at'] = createdAt;
    return data;
  }
}

//Subscription Content
class _SubscriptionContent extends StatelessWidget {
  const _SubscriptionContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        height100(),
        Card(
          elevation: 5,
          margin: EdgeInsets.only(bottom: spaceDefault),
          // color: Colors.transparent,
          // shadowColor: Colors.transparent,
          child: Padding(
            padding: EdgeInsets.all(spaceDefault),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                bodyMedText("You've Remaining", context),
                Row(
                  children: [
                    Text(
                      '29',
                      style: TextStyle(
                          fontSize: 28.0,
                          fontWeight: FontWeight.bold,
                          color: getTheme.colorScheme.primary),
                    ),
                    const Text(
                      ' Days of your NAT Plan',
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ],
                ),
                height20(),
                Row(
                  children: [
                    Expanded(
                      child: ProgressBar(
                        value: 0.5,
                        height: 15,
                        gradient: const LinearGradient(colors: [
                          Color.fromRGBO(255, 163, 153, 1),
                          Color.fromRGBO(255, 77, 151, 1),
                        ]),
                        backgroundColor: Colors.grey.withOpacity(0.4),
                      ),
                    ),
                  ],
                ),
                height20(),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('1 Days'),
                    Text('30 Days'),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

//Profile Update Page
class ProfileEditPage extends StatefulWidget {
  const ProfileEditPage({super.key});

  @override
  _ProfileEditPageState createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController tronAddressController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(paddingDefault),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          height20(),
          const CircleAvatar(
            radius: 35,
            backgroundImage: NetworkImage(
                'https://www.nathorizon.com/public/user/images/author29.png'),
          ),
          height10(15),
          capText('codingmobile2023@gmail.com', context,
              fontWeight: FontWeight.bold),
          height10(15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              bodyMedText('Contact Details', context,
                  fontWeight: FontWeight.bold),
              height10(),
              TextFormField(
                controller: fullNameController,
                decoration: const InputDecoration(
                  isDense: true,
                  labelStyle: TextStyle(fontSize: 14),
                  labelText: 'Full Name',
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              height10(),
              TextFormField(
                controller: phoneController,
                decoration: const InputDecoration(
                  isDense: true,
                  labelStyle: TextStyle(fontSize: 14),
                  labelText: 'Phone',
                  prefixIcon: Icon(Icons.phone),
                ),
              ),
              height10(),
              TextFormField(
                controller: tronAddressController,
                decoration: const InputDecoration(
                  isDense: true,
                  labelStyle: TextStyle(fontSize: 14),
                  labelText: 'Tron Address',
                  prefixIcon: Icon(Icons.account_balance_wallet),
                ),
              ),
            ],
          ),
          height10(15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              bodyMedText('Address', context, fontWeight: FontWeight.bold),
              height10(),
              TextFormField(
                controller: addressController,
                maxLines: 3,
                decoration: const InputDecoration(
                  isDense: true,
                  labelStyle: TextStyle(fontSize: 14),
                  hintStyle: TextStyle(fontSize: 14),
                  hintText: 'Full Address',
                ),
              ),
            ],
          ),
          height10(15),
          Row(
            children: [
              FilledButton(
                onPressed: () {
                  // TODO: Implement updating settings
                },
                child: bodyMedText('Update Settings', context,
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          height50(),
        ],
      ),
    );
  }
}

//PlutoGridExamplePage
class _PlutoGridExamplePage extends StatefulWidget {
  const _PlutoGridExamplePage({Key? key}) : super(key: key);

  @override
  State<_PlutoGridExamplePage> createState() => _PlutoGridExamplePageState();
}

PlutoRow createRow(String nft, String name, String staking_time, String price,
        String hash_power, String status) =>
    PlutoRow(
      cells: {
        'nft': PlutoCell(value: nft),
        'name': PlutoCell(value: name),
        'staking_time': PlutoCell(value: staking_time),
        'price': PlutoCell(value: int.parse(price)),
        'hash_power': PlutoCell(value: hash_power),
        'status': PlutoCell(value: status),
      },
    );

class _PlutoGridExamplePageState extends State<_PlutoGridExamplePage> {
  final List<PlutoColumn> columns = <PlutoColumn>[
    PlutoColumn(title: 'NFT', field: 'nft', type: PlutoColumnType.text()),
    PlutoColumn(title: 'Name', field: 'name', type: PlutoColumnType.text()),
    PlutoColumn(
        title: 'Staking Time',
        field: 'staking_time',
        type: PlutoColumnType.date()),
    PlutoColumn(title: 'Price', field: 'price', type: PlutoColumnType.number()),
    PlutoColumn(
        title: 'Hash Power', field: 'hash_power', type: PlutoColumnType.text()),
    PlutoColumn(title: 'Status', field: 'status', type: PlutoColumnType.text()),
  ];

  final List<PlutoRow> rows = [
    createRow('user1', 'Mike', '2021-01-10', '200', '0.0005', 'Active'),
    createRow('user2', 'Rohit', '2021-01-14', '2230', '0.00035', 'Suspended'),
    createRow(
      'user3',
      'Abhishek',
      '2021-01-12',
      '2100',
      '0.00205',
      'De-active',
    ),
    createRow('user4', 'Sandeep', '2021-01-18', '2030', '0.00505', 'Active'),
  ];

  /// columnGroups that can group columns can be omitted.
  final List<PlutoColumnGroup> columnGroups = [
    PlutoColumnGroup(title: 'NFT', fields: ['nft']),
    PlutoColumnGroup(title: 'Name', fields: ['name']),
    PlutoColumnGroup(title: 'Staking Time', fields: ['staking_time']),
    PlutoColumnGroup(title: 'Price', fields: ['price']),
    PlutoColumnGroup(title: 'Hash Power', fields: ['hash_power']),
    PlutoColumnGroup(title: 'Status', fields: ['status']),
    PlutoColumnGroup(title: 'Action', fields: ['action']),
  ];

  /// [PlutoGridStateManager] has many methods and properties to dynamically manipulate the grid.
  /// You can manipulate the grid dynamically at runtime by passing this through the [onLoaded] callback.
  late final PlutoGridStateManager stateManager;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: PlutoGrid(
        columns: columns,
        rows: rows,
        // columnGroups: columnGroups,
        onLoaded: (PlutoGridOnLoadedEvent event) {
          stateManager = event.stateManager;

          stateManager.setShowColumnFilter(false);
          // print(stateManager.columns);
          stateManager.columns.forEach((e) {
            print(e.title);
            stateManager.autoFitColumn(context, e);
          });
        },
        onChanged: (PlutoGridOnChangedEvent event) {
          print(event);
        },
        configuration: const PlutoGridConfiguration(),
        mode: PlutoGridMode.select,
      ),
    );
  }
}
