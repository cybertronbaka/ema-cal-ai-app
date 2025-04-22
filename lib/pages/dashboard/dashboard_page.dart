library;

import 'package:ema_cal_ai/app/routes.dart';
import 'package:ema_cal_ai/controllers/home_controller.dart';
import 'package:ema_cal_ai/pages/home/home_content.dart';
import 'package:ema_cal_ai/states/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

enum DashboardPageType {
  overview('Overview', FontAwesomeIcons.chartSimple),
  home('Home', FontAwesomeIcons.house),
  settings('Settings', FontAwesomeIcons.gear);

  const DashboardPageType(this.label, this.icon);

  final String label;
  final IconData icon;

  Widget? get floatingButton {
    return switch (this) {
      overview => null,
      home => const HomeFloatingButton(),
      settings => null,
    };
  }

  String get pageName {
    return switch (this) {
      overview => Routes.overview.name,
      home => Routes.home.name,
      settings => Routes.settings.name,
    };
  }

  String get pagePath {
    return switch (this) {
      overview => Routes.overview.path(),
      home => Routes.home.path(),
      settings => Routes.settings.path(),
    };
  }
}

class DashboardPage extends HookConsumerWidget {
  const DashboardPage({
    super.key,
    required this.navigationShell,
    required this.children,
  });
  final StatefulNavigationShell navigationShell;
  final List<Widget> children;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(homeControllerProvider);
    ref.watch(streaksCountProvider);
    final type = DashboardPageType.values[navigationShell.currentIndex];

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: AnimatedBranchContainer(
          currentIndex: navigationShell.currentIndex,
          children: children,
        ),
      ),
      floatingActionButton: type.floatingButton,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navigationShell.currentIndex,
        onTap: (index) {
          // currentPageIndex.value = index;
          navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          );
        },
        items: [
          for (var type in DashboardPageType.values)
            BottomNavigationBarItem(
              icon: FaIcon(type.icon, size: 18),
              label: type.label,
            ),
        ],
      ),
    );
  }
}

class AnimatedBranchContainer extends HookWidget {
  const AnimatedBranchContainer({
    super.key,
    required this.currentIndex,
    required this.children,
  });

  final int currentIndex;

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final currentPage = useValueNotifier(currentIndex);
    final pageController = usePageController(initialPage: currentPage.value);

    useEffect(() {
      if (currentPage.value == currentIndex) return;

      pageController.animateToPage(
        currentIndex,
        duration: Duration(
          milliseconds: 500 * (currentPage.value - currentIndex).abs(),
        ),
        curve: Curves.easeInOut,
      );
      currentPage.value = currentIndex;

      return null;
    }, [currentIndex]);

    return PageView(
      controller: pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: children,
    );
  }
}
