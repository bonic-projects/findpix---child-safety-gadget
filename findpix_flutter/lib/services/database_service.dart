import 'package:stacked/stacked.dart';

import '../app/app.logger.dart';
import '../models/device.dart';
import 'package:firebase_database/firebase_database.dart';

const dbCode = "KrPN4ntcsKSSFFw3M2zgzIh0pXT2";

class DatabaseService with ListenableServiceMixin {
  final log = getLogger('RealTimeDB_Service');

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
          notifyListeners();
        }
      });
    } catch (e) {
      log.e("Error: $e");
    }
  }

}
