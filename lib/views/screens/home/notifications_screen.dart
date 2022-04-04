import 'package:flutter/material.dart';
import '../../../config/theme/colors.dart';
import '../../widgets.dart';

class NotificationsScreen extends StatelessWidget {
  static const route = "/notifications";
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
              indicatorColor: GacelaColors.gacelaDeepBlue,
              labelColor: GacelaColors.gacelaDeepBlue,
              unselectedLabelColor: GacelaColors.gacelaGrey,
              labelStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
              tabs: [
                Tab(text: "Tous"),
                Tab(text: "Non lus"),
              ]),
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text(
            "Notifications",
            style: Theme.of(context).textTheme.headline2,
          ),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: TabBarView(children: [
          ListView(
            children: [
              gacelaNotificationTile(
                isNew: true,
                title: "Obstacle",
                description:
                    "l’automobile N05 est bloqué dans le boulevard de HASSIBA Ben Bouali rue N16 ...",
                onTap: () {},
              ),
              gacelaNotificationTile(
                isNew: false,
                title: "Obstacle",
                description:
                    "l’automobile N05 est bloqué dans le boulevard de HASSIBA Ben Bouali rue N16 ...",
                onTap: () {},
              ),
              gacelaNotificationTile(
                isNew: false,
                title: "Obstacle",
                description:
                    "l’automobile N05 est bloqué dans le boulevard de HASSIBA Ben Bouali rue N16 ...",
                onTap: () {},
              ),
            ],
          ),
          ListView(
            children: [
              gacelaNotificationTile(
                title: "Obstacle",
                description:
                    "l’automobile N05 est bloqué dans le boulevard de HASSIBA Ben Bouali rue N16 ...",
                onTap: () {},
              ),
              gacelaNotificationTile(
                title: "Obstacle",
                description:
                    "l’automobile N05 est bloqué dans le boulevard de HASSIBA Ben Bouali rue N16 ...",
                onTap: () {},
              ),
              gacelaNotificationTile(
                title: "Obstacle",
                description:
                    "l’automobile N05 est bloqué dans le boulevard de HASSIBA Ben Bouali rue N16 ...",
                onTap: () {},
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
