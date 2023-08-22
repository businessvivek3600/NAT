import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:awesome_bottom_bar/widgets/inspired/inspired.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_global_tools/providers/auth_provider.dart';
import 'package:my_global_tools/utils/color.dart';
import 'package:my_global_tools/utils/sized_utils.dart';
import '/providers/dashboard_provider.dart';
import 'package:provider/provider.dart';

class DashBottomNav extends StatefulWidget {
  const DashBottomNav({super.key});

  @override
  State<DashBottomNav> createState() => _DashBottomNavState();
}

class _DashBottomNavState extends State<DashBottomNav> {
  @override
  Widget build(BuildContext context) {
    const List<TabItem> items = [
      TabItem(icon: Icons.home, title: 'Home'),
      TabItem(icon: Icons.explore, title: 'Explore'),
      TabItem(icon: Icons.photo_library, title: 'Gallery'),
      TabItem(icon: Icons.article, title: 'Blogs'),
      TabItem(icon: Icons.settings, title: 'Settings'),
    ];
    return Consumer<AuthProvider>(builder: (context, authProvider, child) {
      return Consumer<DashboardProvider>(
        builder: (context, provider, child) {
          return BottomBarCreative(
            items: items,
            backgroundColor: Theme.of(context).colorScheme.onSecondary,
            color: Theme.of(context).colorScheme.secondary,
            colorSelected: getTheme.colorScheme.primary,
            indexSelected: provider.bottomIndex,
            onTap: provider.setBottomIndex,
            // chipStyle: ChipStyle(
            //     convexBridge: true, background: appLogoColor.withOpacity(0.1)),
            // itemStyle: ItemStyle.circle,
            // animated: false,
            isFloating: true,
            highlightStyle: const HighlightStyle(
                sizeLarge: true, isHexagon: true, elevation: 5),
          );
        },
      );
    });
  }
}
