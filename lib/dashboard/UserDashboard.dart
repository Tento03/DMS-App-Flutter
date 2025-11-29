import 'package:flutter/material.dart';

class Userdashboard extends StatefulWidget {
  const Userdashboard({super.key});

  @override
  State<Userdashboard> createState() => _UserdashboardState();
}

class _UserdashboardState extends State<Userdashboard> {
  String selectedMenu = "Dashboard";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedMenu),
        backgroundColor: Color(0xFF667eea),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications_outlined),
          ),
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person, color: Color(0xFF667eea)),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF667eea), Color(0xFF764ba2)],
            ),
          ),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(color: Colors.transparent),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Admin User",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Admin@gmail.com",
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
              buildDrawerItem(Icons.dashboard, 'Dashboard'),
              buildDrawerItem(Icons.person_outline, 'Profile'),
              buildDrawerItem(Icons.settings_outlined, 'Settings'),
              buildDrawerItem(Icons.bar_chart, 'Reports'),
              buildDrawerItem(Icons.folder_outlined, 'Documents'),
              buildDrawerItem(Icons.notifications_outlined, 'Notifications'),
              Divider(color: Colors.white30, thickness: 1),
              buildDrawerItem(Icons.help_outline, 'Help'),
              buildDrawerItem(Icons.logout, 'Logout'),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDrawerItem(IconData icon, String title) {
    bool isSelected = selectedMenu == title;
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      selected: isSelected,
      selectedTileColor: Colors.white.withOpacity(0.1),
      onTap: () {
        setState(() {
          selectedMenu = title;
        });
        Navigator.pop(context);
      },
    );
  }
}
