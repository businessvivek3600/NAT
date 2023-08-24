import 'dart:math';

import 'package:collapsible_sidebar/collapsible_sidebar.dart';
import 'package:collapsible_sidebar/collapsible_sidebar/collapsible_container.dart';
import 'package:collapsible_sidebar/collapsible_sidebar/collapsible_item_selection.dart';
import 'package:collapsible_sidebar/collapsible_sidebar/collapsible_item_widget.dart';
import 'package:elegant_notification/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:loadmore/loadmore.dart';
import 'package:my_global_tools/route_management/route_name.dart';
import 'package:my_global_tools/utils/color.dart';
import '../../../utils/default_logger.dart';
import '../../../widgets/buttonStyle.dart';
import '../../../widgets/custom_bottom_sheet_dialog.dart';
import '/constants/asset_constants.dart';
import '/utils/date_utils.dart';
import '../../../functions/functions.dart';
import '../../../widgets/my_load_more_delegate.dart';
import '../../../widgets/time_line/src/connector_theme.dart';
import '../../../widgets/time_line/src/connectors.dart';
import '../../../widgets/time_line/src/indicator_theme.dart';
import '../../../widgets/time_line/src/indicators.dart';
import '../../../widgets/time_line/src/timeline_theme.dart';
import '../../../widgets/time_line/src/timeline_tile_builder.dart';
import '../../../widgets/time_line/src/timelines.dart';
import '/utils/my_advanved_toasts.dart';
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
              height: getHeight * 0.3,
              width: double.maxFinite,
              child: buildCachedNetworkImage(
                  'https://www.nathorizon.com/public/user/images/thumb-pagetitle.png',
                  fit: BoxFit.cover),
            ),
            Container(
              height: getHeight * 0.3,
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
      {required this.tabIndex, this.title, this.headline});
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
                            ? buildNatWallet(context)
                            : widget.title == 'Staking Wallets'
                                ? buildStackingWallet(context)
                                : widget.title == 'Commission Wallet'
                                    ? buildCommissionWallet(context)
                                    : widget.title == 'TBCC Wallet'
                                        ? buildTBCWallet(context)
                                        : widget.title == 'My Team'
                                            ? buildMyTeamViewWidget(context)
                                            : widget.title == 'Account Setting'
                                                ? buildProfileEditPage(context)
                                                : widget.title == 'Subscription'
                                                    ? buildSubscriptionContent(
                                                        context)
                                                    : const Card(
                                                        child: SizedBox(
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

  buildMyTeamViewWidget(BuildContext context) {
    return _MyTeamViewWidget();
  }

  buildNatWallet(BuildContext context) {
    return const NATWalletList();
  }

  buildStackingWallet(BuildContext context) {
    return const _StackingWalletList();
  }

  buildCommissionWallet(BuildContext context) {
    return const _CommissionHistoryList();
  }

  Widget buildSubscriptionContent(BuildContext context) {
    return const _SubscriptionContent();
  }

  Widget buildProfileEditPage(BuildContext context) {
    return const ProfileEditPage();
  }

  Widget buildInventory(BuildContext context) {
    return _NFTListWidget();
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
    return const _TBCWalletHistoryList();
  }
}

//_MyTeamViewWidget
class UserData {
  final int srNo;
  final String username;
  final String name;
  final String referBy;
  final String joiningDate;
  final String activeDate;
  final String status;

  UserData({
    required this.srNo,
    required this.username,
    required this.name,
    required this.referBy,
    required this.joiningDate,
    required this.activeDate,
    required this.status,
  });
}

class _MyTeamViewWidget extends StatefulWidget {
  @override
  State<_MyTeamViewWidget> createState() => _MyTeamViewWidgetState();
}

class _MyTeamViewWidgetState extends State<_MyTeamViewWidget> {
  int usersCount = 5;

  List<UserData> generateRandomUsers(int count) => List.generate(
      count,
      (index) => UserData(
            srNo: index,
            username: 'NAT53450251',
            name: '#$index Ehouman Adou',
            referBy: 'NAT50933937',
            joiningDate: DateTime.now()
                .subtract(Duration(days: index))
                .toIso8601String(),
            activeDate: DateTime.now()
                .subtract(Duration(days: index - 1))
                .toIso8601String(),
            status: index % 5 == 0 ? 'Inactive' : 'Active',
          ));
  @override
  Widget build(BuildContext context) {
    List<UserData> userData = generateRandomUsers(usersCount);
    return RefreshIndicator(
      onRefresh: _refresh,
      child: LoadMore(
        isFinish: usersCount >= 20,
        onLoadMore: _loadMore,
        whenEmptyLoad: true,
        delegate: const MyLoadMoreDelegate(),
        textBuilder: DefaultLoadMoreTextBuilder.english,
        child: ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: paddingDefault),
          itemCount: userData.length,
          itemBuilder: (context, index) {
            return _UserCard(userData: userData[index]);
          },
        ),
      ),
    );
  }

  Future<bool> _loadMore() async {
    await Future.delayed(const Duration(seconds: 0, milliseconds: 10000));
    if (mounted) {
      setState(() {
        usersCount += 5;
      });
    }
    return true;
  }

  Future<void> _refresh() async {
    await Future.delayed(const Duration(seconds: 0, milliseconds: 2000));
    setState(() {
      usersCount = 5;
    });
  }
}

