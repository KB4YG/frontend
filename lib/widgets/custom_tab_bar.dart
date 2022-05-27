import 'package:flutter/material.dart';
import 'package:kb4yg/constants.dart' as constants;

class CustomTabBar extends StatefulWidget {
  final TabController controller;
  final void Function()? onChangeTab;
  const CustomTabBar({Key? key, required this.controller, this.onChangeTab})
      : super(key: key);

  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> {
  TabController get _tabController => widget.controller;
  int _tabIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController.addListener(onChangeTab);
  }

  void onChangeTab() {
    setState(() => _tabIndex = _tabController.index);
    if (widget.onChangeTab != null) widget.onChangeTab!();
  }

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: widget.controller,
      indicatorColor: Colors.transparent,
      tabs: [
        Tab(
          text: constants.pageHome,
          icon: _tabIndex == 0
              ? const Icon(Icons.home)
              : const Icon(Icons.home_outlined),
          iconMargin: const EdgeInsets.only(bottom: 1.0),
        ),
        Tab(
          text: constants.pageLocations,
          icon: _tabIndex == 1
              ? const Icon(Icons.directions_car)
              : const Icon(Icons.directions_car_outlined),
          iconMargin: const EdgeInsets.only(bottom: 1.0),
        ),
        Tab(
          text: constants.pageHelp,
          icon: _tabIndex == 2
              ? const Icon(Icons.help_outlined)
              : const Icon(Icons.help_outline),
          iconMargin: const EdgeInsets.only(bottom: 1.0),
        ),
        Tab(
          text: constants.pageAbout,
          icon: _tabIndex == 3
              ? const Icon(Icons.info)
              : const Icon(Icons.info_outlined),
          iconMargin: const EdgeInsets.only(bottom: 1.0),
        )
      ],
    );
  }
}