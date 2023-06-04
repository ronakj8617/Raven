import 'package:flutter/material.dart';
import './messages_page.dart';
import './account_page.dart';
import './login_page.dart';
import './register_page.dart';
import './tabs_page.dart';
import './temp_main.dart';
import '../appwrite/auth_api.dart';
import '../appwrite/database_api.dart';
import '../constants/constants.dart';

class TabsPage extends StatefulWidget {
  const TabsPage({Key? key}) : super(key: key);

  @override
  _TabsPageState createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> {
  int _selectedIndex = 0;

  static const _widgets = [MessagesPage(), AccountPage()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgets.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.message_outlined), label: "Messages"),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_outlined), label: "Account")
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
