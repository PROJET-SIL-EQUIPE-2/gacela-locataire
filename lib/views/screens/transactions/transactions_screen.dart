import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import '../../../config/theme/theme.dart';
import '../../../config/theme/colors.dart';

class TransactionsScreen extends StatelessWidget {
  static const route = "/";
  const TransactionsScreen({Key? key}) : super(key: key);

  Widget gacelaCard({
    required String image,
    required String carName,
    required DateTime date,
    required int duration,
    required int price,
  }) {
    String formattedDate = DateFormat("hh:mm | dd MMMM").format(date);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                clipBehavior: Clip.hardEdge,
                height: 60,
                width: 60,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(8)),
                child: Image.network(
                  image,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    carName,
                    style: const TextStyle(
                      color: GacelaColors.gacelaDeepBlue,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    formattedDate.toString(),
                    style: const TextStyle(
                      color: GacelaColors.gacelaGrey,
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.access_time,
                        size: 15,
                        color: GacelaColors.gacelaGrey,
                      ),
                      Text(
                        " $duration min",
                        style: const TextStyle(
                          color: GacelaColors.gacelaGrey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: GacelaColors.gacelaDeepBlue,
            ),
            child: Text(
              "$price DA",
              style: const TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "Historique",
          style: Theme.of(context).textTheme.headline2,
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.notifications_none_rounded,
                color: Colors.black,
                size: 30,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: GacelaTheme.hPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Center(
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.transparent,
                  backgroundImage: NetworkImage("https://i.pravatar.cc/300"),
                ),
              ),
              const SizedBox(height: GacelaTheme.vDivider),
              Text("User name", style: Theme.of(context).textTheme.headline3),
              Text("Lieu", style: Theme.of(context).textTheme.headline4),
              const SizedBox(height: GacelaTheme.vDivider),
              Text("Transactions",
                  style: Theme.of(context)
                      .textTheme
                      .headline2!
                      .copyWith(color: GacelaColors.gacelaDeepBlue)),
              const SizedBox(height: GacelaTheme.vDivider),
              gacelaCard(
                  image: "http://via.placeholder.com/640x360",
                  carName: "Hyundai Accent",
                  date: DateTime(2022, 3, 10, 10, 48),
                  duration: 40,
                  price: 40),
              gacelaCard(
                  image: "http://via.placeholder.com/640x360",
                  carName: "Hyundai Accent",
                  date: DateTime(2022, 3, 10, 10, 48),
                  duration: 40,
                  price: 40),
              gacelaCard(
                  image: "http://via.placeholder.com/640x360",
                  carName: "Hyundai Accent",
                  date: DateTime(2022, 3, 10, 10, 48),
                  duration: 40,
                  price: 40),
              gacelaCard(
                  image: "http://via.placeholder.com/640x360",
                  carName: "Hyundai Accent",
                  date: DateTime(2022, 3, 10, 10, 48),
                  duration: 40,
                  price: 40),
              gacelaCard(
                  image: "http://via.placeholder.com/640x360",
                  carName: "Hyundai Accent",
                  date: DateTime(2022, 3, 10, 10, 48),
                  duration: 40,
                  price: 40),
              gacelaCard(
                  image: "http://via.placeholder.com/640x360",
                  carName: "Hyundai Accent",
                  date: DateTime(2022, 3, 10, 10, 48),
                  duration: 40,
                  price: 40),
              gacelaCard(
                  image: "http://via.placeholder.com/640x360",
                  carName: "Hyundai Accent",
                  date: DateTime(2022, 3, 10, 10, 48),
                  duration: 40,
                  price: 40),
            ],
          ),
        ),
      ),
    );
  }
}
