import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class CarsDataCollector with ChangeNotifier {
  late IO.Socket socket;

  double? lat = 0;
  double? long = 0;
  String? matricule;

  GoogleMapController? controller;

  void connect(int? locataireId, int? carId) {
    final url = dotenv.get("COLLECTOR_URL");
    socket = IO.io(url, <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false
    });

    socket.connect();
    socket.onConnect((_) {
      print('\n\nconnected\n\n');
    });

    socket.emit("join", "locataire_$locataireId#car_$carId");

    socket.on("fetch_car_data", (data) {
      print("$data");
      if (data != null) {
        lat = double.tryParse(data["lat"].toString()) ?? 0;
        long = double.tryParse(data["long"].toString()) ?? 0;
        matricule = data["matricule"];
        if (controller != null) {
          controller!.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                target: LatLng(lat!, long!),
                zoom: 14,
              ),
            ),
          );
        }
        notifyListeners();
      }
    });
  }

  void disconnect() {
    socket.dispose();
    controller?.dispose();
  }
}
