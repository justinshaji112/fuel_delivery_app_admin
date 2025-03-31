import 'package:flutter/material.dart';
import 'package:fuel_delivary_app_admin/utils/constants/colors.dart';
import 'package:fuel_delivary_app_admin/view/pages/agent_page.dart';
import 'package:fuel_delivary_app_admin/view/pages/offer_page.dart';
import 'package:fuel_delivary_app_admin/view/pages/service_page.dart';
import 'package:fuel_delivary_app_admin/view/pages/users_page.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  _AdminDashboardScreenState createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  int _selectedIndex = 4;

  final List<Widget> _screens = [
    const DashboardView(),
    const UsersView(),
    const AgentView(),
    const ServicesView(),
    const OfferView(),
    const SettingsView(),
    const SettingsView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Container(
            width: 280,
            color: Colors.black,
            child: Column(
              children: [
                const DashboardLeadingIcon(),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    children: [
                      _buildNavItem(
                        icon: Icons.dashboard_rounded,
                        title: 'Dashboard',
                        index: 0,
                      ),
                      _buildNavItem(
                        icon: Icons.people_alt_rounded,
                        title: 'Users',
                        index: 1,
                      ),
                      _buildNavItem(
                        icon: Icons.work_rounded,
                        title: 'Agents',
                        index: 2,
                      ),
                      _buildNavItem(
                        icon: Icons.miscellaneous_services_rounded,
                        title: 'Services',
                        index: 3,
                      ),
                      _buildNavItem(
                        icon: Icons.local_offer_rounded,
                        title: 'Offers',
                        index: 4,
                      ),
                      _buildNavItem(
                        icon: Icons.settings_rounded,
                        title: 'Settings',
                        index: 5,
                      ),
                      _buildNavItem(
                        icon: Icons.settings_rounded,
                        title: 'Settings',
                        index: 6,
                      ),
                    ],
                  ),
                ),
                const LogOutButton(),
              ],
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
              ),
              child: _screens[_selectedIndex],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String title,
    required int index,
  }) {
    bool isSelected = _selectedIndex == index;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: isSelected ? const Color(0xFF34495E) : Colors.transparent,
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        leading: Icon(
          icon,
          color: isSelected ? Colors.white : Colors.white70,
          size: 26,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.white70,
            fontSize: 16,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            letterSpacing: 0.5,
          ),
        ),
        onTap: () {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}

class LogOutButton extends StatelessWidget {
  const LogOutButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: ElevatedButton.icon(
        icon: const Icon(Icons.logout_rounded, color: Colors.white),
        label: const Text(
          'Logout',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFE74C3C),
          padding: const EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 25,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 3,
        ),
      ),
    );
  }
}

class DashboardLeadingIcon extends StatelessWidget {
  const DashboardLeadingIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(0.1),
            ),
            child: const Icon(
              Icons.person,
              color: Colors.white,
              size: 60,
            ),
          ),
          const SizedBox(height: 15),
          const Text(
            'Admin Panel',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 5),
          Container(
            width: 50,
            height: 3,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.5),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ],
      ),
    );
  }
}

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'Dashboard',
          style: TextStyle(
            color: Color(0xFF2C3E50),
            fontWeight: FontWeight.bold,
          ),
        ),
        // actions: [
        //   IconButton(
        //     icon: const Icon(Icons.notifications_rounded,
        //         color: Color(0xFF2C3E50)),
        //     onPressed: () {},
        //   ),
        //   const CircleAvatar(
        //     radius: 18,
        //     backgroundImage: AssetImage('assets/avatar.png'),
        //   ),
        //   const SizedBox(width: 20),
        // ],
      ),
      body: const Padding(
        padding: EdgeInsets.all(20),
        child: Center(
          child: Text(
            'Dashboard Content',
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}

// class UsersManagementView extends StatelessWidget {
//   const UsersManagementView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//         backgroundColor: Colors.transparent, body: UsersView());
//   }
// }

class AgentsManagementView extends StatelessWidget {
  const AgentsManagementView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'Agents Management',
          style: TextStyle(
            color: Color(0xFF2C3E50),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.all(20),
        child: Center(
          child: Text(
            'Agents Management Content',
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}

class ServicesManagementView extends StatelessWidget {
  const ServicesManagementView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'Services Management',
          style: TextStyle(
            color: Color(0xFF2C3E50),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.all(20),
        child: Center(
          child: Text(
            'Services Management Content',
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'Settings',
          style: TextStyle(
            color: Color(0xFF2C3E50),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.all(20),
        child: Center(
          child: Text(
            'Settings Content',
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
