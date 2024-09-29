import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/dashboard/page_provider.dart';
import '../add_post/add_post_screen.dart';
import '../payments/payment_screen.dart';
import 'dashboard.dart';

class AdminDashboard extends StatelessWidget {
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
                  child: Text(
                    'Admin Panel',
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                  decoration: BoxDecoration(color: Colors.blueGrey[800]),
                ),
                ListTile(
                  title: Text('Dashboard', style: TextStyle(color: Colors.white)),
                  leading: Icon(Icons.dashboard, color: Colors.white),
                  onTap: () {
                    Provider.of<PageProvider>(context, listen: false).navigateTo('Dashboard');
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
                  title: Text('Payments', style: TextStyle(color: Colors.white)),
                  leading: Icon(Icons.payment, color: Colors.white),
                  onTap: () {
                    Provider.of<PageProvider>(context, listen: false).navigateTo('Payments');
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
      case 'Add Post':
        return AddPostPage();
      case 'Payments':
        return PaymentsPage();
      default:
        return DashboardPage(); // Default to Dashboard
    }
  }
}
