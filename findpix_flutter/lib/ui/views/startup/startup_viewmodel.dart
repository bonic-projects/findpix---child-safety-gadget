import 'package:findpix_flutter/services/database_service.dart';
import 'package:stacked/stacked.dart';
import 'package:findpix_flutter/app/app.locator.dart';
import 'package:findpix_flutter/app/app.router.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.logger.dart';
import '../../../services/user_service.dart';

class StartupViewModel extends BaseViewModel {
  final log = getLogger('StartupViewModel');
  final _navigationService = locator<NavigationService>();
  final _userService = locator<UserService>();
  final _databaseService = locator<DatabaseService>();

  // Place anything here that needs to happen before we get into the application
  Future runStartupLogic() async {
    log.i("Setting up..");
    _databaseService.setupNodeListening();
    if (_userService.hasLoggedInUser) {
      await _userService.fetchUser();
      _navigationService.replaceWithHomeView();
    } else {
      await Future.delayed(const Duration(seconds: 1));
      _navigationService.replaceWithLoginRegisterView();
    }
  }
}
