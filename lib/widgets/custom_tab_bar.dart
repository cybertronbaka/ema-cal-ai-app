part of 'widgets.dart';

class CustomTabBar extends HookWidget {
  const CustomTabBar({
    super.key,
    required this.tabs,
    this.controller,
    this.initialIndex = 0,
  });

  final List<String> tabs;
  final TabController? controller;
  final int initialIndex;

  @override
  Widget build(BuildContext context) {
    final controller = this.controller ?? DefaultTabController.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
      decoration: BoxDecoration(
        color: Colors.grey.withAlpha(80),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: TabBar(
        controller: controller,
        isScrollable: false,
        indicatorSize: TabBarIndicatorSize.tab,
        dividerHeight: 0,
        indicatorAnimation: TabIndicatorAnimation.elastic,
        splashBorderRadius: BorderRadius.circular(48),
        tabAlignment: TabAlignment.fill,
        unselectedLabelColor: Colors.black.withAlpha(150),
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Color(0x1018280F),
              spreadRadius: -2,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        tabs: [
          for (final tab in tabs)
            Padding(
              padding: const EdgeInsets.all(4),
              child: Center(
                child: Text(tab, style: const TextStyle(fontSize: 12)),
              ),
            ),
        ],
      ),
    );
  }
}
