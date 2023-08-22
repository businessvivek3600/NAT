import 'dart:math';

import 'package:collapsible_sidebar/collapsible_sidebar.dart';
import 'package:collapsible_sidebar/collapsible_sidebar/collapsible_item.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_global_tools/constants/asset_constants.dart';
import 'package:my_global_tools/screens/BottomNav/dash_setting_page.dart';
import 'package:my_global_tools/utils/date_utils.dart';
import 'package:my_global_tools/utils/picture_utils.dart';
import '/utils/default_logger.dart';
import '/utils/sized_utils.dart';
import '/utils/text.dart';

import '../../../widgets/appbar_calender.dart';

class SlotBookingPage extends StatefulWidget {
  const SlotBookingPage({super.key, required this.service, required this.shop});
  final String service;
  final String shop;

  @override
  State<SlotBookingPage> createState() => _SlotBookingPageState();
}

class _SlotBookingPageState extends State<SlotBookingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              top: getHeight * 0.2,
              right: 0,
              left: 0,
              bottom: 0,
              child: SidebarPage()),
          // Positioned(top: getHeight * 0.2, child: ToggleBrightnessButton()),
        ],
      ),
    );
  }
}

class SidebarPage extends StatefulWidget {
  const SidebarPage({super.key});

  @override
  _SidebarPageState createState() => _SidebarPageState();
}

class _SidebarPageState extends State<SidebarPage> {
  late List<CollapsibleItem> _items;
  String? _headline;

  @override
  void initState() {
    super.initState();
    _items = _generateItems;
    _headline = _items.firstWhere((item) => item.isSelected).text;
  }

  List<CollapsibleItem> get _generateItems {
    return [
      CollapsibleItem(
          text: 'Dashboard',
          icon: Icons.assessment,
          onPressed: () => setState(() => _headline = 'DashBoard'),
          onHold: () => ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Dashboard"))),
          isSelected: true,
          subItems: [
            CollapsibleItem(
              text: 'Menu',
              icon: Icons.menu_book,
              onPressed: () => setState(() => _headline = 'Menu'),
              onHold: () => ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text("Menu"))),
              isSelected: true,
            ),
            CollapsibleItem(
                text: 'Shop',
                iconImage: const AssetImage("assets/shop_icon.png"),
                icon: Icons.ac_unit,
                onPressed: () => setState(() => _headline = 'Shop'),
                onHold: () => ScaffoldMessenger.of(context)
                    .showSnackBar(const SnackBar(content: Text("Shop"))),
                isSelected: true,
                subItems: [
                  CollapsibleItem(
                    text: 'Cart',
                    icon: Icons.shopping_cart,
                    onPressed: () => setState(() => _headline = 'Cart'),
                    onHold: () => ScaffoldMessenger.of(context)
                        .showSnackBar(const SnackBar(content: Text("Cart"))),
                    isSelected: true,
                  )
                ]),
          ]),
      CollapsibleItem(
        text: 'Inventory',
        icon: Icons.photo_library,
        onPressed: () => setState(() => _headline = 'NFT Gallery'),
        onHold: () => ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("NFT Gallery"))),
      ),
      CollapsibleItem(
        text: 'NAT Wallet',
        icon: Icons.wallet,
        onPressed: () => setState(() => _headline = 'NAT Wallet'),
        onHold: () => ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("NAT Wallet"))),
      ),
      CollapsibleItem(
        text: 'Commission Wallet',
        icon: Icons.account_balance_wallet_rounded,
        onPressed: () => setState(() => _headline = 'Commission Wallet'),
        onHold: () => ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Commission Wallet"))),
      ),
      CollapsibleItem(
        text: 'TBCC Wallet',
        icon: Icons.account_balance_wallet_sharp,
        onPressed: () => setState(() => _headline = 'TBCC Wallet'),
        onHold: () => ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("TBCC Wallet"))),
      ),
      CollapsibleItem(
        text: 'Account Setting',
        icon: Icons.manage_accounts_rounded,
        onPressed: () => setState(() => _headline = 'Edit Profile'),
        onHold: () => ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Account Setting"))),
      ),
      CollapsibleItem(
        text: 'Subscription',
        icon: Icons.subscriptions_outlined,
        onPressed: () => setState(() => _headline = 'NAT Subscription'),
        onHold: () => ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Subscription"))),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, bound) {
      return CollapsibleSidebar(
        isCollapsed: bound.maxWidth <= 800,
        items: _items,
        collapseOnBodyTap: false,
        avatarImg: const NetworkImage(
            'https://www.nathorizon.com/public/user/images/author29.png'),
        title: 'Coding Mobile',
        onTitleTap: () {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Yay! Flutter Collapsible Sidebar!')));
        },
        body: _body(Size(bound.maxWidth, bound.maxHeight), context),
        backgroundColor: getTheme.colorScheme.onPrimary,
        // selectedTextColor: Colors.limeAccent,
        textStyle: const TextStyle(fontSize: 15),
        sidebarBoxShadow: [
          const BoxShadow(
            color: Colors.transparent,
            blurRadius: 0,
            spreadRadius: 0.01,
            offset: Offset(0, 0),
          ),
          const BoxShadow(
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
      );
    });
  }

  Widget _body(Size size, BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: EdgeInsets.all(spaceDefault),
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            Row(
              children: [
                titleLargeText(_headline ?? '', context,
                    fontSize: 25, color: Colors.white)
              ],
            )
          ],
        ),
      ),
    );
  }
}
