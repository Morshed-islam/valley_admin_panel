import 'package:flutter/material.dart';
import 'package:new_valley_admin/screens/all_villa/all_villa_screen.dart';
import 'package:provider/provider.dart';
import '../../providers/dashboard/page_provider.dart';
import '../add_post/add_villa_screen.dart';
import '../add_slider/add_slider.dart';
import '../payments/bookings_screen.dart';
import 'dashboard.dart';

class StarterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Left sidebar
          Container(
            width: 250,
            color: Colors.blueGrey[800],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(color: Colors.blueGrey[800]),
                  child: Image.asset(
                    'assets/logo.png',
                    fit: BoxFit.contain,
                    width: 250,
                    height: 150,
                    filterQuality: FilterQuality.high,
                  ),
                ),
                ListTile(
                  title: Text('Dashboard', style: TextStyle(color: Colors.white)),
                  leading: Icon(Icons.dashboard, color: Colors.white),
                  onTap: () {
                    Provider.of<PageProvider>(context, listen: false).navigateTo('Dashboard');
                  },
                ),
                ListTile(
                  title: Text('All Villas', style: TextStyle(color: Colors.white)),
                  leading: Icon(Icons.list_alt_sharp, color: Colors.white),
                  onTap: () {
                    Provider.of<PageProvider>(context, listen: false).navigateTo('All Villas');
                  },
                ),
                ListTile(
                  title: Text('Add Post', style: TextStyle(color: Colors.white)),
                  leading: Icon(Icons.post_add, color: Colors.white),
                  onTap: () {
                    Provider.of<PageProvider>(context, listen: false).navigateTo('Add Post');
                  },
                ),
                ListTile(
                  title: Text('Add Slider', style: TextStyle(color: Colors.white)),
                  leading: Icon(Icons.payment, color: Colors.white),
                  onTap: () {
                    Provider.of<PageProvider>(context, listen: false).navigateTo('addSlider');
                  },
                ),
                ListTile(
                  title: Text('All Bookings', style: TextStyle(color: Colors.white)),
                  leading: Icon(Icons.payment, color: Colors.white),
                  onTap: () {
                    Provider.of<PageProvider>(context, listen: false).navigateTo('Bookings');
                  },
                ),
              ],
            ),
          ),
          // Right content area
          Expanded(
            child: Consumer<PageProvider>(
              builder: (context, pageProvider, child) {
                return _getSelectedPage(pageProvider.selectedPage);
              },
            ),
          ),
        ],
      ),
    );
  }

  // Logic to switch between different pages
  Widget _getSelectedPage(String selectedPage) {
    switch (selectedPage) {
      case 'Dashboard':
        return DashboardPage();
      case 'All Villas':
        return AllVillaScreen();
      case 'Add Post':
        return AddVillaPage();
      case 'addSlider':
        return AddSliderPage();
      case 'Bookings':
        return BookingsPage();

      default:
        return DashboardPage(); // Default to Dashboard
    }
  }
}
