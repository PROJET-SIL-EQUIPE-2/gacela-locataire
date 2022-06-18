import 'package:flutter/material.dart';
import 'package:gacela_locataire/providers/auth_provider.dart';
import 'package:gacela_locataire/providers/course_provider.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../config/theme/theme.dart';
import '../../../config/theme/colors.dart';

class TransactionsScreen extends StatefulWidget {
  static const route = "/";
  const TransactionsScreen({Key? key}) : super(key: key);

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<AuthProvider>(context, listen: false).getTransactions();
  }

  Widget gacelaCard({
    required String image,
    required String carName,
    required DateTime date,
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
      body: Consumer<AuthProvider>(
        builder: (_, auth, __) => SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: GacelaTheme.hPadding),
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
                Text("${auth.user?.familyName} ${auth.user?.name}",
                    style: Theme.of(context).textTheme.headline3),
                Text("${auth.user?.email}",
                    style: Theme.of(context).textTheme.headline4),
                const SizedBox(height: GacelaTheme.vDivider),
                Text("Transactions",
                    style: Theme.of(context)
                        .textTheme
                        .headline2!
                        .copyWith(color: GacelaColors.gacelaDeepBlue)),
                const SizedBox(height: GacelaTheme.vDivider),
                Consumer<AuthProvider>(builder: (context, provider, _) {
                  return provider.transactionsList.isEmpty
                      ? const Center(child: Text("No transaction found"))
                      : Column(
                          children: provider.transactionsList
                              .map(
                                (trans) => gacelaCard(
                                    image: "http://via.placeholder.com/640x360",
                                    carName: "Gacela Car",
                                    date: trans.dateReservation!.toUtc(),
                                    price: 40),
                              )
                              .toList(),
                        );
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
