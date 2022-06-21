import 'package:flutter/material.dart';
import 'package:gacela_locataire/providers/auth_provider.dart';
import 'package:gacela_locataire/providers/course_provider.dart';
import 'package:provider/provider.dart';
import '../../../config/theme/colors.dart';
import '../../widgets.dart';

class NotificationsScreen extends StatefulWidget {
  static const route = "/notifications";
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<CourseProvider>(context, listen: false).getSupportReply(
        Provider.of<AuthProvider>(context, listen: false).user?.id);
  }

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
          Consumer<CourseProvider>(
            builder: (context, courseProvider, child) => ListView(
              children: courseProvider.replies
                  .map(
                    (reply) => gacelaNotificationTile(
                      isNew: true,
                      title: "${reply.typeSupport}",
                      description: "${reply.supportMessage}",
                      reply: "${reply.reply}",
                      date: reply.date,
                      onTap: () {},
                    ),
                  )
                  .toList(),
            ),
          ),
          Consumer<CourseProvider>(
            builder: (context, courseProvider, child) => ListView(
              children: courseProvider.replies
                  .map(
                    (reply) => gacelaNotificationTile(
                      isNew: true,
                      title: "${reply.typeSupport}",
                      description: "${reply.supportMessage}",
                      reply: "${reply.reply}",
                      date: reply.date,
                      onTap: () {},
                    ),
                  )
                  .toList(),
            ),
          ),
        ]),
      ),
    );
  }
}
