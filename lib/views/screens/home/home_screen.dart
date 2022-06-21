// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:gacela_locataire/providers/course_provider.dart';
import 'package:gacela_locataire/providers/payment_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../../providers/auth_provider.dart';
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
              child: Consumer<CourseProvider>(
                builder: (context, courseProivder, _) => GoogleMap(
                  myLocationEnabled: true,
                  zoomControlsEnabled: false,
                  markers: {
                    if (courseProivder.currentLocation != null)
                      Marker(
                        markerId: MarkerId('current position'),
                        position: LatLng(
                            courseProivder.currentLocation!.latitude,
                            courseProivder.currentLocation!.longitude),
                      ),
                  },
                  initialCameraPosition: CameraPosition(
                    target: courseProivder.currentLocation == null
                        ? LatLng(36.35, 6.6)
                        : LatLng(courseProivder.currentLocation!.latitude,
                            courseProivder.currentLocation!.longitude),
                    zoom: 14,
                  ),
                  compassEnabled: true,
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
                  onTap: () async => await Navigator.pushNamed(
                      context, NotificationsScreen.route),
                ),
                const SizedBox(width: 10),
                GacelaIconButton(
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.transparent,
                    onBackgroundImageError: (_, __) =>
                        Image.asset('assets/images/placeholder-image.png'),
                    backgroundImage: NetworkImage(
                      "${dotenv.get("SERVER")}/${(Provider.of<AuthProvider>(context, listen: false).user?.personalPhoto as String).replaceAll('\\', '/')}.png",
                    ),
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