class _UserCard extends StatelessWidget {
  final UserData userData;

  const _UserCard({required this.userData});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: paddingDefault),
      // elevation: 7,
      // color: Colors.white,
      // shadowColor: Colors.transparent,

      decoration: BoxDecoration(
          color: getTheme.colorScheme.secondary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [BoxShadow(color: getTheme.colorScheme.background)]),
      child: Padding(
        padding: EdgeInsets.all(paddingDefault),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(child: bodyLargeText(userData.name, context)),
                width5(),
                Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: paddingDefault / 2),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: userData.status.toLowerCase() == 'active'
                            ? Colors.green
                            : Colors.red),
                    child: capText(userData.username, context,
                        color: Colors.white)),
              ],
            ),
            height5(),
            Row(
              children: [
                const Icon(Icons.published_with_changes, size: 15),
                width5(),
                Expanded(child: bodyMedText(userData.referBy, context)),
              ],
            ),
            height5(),
            Row(
              children: [
                assetImages(PNGAssets.timeSpan, width: 15),
                width5(),
                Expanded(
                    child: bodyMedText(
                        MyDateUtils.formatDateTime(
                            DateTime.parse(userData.joiningDate),
                            'dd MMM yyyy'),
                        context)),
              ],
            ),
            height5(),
            Row(
              children: [
                assetImages(PNGAssets.joinPerson, width: 15),
                width5(),
                Expanded(
                    child: bodyMedText(
                        MyDateUtils.formatDateTime(
                            DateTime.parse(userData.activeDate), 'dd MMM yyyy'),
                        context)),
              ],
            ),
          ],
        ),
      ),
    );
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

//_NATWalletHistoryList
class NATWalletList extends StatefulWidget {
  const NATWalletList({super.key});

  @override
  State<NATWalletList> createState() => NATWalletListState();
}

