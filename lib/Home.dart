// ignore: file_names
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:xpensetrack/Expenses/Expenses.dart';
import 'package:xpensetrack/profile.dart';
import 'package:xpensetrack/Remainder/remainder.dart';



class homeScreen extends StatefulWidget {
  const homeScreen({super.key});

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  late PageController controller;

  @override
  void initState() {
    super.initState();
    controller = PageController(initialPage: 0);
  }
   @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  var _selectedTab = _SelectedTab.home;

  void _handleIndexChanged(int i) {
    setState(() {
      _selectedTab = _SelectedTab.values[i];
      controller.jumpToPage(i);
   
      
    });
  }

  @override
  Widget build(BuildContext context) {
  

    return  Material(
    child: Scaffold(
    extendBody: true,
    body: PageView(
    physics: const NeverScrollableScrollPhysics(),
    onPageChanged:(val){
     setState(() {
              _selectedTab = _SelectedTab.values[val];
            });
    },
    controller: controller,

children: const [
expenses(),
remainderScreen(),


profile()
          ],
    ),
    bottomNavigationBar: DotNavigationBar(
    enableFloatingNavBar: true,

    backgroundColor: const Color(0xFFe2e6fe),
          currentIndex: _SelectedTab.values.indexOf(_selectedTab),
          onTap: _handleIndexChanged,
          // dotIndicatorColor: Colors.black,
          items: [
            /// Home
            DotNavigationBarItem(
              icon: const Icon(Icons.home),
              selectedColor: Colors.pink,
            ),

            /// Likes
            DotNavigationBarItem(
              icon: const Icon(Icons.payments),
              selectedColor: Colors.green,
            ),

            /// Search
           
            /// Profile
            DotNavigationBarItem(
              icon: const Icon(Icons.person),
              selectedColor: Colors.teal,
            ),
          ],
        ),
    ),);
  }
}
enum _SelectedTab { home, favorite, search, person }
