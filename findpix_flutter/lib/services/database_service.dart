import 'package:findpix_flutter/models/notification.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
// import 'package:geolocator/geolocator.dart';

import '../app/app.locator.dart';
import '../app/app.logger.dart';
import '../models/device.dart';
import 'package:firebase_database/firebase_database.dart';

import 'firestore_service.dart';

const dbCode = "KrPN4ntcsKSSFFw3M2zgzIh0pXT2";

class DatabaseService with ListenableServiceMixin {
  final log = getLogger('RealTimeDB_Service');
  final _snackbarService = locator<SnackbarService>();
  final _firestoreService = locator<FirestoreService>();


  final FirebaseDatabase _db = FirebaseDatabase.instance;

  DeviceReading? _node;
  DeviceReading? get node => _node;


  void setupNodeListening() {
    log.i("Setting up..");
    DatabaseReference starCountRef =
        _db.ref('/devices/$dbCode/reading');
    log.i("R ${starCountRef.key}");
    try {
      starCountRef.onValue.listen((DatabaseEvent event) {
        log.i("Reading..");
        if (event.snapshot.exists) {
          _node = DeviceReading.fromMap(event.snapshot.value as Map);
          log.v(_node?.lastSeen); //data['time']
          if(node!=null){
            if(node!.sos) {
              createNotification("SOS", "Sos alert clicked on: ${DateTime.now().toIso8601String()}");
              showNotification("SOS ALERT!");
            }
            // Coordinate coord1 = Coordinate(52.5200, 13.4050); // Berlin, Germany
            // Coordinate coord2 = Coordinate(48.8566, 2.3522); // Paris, France
            //
            // double distance = calculateDistance(coord1, coord2)

            //
          }
          notifyListeners();
        }
      });
    } catch (e) {
      log.e("Error: $e");
    }
  }

  void createNotification(String title, String content) async {
    String? notId = await _firestoreService.generateNotificationId();
    if(notId!=null) {
      _firestoreService.addNotificationToFirestore(AppNotification(title: title, description: content, time: DateTime.now(), id: notId,),);
    }
  }


  void showNotification(String message){
    _snackbarService.showSnackbar(message: message, title: "Notification");
  }
}