class NATWalletListState extends State<NATWalletList>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        DefaultTabController(
          length: 2,
          child: Stack(
            children: [
              const SizedBox(height: double.maxFinite, width: double.maxFinite),
              TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: _tabController,
                  children: [
                    buildStackTotal(context, type: 0),
                    buildStackHistory(context, type: 1),
                  ]),
              buildTabBar(),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              height: 25,
              child: FilledButton(
                  style: FilledButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: paddingDefault)),
                  onPressed: () => showTransferBottomSheet(context),
                  child: capText('Transfer', context, color: Colors.white)),
            ),
            width5(),
            SizedBox(
              height: 25,
              child: FilledButton(
                  style: FilledButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: paddingDefault)),
                  onPressed: () => showStackBottomSheet(context),
                  child: capText('Stack NAT', context, color: Colors.white)),
            ),
            width5(),
            SizedBox(
              height: 25,
              child: FilledButton(
                  style: FilledButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: paddingDefault)),
                  onPressed: () => showBuyBottomSheet(context),
                  child: capText('But NAT', context, color: Colors.white)),
            ),
          ],
        )
      ],
    );
  }

  void showTransferBottomSheet(BuildContext context) {
    CustomBottomSheet.show(
      context: context,
      curve: Curves.bounceIn,
      duration: 200,
      dismissible: false,
      enableDrag: false,
      isScrollControlled: true,
      mainAxisAlignment: MainAxisAlignment.center,
      onDismiss: () async {
        return true;
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
        return const _TransferNATBottomSheetWidget();
      },
    );
  }

  void showStackBottomSheet(BuildContext context) {
    CustomBottomSheet.show(
      context: context,
      curve: Curves.bounceIn,
      duration: 200,
      dismissible: false,
      enableDrag: false,
      isScrollControlled: true,
      mainAxisAlignment: MainAxisAlignment.center,
      onDismiss: () async {
        return true;
      },
      builder: (context) {
        return const _StackNATBottomSheetWidget();
      },
    );
  }

  void showBuyBottomSheet(BuildContext context) {
    CustomBottomSheet.show(
      context: context,
      curve: Curves.bounceIn,
      duration: 200,
      dismissible: false,
      enableDrag: false,
      isScrollControlled: true,
      mainAxisAlignment: MainAxisAlignment.center,
      onDismiss: () async {
        return true;
      },
      builder: (context) {
        return const _BuyNATBottomSheetWidget();
      },
    );
  }

  Positioned buildTabBar() {
    return Positioned(
        bottom: 30,
        right: 0,
        left: 0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: 40,
              width: 200,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: getTheme.colorScheme.onSecondary),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: TabBar(
                  splashBorderRadius: BorderRadius.circular(50),
                  controller: _tabController,
                  indicator: BoxDecoration(
                      color: getTheme.colorScheme.primary,
                      borderRadius: BorderRadius.circular(50)),
                  labelColor: Colors.white,
                  unselectedLabelColor: getTheme.textTheme.bodySmall?.color,
                  labelStyle: GoogleFonts.ubuntu(
                      fontSize: 18, fontWeight: FontWeight.w500),
                  indicatorSize: TabBarIndicatorSize.tab,
                  /* onTap: (val) => setState(() {
                        primaryFocus?.unfocus();
                      }),*/
                  tabs: const [
                    Tab(text: 'Total'),
                    Tab(text: 'History'),
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  Widget buildStackHistory(BuildContext context, {required int type}) {
    return const _StackHistoryWidget();
  }

  Widget buildStackTotal(BuildContext context, {required int type}) {
    return const _StackTotalWidget();
  }
}

// ---> NAT Wallet BottomSheets
class _TransferNATBottomSheetWidget extends StatefulWidget {
  const _TransferNATBottomSheetWidget({super.key});

  @override
  State<_TransferNATBottomSheetWidget> createState() =>
      _TransferNATBottomSheetWidgetState();
}

class _TransferNATBottomSheetWidgetState
    extends State<_TransferNATBottomSheetWidget> {
  TextEditingController username = TextEditingController();
  TextEditingController amount = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            bodyLargeText('Transfer NAT', context),
            Container(
                padding: EdgeInsets.symmetric(
                    horizontal: paddingDefault / 2, vertical: 2),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.greenAccent.withOpacity(0.3)),
                child: capText(
                  '4.3468 NAT (43.468 \$)',
                  context,
                )),
          ],
        ),
        const SizedBox(height: 20),
        Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: username,
                decoration: const InputDecoration(
                  isDense: true,
                  labelStyle: TextStyle(fontSize: 14),
                  labelText: 'Enter Username',
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              height10(),
              TextFormField(
                controller: amount,
                decoration: const InputDecoration(
                  isDense: true,
                  labelStyle: TextStyle(fontSize: 14),
                  labelText: 'Enter Amount',
                  prefixIcon: Icon(Icons.phone),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: FilledButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Transfer')),
            ),
          ],
        ),
      ],
    );
  }
}

class _StackNATBottomSheetWidget extends StatefulWidget {
  const _StackNATBottomSheetWidget({super.key});

  @override
  State<_StackNATBottomSheetWidget> createState() =>
      _StackNATBottomSheetWidgetState();
}

class _StackNATBottomSheetWidgetState
    extends State<_StackNATBottomSheetWidget> {
  TextEditingController periodController = TextEditingController();
  TextEditingController amount = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child:
                    bodyLargeText('Select Stake Time', context, lineHeight: 1)),
            Container(
                padding: EdgeInsets.symmetric(
                    horizontal: paddingDefault / 2, vertical: 2),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.greenAccent.withOpacity(0.3)),
                child: capText(
                  '4.3468 NAT (43.468 \$)',
                  context,
                )),
          ],
        ),
        const SizedBox(height: 20),
        Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: amount,
                decoration: const InputDecoration(
                  isDense: true,
                  labelStyle: TextStyle(fontSize: 14),
                  labelText: 'Enter Amount',
                  prefixIcon: Icon(Icons.money),
                ),
              ),
              height10(),
              PopupMenuButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                position: PopupMenuPosition.under,
                offset: const Offset(0, 0),
                itemBuilder: (BuildContext context) => [
                  '3 months (5%)',
                  '6 months (12%)',
                  '12 months (30%)',
                  '18 months (70%)',
                  '24 months (150%)',
                ]
                    .map((e) => PopupMenuItem(
                          value: e,
                          child: capText(e, context),
                        ))
                    .toList(),
                onSelected: (val) => setState(() {
                  periodController.text = val ?? '';
                }),
                child: AbsorbPointer(
                  child: TextFormField(
                    controller: periodController,
                    readOnly: true,
                    enabled: true,
                    decoration: const InputDecoration(
                      isDense: true,
                      labelStyle: TextStyle(fontSize: 14),
                      labelText: 'Select Period',
                      prefixIcon: Icon(Icons.access_time),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: FilledButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Stack NAT')),
            ),
          ],
        ),
      ],
    );
  }
}

