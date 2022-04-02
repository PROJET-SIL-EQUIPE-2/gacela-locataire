import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../config/theme/colors.dart';
import 'navigators.dart';

class MainScreen extends StatefulWidget {
  static const route = "/main";
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 1;

  final _navigators = [
    const CourseNavigator(),
    const HomeNavigator(),
    const ProfileNavigator(),
  ];

  final List<GlobalKey<NavigatorState>> _navigatorKeys = [
    CourseNavigator.courseNavigatorKey,
    HomeNavigator.homeNavigatorKey,
    ProfileNavigator.profileNavigatorKey
  ];

  Future<bool> _systemBackButtonPressed() async {
    if (_navigatorKeys[_currentIndex].currentState!.canPop()) {
      _navigatorKeys[_currentIndex]
          .currentState!
          .pop(_navigatorKeys[_currentIndex].currentContext);
    } else {
      if (_currentIndex != 1) {
        setState(() {
          _currentIndex = 1;
        });
      } else {
        await SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop');
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _systemBackButtonPressed,
      child: Scaffold(
        bottomNavigationBar: Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                offset: const Offset(0, 1),
                blurRadius: 4,
              )
            ],
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          child: BottomNavigationBar(
            showSelectedLabels: false,
            showUnselectedLabels: false,
            selectedItemColor: GacelaColors.gacelaPurple,
            backgroundColor: Colors.white,
            elevation: 0,
            iconSize: 30,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.calendar_today), label: 'Courses'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.track_changes_outlined), label: 'Profile')
            ],
            currentIndex: _currentIndex,
            onTap: (index) => setState(() => _currentIndex = index),
          ),
        ),
        body: SafeArea(
            child: IndexedStack(
          index: _currentIndex,
          children: _navigators,
        )),
      ),
    );
  }
}
