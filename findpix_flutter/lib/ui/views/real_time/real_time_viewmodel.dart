import 'package:findpix_flutter/models/boundary.dart';
import 'package:findpix_flutter/services/firestore_service.dart';
import 'package:stacked/stacked.dart';

import '../../../app/app.locator.dart';
import '../../../models/device.dart';
import '../../../services/database_service.dart';

class RealTimeViewModel extends ReactiveViewModel {

  final _databaseService = locator<DatabaseService>();
  final _firestoreServce = locator<FirestoreService>();

  DeviceReading? get node => _databaseService.node;

  @override
  List<ListenableServiceMixin> get listenableServices =>
      [_databaseService];

 void updateBoundary(Boundary boundary){
   _firestoreServce.addBoundaryToFirestore(Boundary(
     id: 'boundary',
     name: boundary.name,
     startDateTime: boundary.startDateTime,
     endDateTime: boundary.endDateTime,
     kilometer: boundary.kilometer,
     currentLat: node!.lat,
     currentLong: node!.long,
   ));
 }
}