class _BuyNATBottomSheetWidget extends StatefulWidget {
  const _BuyNATBottomSheetWidget({super.key});

  @override
  State<_BuyNATBottomSheetWidget> createState() =>
      _BuyNATBottomSheetWidgetState();
}

class _BuyNATBottomSheetWidgetState extends State<_BuyNATBottomSheetWidget> {
  TextEditingController amount = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            bodyLargeText('Buy NAT', context),
            Container(
                padding: EdgeInsets.symmetric(
                    horizontal: paddingDefault / 2, vertical: 2),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.greenAccent.withOpacity(0.3)),
                child: capText(
                  '4.3468 NAT (43.468 \$)',
                  context,
                )),
          ],
        ),
        const SizedBox(height: 20),
        Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: amount,
                decoration: const InputDecoration(
                  isDense: true,
                  labelStyle: TextStyle(fontSize: 14),
                  labelText: 'Enter Amount',
                  prefixIcon: Icon(Icons.money),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        capText('You will get 50% bonus.', context),
        const SizedBox(height: 5),
        Row(
          children: [
            Expanded(
              child: FilledButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Buy Nat')),
            ),
          ],
        ),
      ],
    );
  }
}

class _NatHistoryWidget extends StatefulWidget {
  const _NatHistoryWidget();

  @override
  State<_NatHistoryWidget> createState() => _NatHistoryWidgetState();
}

