import 'package:flutter/material.dart';
import 'package:vpn_app/features/analytics/presentation/pages/analytics_page.dart';
import 'package:vpn_app/features/vpn_connection/presentation/pages/vpn_connection_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [VpnConnectionPage(), AnalyticsPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        height: 65,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.vpn_lock_outlined),
            selectedIcon: Icon(Icons.vpn_lock),
            label: 'VPN',
          ),
          NavigationDestination(
            icon: Icon(Icons.bar_chart_outlined),
            selectedIcon: Icon(Icons.bar_chart),
            label: 'Аналитика',
          ),
        ],
      ),
    );
  }
}
