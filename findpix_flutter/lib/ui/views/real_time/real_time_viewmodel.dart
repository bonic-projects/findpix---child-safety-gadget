import 'package:stacked/stacked.dart';

import '../../../app/app.locator.dart';
import '../../../models/device.dart';
import '../../../services/database_service.dart';

class RealTimeViewModel extends ReactiveViewModel {

  final _databaseService = locator<DatabaseService>();

  DeviceReading? get node => _databaseService.node;

  @override
  List<ListenableServiceMixin> get listenableServices =>
      [_databaseService];
}