class _NatHistoryWidgetState extends State<_NatHistoryWidget> {
  int totalCount = 7;
  @override
  Widget build(BuildContext context) {
    var activities = generateRandomActivities(totalCount);
    return RefreshIndicator(
      onRefresh: () => _refresh(),
      child: LoadMore(
        isFinish: totalCount >= 35,
        onLoadMore: () => _loadMore(),
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
                      return SolidLineConnector(
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
    await Future.delayed(const Duration(seconds: 0, milliseconds: 1000));
    setState(() {
      totalCount += 7;
    });
    return true;
  }

  Future<void> _refresh() async {
    await Future.delayed(const Duration(seconds: 0, milliseconds: 2000));
    totalCount = 7;
  }
}

class _NatTotalWidget extends StatefulWidget {
  const _NatTotalWidget();

  @override
  State<_NatTotalWidget> createState() => _NatTotalWidgetState();
}

class _NatTotalWidgetState extends State<_NatTotalWidget> {
  int totalCount = 7;
  @override
  Widget build(BuildContext context) {
    var activities = generateRandomActivities(totalCount);
    return RefreshIndicator(
      onRefresh: () => _refresh(),
      child: LoadMore(
        isFinish: totalCount >= 35,
        onLoadMore: () => _loadMore(),
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
                      return SolidLineConnector(
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
    await Future.delayed(const Duration(seconds: 0, milliseconds: 1000));
    setState(() {
      totalCount += 7;
    });
    return true;
  }

  Future<void> _refresh() async {
    await Future.delayed(const Duration(seconds: 0, milliseconds: 2000));
    totalCount = 7;
  }
}

//_StackingWalletHistoryList
class _StackingWalletList extends StatefulWidget {
  const _StackingWalletList();

  @override
  State<_StackingWalletList> createState() => _StackingWalletListState();
}

class _StackingWalletListState extends State<_StackingWalletList>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Stack(
        children: [
          const SizedBox(height: double.maxFinite, width: double.maxFinite),
          TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _tabController,
              children: [
                buildStackTotal(context, type: 0),
                buildStackHistory(context, type: 1),
              ]),
          buildTabBar(),
        ],
      ),
    );
  }

  Positioned buildTabBar() {
    return Positioned(
        bottom: 30,
        right: 0,
        left: 0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: 40,
              width: 200,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: getTheme.colorScheme.onSecondary),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: TabBar(
                  splashBorderRadius: BorderRadius.circular(50),
                  controller: _tabController,
                  indicator: BoxDecoration(
                      color: getTheme.colorScheme.primary,
                      borderRadius: BorderRadius.circular(50)),
                  labelColor: Colors.white,
                  unselectedLabelColor: getTheme.textTheme.bodySmall?.color,
                  labelStyle: GoogleFonts.ubuntu(
                      fontSize: 18, fontWeight: FontWeight.w500),
                  indicatorSize: TabBarIndicatorSize.tab,
                  /* onTap: (val) => setState(() {
                        primaryFocus?.unfocus();
                      }),*/
                  tabs: const [
                    Tab(text: 'Total'),
                    Tab(text: 'History'),
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  Widget buildStackHistory(BuildContext context, {required int type}) {
    return const _StackHistoryWidget();
  }

  Widget buildStackTotal(BuildContext context, {required int type}) {
    return const _StackTotalWidget();
  }
}

class _StackHistoryWidget extends StatefulWidget {
  const _StackHistoryWidget();

  @override
  State<_StackHistoryWidget> createState() => _StackHistoryWidgetState();
}

class _StackHistoryWidgetState extends State<_StackHistoryWidget> {
  int totalCount = 7;
  @override
  Widget build(BuildContext context) {
    var activities = generateRandomActivities(totalCount);
    return RefreshIndicator(
      onRefresh: () => _refresh(),
      child: LoadMore(
        isFinish: totalCount >= 35,
        onLoadMore: () => _loadMore(),
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
                      return SolidLineConnector(
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
    await Future.delayed(const Duration(seconds: 0, milliseconds: 1000));
    setState(() {
      totalCount += 7;
    });
    return true;
  }

  Future<void> _refresh() async {
    await Future.delayed(const Duration(seconds: 0, milliseconds: 2000));
    totalCount = 7;
  }
}

class _StackTotalWidget extends StatefulWidget {
  const _StackTotalWidget();

  @override
  State<_StackTotalWidget> createState() => _StackTotalWidgetState();
}

class _StackTotalWidgetState extends State<_StackTotalWidget> {
  int totalCount = 7;
  @override
  Widget build(BuildContext context) {
    var activities = generateRandomActivities(totalCount);
    return RefreshIndicator(
      onRefresh: () => _refresh(),
      child: LoadMore(
        isFinish: totalCount >= 35,
        onLoadMore: () => _loadMore(),
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
                      return SolidLineConnector(
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
    await Future.delayed(const Duration(seconds: 0, milliseconds: 1000));
    setState(() {
      totalCount += 7;
    });
    return true;
  }

  Future<void> _refresh() async {
    await Future.delayed(const Duration(seconds: 0, milliseconds: 2000));
    totalCount = 7;
  }
}

//_CommissionHistoryList
class _CommissionHistoryList extends StatefulWidget {
  const _CommissionHistoryList();

  @override
  State<_CommissionHistoryList> createState() => _CommissionHistoryListState();
}

class _CommissionHistoryListState extends State<_CommissionHistoryList> {
  int activityCount = 20;

  @override
  Widget build(BuildContext context) {
    var activities = generateRandomActivities(activityCount);
    return Stack(
      children: [
        RefreshIndicator(
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
                  style:
                      const TextStyle(color: Color(0xff9b9b9b), fontSize: 12.5),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: FixedTimeline.tileBuilder(
                      theme: TimelineThemeData(
                        nodePosition: 0,
                        color: const Color(0xff989898),
                        indicatorTheme:
                            const IndicatorThemeData(position: 0, size: 20.0),
                        connectorTheme:
                            const ConnectorThemeData(thickness: 2.5),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                      if (index < activities.length - 1)
                                        height50(),
                                    ],
                                  ),
                                ),
                                Builder(builder: (context) {
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
                          return SolidLineConnector(
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
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              height: 25,
              child: FilledButton(
                  style: FilledButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: paddingDefault)),
                  onPressed: () => showWithDrawCommissionBottomSheet(context),
                  child: capText('Withdraw', context, color: Colors.white)),
            ),
          ],
        )
      ],
    );
  }

  void showWithDrawCommissionBottomSheet(BuildContext context) {
    CustomBottomSheet.show(
      context: context,
      curve: Curves.bounceIn,
      duration: 200,
      dismissible: false,
      enableDrag: false,
      isScrollControlled: true,
      mainAxisAlignment: MainAxisAlignment.center,
      onDismiss: () async {
        return true;
      },
      builder: (context) {
        return const _WithDrawCommissionBottomSheetWidget();
      },
    );
  }

  Future<bool> _loadMore() async {
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

class _WithDrawCommissionBottomSheetWidget extends StatefulWidget {
  const _WithDrawCommissionBottomSheetWidget({super.key});

  @override
  State<_WithDrawCommissionBottomSheetWidget> createState() =>
      _WithDrawCommissionBottomSheetWidgetState();
}

class _WithDrawCommissionBottomSheetWidgetState
    extends State<_WithDrawCommissionBottomSheetWidget> {
  TextEditingController amount = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            bodyLargeText('Buy NAT', context),
            Container(
                padding: EdgeInsets.symmetric(
                    horizontal: paddingDefault / 2, vertical: 2),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.greenAccent.withOpacity(0.3)),
                child: capText(
                  '4.3468 NAT (43.468 \$)',
                  context,
                )),
          ],
        ),
        const SizedBox(height: 20),
        capText(
            'Withdrawal amount will be credited to test...test This Address.',
            context),
        const SizedBox(height: 5),
        Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: amount,
                decoration: const InputDecoration(
                  isDense: true,
                  labelStyle: TextStyle(fontSize: 14),
                  labelText: 'Enter Amount',
                  prefixIcon: Icon(Icons.money),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: FilledButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Buy Nat')),
            ),
          ],
        ),
      ],
    );
  }
}

//_TBCWalletHistoryList
class _TBCWalletHistoryList extends StatefulWidget {
  const _TBCWalletHistoryList({Key? key}) : super(key: key);

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
  const _SubscriptionContent();

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
  State<ProfileEditPage> createState() => _ProfileEditPageState();
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
/*
//PlutoGridExamplePage
class _PlutoGridExamplePage extends StatefulWidget {
  const _PlutoGridExamplePage({Key? key}) : super(key: key);

  @override
  State<_PlutoGridExamplePage> createState() => _PlutoGridExamplePageState();
}

PlutoRow createRow(String nft, String name, String stakingTime, String price,
        String hashPower, String status) =>
    PlutoRow(
      cells: {
        'nft': PlutoCell(value: nft),
        'name': PlutoCell(value: name),
        'staking_time': PlutoCell(value: stakingTime),
        'price': PlutoCell(value: int.parse(price)),
        'hash_power': PlutoCell(value: hashPower),
        'status': PlutoCell(value: status),
      },
    );

class _PlutoGridExamplePageState extends State<_PlutoGridExamplePage> {
  List<PlutoColumn> generateColumns() => <PlutoColumn>[
        PlutoColumn(
          title: 'NFT',
          field: 'nft',
          type: PlutoColumnType.text(),
          renderer: (rc) =>
              Text(rc.cell.value, maxLines: 1, overflow: TextOverflow.ellipsis),
        ),
        PlutoColumn(
          title: 'Name',
          field: 'name',
          type: PlutoColumnType.text(),
          renderer: (rc) =>
              Text(rc.cell.value, maxLines: 1, overflow: TextOverflow.ellipsis),
        ),
        PlutoColumn(
          title: 'Staking Time',
          field: 'staking_time',
          type: PlutoColumnType.date(),
          renderer: (rc) =>
              Text(rc.cell.value, maxLines: 1, overflow: TextOverflow.ellipsis),
        ),
        PlutoColumn(
          title: 'Price',
          field: 'price',
          type: PlutoColumnType.number(),
          renderer: (rc) => Text((rc.cell.value ?? '').toString(),
              maxLines: 1, overflow: TextOverflow.ellipsis),
        ),
        PlutoColumn(
          title: 'Hash Power',
          field: 'hash_power',
          type: PlutoColumnType.text(),
          renderer: (rc) =>
              Text(rc.cell.value, maxLines: 1, overflow: TextOverflow.ellipsis),
        ),
        PlutoColumn(
          title: 'Status',
          field: 'status',
          type: PlutoColumnType.text(),
          // width: 200,
          // minWidth: 175,
          renderer: (rc) {
            return SizedBox(
              width: 275,
              child: Row(
                children: [
                  Expanded(
                    child: Text(rc.cell.value,
                        maxLines: 1, overflow: TextOverflow.clip),
                  ),
                  IconButton(
                    icon: const Icon(Icons.rocket_launch_outlined, size: 10),
                    onPressed: () {
                      Get.context!.pushNamed(RouteName.nftDetails);
                    },
                    iconSize: 18,
                    color: Colors.red,
                    padding: const EdgeInsets.all(0),
                  ),
                ],
              ),
            );
          },
        ),
      ];

  List<PlutoRow> generateRows() {
    List<PlutoRow> rows = [];
    for (int i = 1; i <= 100; i++) {
      PlutoRow row = createRow(
        'user$i',
        'Name $i',
        MyDateUtils.formatDateTime(DateTime.now().subtract(Duration(days: i))),
        '${25 * i}',
        '${0.0005 * i}',
        i % 5 == 0 ? 'In-Active' : 'Active',
      );
      rows.add(row);
    }

    return rows;
  }

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
  final List<PlutoColumn> columns = [];

  // Pass an empty row to the grid initially.
  final List<PlutoRow> rows = [];

  final List<PlutoRow> fakeFetchedRows = [];

  @override
  void initState() {
    super.initState();

    // final dummyData = DummyData(10, 1000);

    columns.addAll(<PlutoColumn>[
      PlutoColumn(
        suppressedAutoSize: true,
        title: 'NFT',
        field: 'nft',
        type: PlutoColumnType.text(),
        renderer: (rc) =>
            Text(rc.cell.value, maxLines: 1, overflow: TextOverflow.ellipsis),
      ),
      PlutoColumn(
        suppressedAutoSize: true,
        title: 'Name',
        field: 'name',
        type: PlutoColumnType.text(),
        renderer: (rc) =>
            Text(rc.cell.value, maxLines: 1, overflow: TextOverflow.ellipsis),
      ),
      PlutoColumn(
        suppressedAutoSize: true,
        title: 'Staking Time',
        field: 'staking_time',
        type: PlutoColumnType.date(),
        renderer: (rc) =>
            Text(rc.cell.value, maxLines: 1, overflow: TextOverflow.ellipsis),
      ),
      PlutoColumn(
        suppressedAutoSize: true,
        title: 'Price',
        field: 'price',
        type: PlutoColumnType.number(),
        renderer: (rc) => Text((rc.cell.value ?? '').toString(),
            maxLines: 1, overflow: TextOverflow.ellipsis),
      ),
      PlutoColumn(
        suppressedAutoSize: true,
        title: 'Hash Power',
        field: 'hash_power',
        type: PlutoColumnType.text(),
        renderer: (rc) =>
            Text(rc.cell.value, maxLines: 1, overflow: TextOverflow.ellipsis),
      ),
      PlutoColumn(
        suppressedAutoSize: true,
        title: 'Status',
        field: 'status',
        type: PlutoColumnType.text(),
        // width: 200,
        // minWidth: 175,
        renderer: (rc) {
          return SizedBox(
            width: 275,
            child: Row(
              children: [
                Expanded(
                  child: Text(rc.cell.value,
                      maxLines: 1, overflow: TextOverflow.clip),
                ),
                IconButton(
                  icon: const Icon(Icons.rocket_launch_outlined, size: 10),
                  onPressed: () {
                    Get.context!.pushNamed(RouteName.nftDetails);
                  },
                  iconSize: 18,
                  color: Colors.red,
                  padding: const EdgeInsets.all(0),
                ),
              ],
            ),
          );
        },
      ),
    ]);

    // Instead of fetching data from the server,
    // Create a fake row in advance.
    fakeFetchedRows.addAll(generateRows());
  }

  Future<PlutoLazyPaginationResponse> fetch(
      PlutoLazyPaginationRequest request) async {
    List<PlutoRow> tempList = fakeFetchedRows;
*/
/*
    if (request.filterRows.isNotEmpty) {
      final filter = FilterHelper.convertRowsToFilter(
        request.filterRows,
        stateManager.refColumns,
      );

      tempList = fakeFetchedRows.where(filter!).toList();
    }
    if (request.sortColumn != null && !request.sortColumn!.sort.isNone) {
      tempList = [...tempList];

      tempList.sort((a, b) {
        final sortA = request.sortColumn!.sort.isAscending ? a : b;
        final sortB = request.sortColumn!.sort.isAscending ? b : a;

        return request.sortColumn!.type.compare(
          sortA.cells[request.sortColumn!.field]!.valueForSorting,
          sortB.cells[request.sortColumn!.field]!.valueForSorting,
        );
      });
    }*/
/*
    final page = request.page;
    const pageSize = 100;
    final totalPage = (tempList.length / pageSize).ceil();
    final start = (page - 1) * pageSize;
    final end = start + pageSize;
    Iterable<PlutoRow> fetchedRows =
        tempList.getRange(max(0, start), min(tempList.length, end));

    await Future.delayed(const Duration(milliseconds: 500));

    return Future.value(PlutoLazyPaginationResponse(
        totalPage: totalPage, rows: fetchedRows.toList()));
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: PlutoGrid(
          columns: columns,
          rows: rows,
          // columnGroups: columnGroups,
          onLoaded: (PlutoGridOnLoadedEvent event) {
            stateManager = event.stateManager;

            stateManager.setShowColumnFilter(false);
            // print(stateManager.columns);
            // for (var e in stateManager.columns) {
            //   stateManager.autoFitColumn(context, e);
            // }
          },
          onChanged: (PlutoGridOnChangedEvent event) {},
          configuration: PlutoGridConfiguration(
              style: PlutoGridStyleConfig(
                  enableCellBorderHorizontal: false,
                  enableCellBorderVertical: false,
                  activatedColor: getTheme.colorScheme.primary.withOpacity(0.4),
                  oddRowColor:
                      (getTheme.textTheme.bodyMedium?.color ?? Colors.white)
                          .withOpacity(0.2),
                  evenRowColor: (redDark).withOpacity(0.2),
                  gridBackgroundColor: getTheme.cardColor,
                  gridBorderColor: Colors.transparent,
                  borderColor: Colors.transparent,
                  iconColor:
                      getTheme.textTheme.titleLarge?.color ?? Colors.white,
                  rowColor:
                      (getTheme.textTheme.bodyMedium?.color ?? Colors.white)
                          .withOpacity(0.2),
                  columnTextStyle: const TextStyle(
                      // color: Colors.black,
                      decoration: TextDecoration.none,
                      // fontSize: 14,
                      fontWeight: FontWeight.bold))),
          mode: PlutoGridMode.select,
          createFooter: (stateManager) {
            return PlutoLazyPagination(
              // Determine the first page.
              // Default is 1.
              initialPage: 1,

              // First call the fetch function to determine whether to load the page.
              // Default is true.
              initialFetch: true,

              // Decide whether sorting will be handled by the server.
              // If false, handle sorting on the client side.
              // Default is true.
              fetchWithSorting: true,

              // Decide whether filtering is handled by the server.
              // If false, handle filtering on the client side.
              // Default is true.
              fetchWithFiltering: true,

              // Determines the page size to move to the previous and next page buttons.
              // Default value is null. In this case,
              // it moves as many as the number of page buttons visible on the screen.
              pageSizeToMove: null,
              fetch: fetch,
              stateManager: stateManager,
            );
          },
        ),
      ),
    );
  }
}*/

class _NFTListWidget extends StatefulWidget {
  @override
  State<_NFTListWidget> createState() => _NFTListWidgetState();
}

class _NFTListWidgetState extends State<_NFTListWidget> {
  int nftCount = 10;

  List<_NFTData> generateRandomUsers(int count) => List.generate(
      count,
      (index) => _NFTData(
            srNo: index,
            username: 'NFT53450251',
            stackingTime: Random().nextInt(10).toString(),
            activeDate: DateTime.now()
                .subtract(Duration(days: index - 1))
                .toIso8601String(),
            status: index % 5 == 0 ? 'Inactive' : 'Active',
            hasPower: 0.002 * index,
            nft: 'https://www.nathorizon.com/public/images/userNft/8973.jpg',
          ));
  @override
  Widget build(BuildContext context) {
    List<_NFTData> nftList = generateRandomUsers(nftCount);
    return RefreshIndicator(
      onRefresh: _refresh,
      child: LoadMore(
        isFinish: nftCount >= 35,
        onLoadMore: _loadMore,
        whenEmptyLoad: true,
        delegate: const MyLoadMoreDelegate(),
        textBuilder: DefaultLoadMoreTextBuilder.english,
        child: ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: paddingDefault),
          itemCount: nftList.length,
          itemBuilder: (context, index) {
            return _NFTCard(nftData: nftList[index]);
          },
        ),
      ),
    );
  }

  Future<bool> _loadMore() async {
    await Future.delayed(const Duration(seconds: 0, milliseconds: 10000));
    if (mounted) {
      setState(() {
        nftCount += 5;
      });
    }
    return true;
  }

  Future<void> _refresh() async {
    await Future.delayed(const Duration(seconds: 0, milliseconds: 2000));
    setState(() {
      nftCount = 10;
    });
  }
}

class _NFTCard extends StatelessWidget {
  final _NFTData nftData;

  const _NFTCard({required this.nftData});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: paddingDefault),
      // elevation: 7,
      // color: Colors.white,
      // shadowColor: Colors.transparent,

      decoration: BoxDecoration(
          color: getTheme.colorScheme.secondary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [BoxShadow(color: getTheme.colorScheme.background)]),
      child: Padding(
        padding: EdgeInsets.all(paddingDefault),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(backgroundImage: NetworkImage(nftData.nft)),
                width5(),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    bodyLargeText(nftData.username, context),
                    height5(),
                    Row(
                      children: [
                        assetImages(PNGAssets.timeSpan, width: 15),
                        width5(),
                        capText('${nftData.stackingTime} Months', context),
                        width5(),
                        const Image(
                            image: NetworkImage(
                                'https://www.nathorizon.com/public/user/images/nft-stake.gif'),
                            width: 15),
                      ],
                    ),
                  ],
                )),
              ],
            ),
            height5(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  children: [
                    const Icon(Icons.attach_money, size: 15),
                    width5(),
                    bodyMedText(nftData.hasPower.toStringAsFixed(6), context),
                  ],
                ),
                width10(),
                Row(
                  children: [
                    const Icon(Icons.diamond_outlined,
                        color: Colors.blueAccent, size: 15),
                    width5(),
                    bodyMedText(nftData.hasPower.toStringAsFixed(6), context),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _NFTData {
  final int srNo;
  final String username;
  final String stackingTime;
  final String activeDate;
  final String status;
  final double hasPower;
  final String nft;

  _NFTData({
    required this.srNo,
    required this.username,
    required this.stackingTime,
    required this.activeDate,
    required this.status,
    required this.hasPower,
    required this.nft,
  });
}
