// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import './profile/profile_screen.dart';
import 'notifications_screen.dart';
import 'search_screen.dart';

import '../../widgets.dart';

class HomeScreen extends StatefulWidget {
  static const route = "/";
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: GoogleMap(
                zoomControlsEnabled: false,
                initialCameraPosition: CameraPosition(
                  target: LatLng(36.35, 6.6),
                ),
              ),
            ),
          ),
          Positioned(
            top: 10,
            right: 10,
            child: Row(
              children: [
                GacelaIconButton(
                  child: Icon(
                    Icons.notifications_none,
                    size: 30,
                  ),
                  onTap: () async =>
                      Navigator.pushNamed(context, NotificationsScreen.route),
                ),
                const SizedBox(width: 10),
                GacelaIconButton(
                  child: CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage("https://i.pravatar.cc/300"),
                  ),
                  onTap: () async =>
                      Navigator.pushNamed(context, ProfileScreen.route),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 10,
            right: 10,
            child: GacelaIconButton(
              child: Icon(Icons.search),
              onTap: () async =>
                  Navigator.pushNamed(context, SearchScreen.route),
            ),
          ),
        ],
      ),
    );
  }
}
