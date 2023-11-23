import 'package:stacked/stacked.dart';
import 'package:findpix_flutter/app/app.locator.dart';
import 'package:findpix_flutter/app/app.router.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../services/user_service.dart';

class StartupViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _userService = locator<UserService>();

  // Place anything here that needs to happen before we get into the application
  Future runStartupLogic() async {
    if (_userService.hasLoggedInUser) {
      await _userService.fetchUser();
      _navigationService.replaceWithHomeView();
    } else {
      await Future.delayed(const Duration(seconds: 1));
      _navigationService.replaceWithLoginRegisterView();
    }
  }
}
