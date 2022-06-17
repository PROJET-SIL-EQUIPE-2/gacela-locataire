import 'dart:convert';
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

import '../models/errors/failure.dart';

class PaymentController {
  Map<String, dynamic>? paymentIntentData;

  Future<void> makePayment(
      {required String amount,
      required String currency,
      required int? reservationId}) async {
    try {
      paymentIntentData = await createPaymentIntent(amount, currency);
      print(paymentIntentData);
      if (paymentIntentData != null) {
        await Stripe.instance.initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(
          applePay: true,
          googlePay: true,
          testEnv: true,
          merchantCountryCode: 'US',
          merchantDisplayName: 'Prospects',
          customerId: paymentIntentData!['customer'],
          paymentIntentClientSecret: paymentIntentData!['client_secret'],
          customerEphemeralKeySecret: paymentIntentData!['ephemeralKey'],
        ));
        displayPaymentSheet(reservationId, amount);
      }
    } catch (e, s) {
      print('exception:$e$s');
    }
  }

  displayPaymentSheet(int? reservationId, String amount) async {
    try {
      await Stripe.instance.presentPaymentSheet();
      // the payment succeded
      // TODO: Make the request to gacela backend
      await pushPaymentDetails(reservationId, amount);
    } on Exception catch (e) {
      if (e is StripeException) {
        print("Error from Stripe: ${e.error.localizedMessage}");
      } else {
        print("Unforeseen error: $e");
      }
    } catch (e) {
      print("exception:$e");
    }
  }

  //  Future<Map<String, dynamic>>
  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card'
      };
      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization':
                'Bearer sk_test_51KsztUAm2rpPIPmYy44ckRuf1RDONq0j1x9hqzMSWL57CavJTBECOb8Hs0W8PUrdqMm3OgoHZUtMPOIdCzrcMnmR00bT2NiEb4',
            'Content-Type': 'application/x-www-form-urlencoded'
          });
      return jsonDecode(response.body);
    } catch (err) {
      print('err charging user: ${err.toString()}');
    }
  }

  calculateAmount(String amount) {
    final a = (int.parse(amount)) * 100;
    return a.toString();
  }

  Future<void> pushPaymentDetails(int? reservationId, String? amount) async {
    final String url = '${dotenv.get("BASE_URL")}/payment/checkout';
    try {
      final response = await http.post(Uri.parse(url),
          headers: {
            "Content-Type": "application/json",
          },
          body: jsonEncode({
            "reservation_id": reservationId,
            "amount": amount,
          }));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return;
      } else {
        final data = jsonDecode(response.body);
        throw Failure(data["errors"][0]["msg"], code: response.statusCode);
      }
    } on SocketException {
      throw Failure('No Internet connection 😑');
    } on HttpException {
      throw Failure("Couldn't find the post 😱");
    } on FormatException {
      throw Failure("Bad response format 👎");
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
