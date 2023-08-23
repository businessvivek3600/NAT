import 'package:flutter/material.dart';
import '../Bookings/blogs.dart';
import '../BottomNav/explore.dart';
import '../BottomNav/dash_home_page.dart';
import '/providers/auth_provider.dart';
import '/providers/dashboard_provider.dart';
import '/providers/setting_provider.dart';
import '/screens/BottomNav/dash_bottom_nav.dart';
import '../BottomNav/dash_setting_page.dart';

import 'package:provider/provider.dart';

import '../../services/auth_service.dart';
import 'Booking/dashboard_page.dart';
import 'Shop/shopDetailsPage.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final StreamAuth info = StreamAuthScope.of(context);

    return Consumer<DashboardProvider>(
      builder: (context, dashProvider, child) {
        return WillPopScope(
          onWillPop: () async => await willPopScope(dashProvider),
          child: Consumer<AuthProvider>(
            builder: (context, authProvider, child) {
              return Consumer<SettingProvider>(
                builder: (context, settingProvider, child) {
                  return Scaffold(
                    // drawer: const MainDrawer(),
                    body: dashProvider.bottomIndex == 4
                        ? const DashSettingPage()
                        : dashProvider.bottomIndex == 3
                            ? const BlogsPage(backAllowed: false)
                            : dashProvider.bottomIndex == 2
                                ? const DashboardPage(
                                    shop: 'none', service: 'none')
                                : dashProvider.bottomIndex == 1
                                    ? const Explore(backAllowed: false)
                                    : DashHomePage(),
                    bottomNavigationBar: const DashBottomNav(),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }

  Future<bool> willPopScope(DashboardProvider dashProvider) async {
    if (dashProvider.bottomIndex == 0) {
      return true;
    } else {
      dashProvider.setBottomIndex(0);
      return false;
    }
  }
}
