import 'package:findpix_flutter/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:findpix_flutter/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:findpix_flutter/ui/views/home/home_view.dart';
import 'package:findpix_flutter/ui/views/startup/startup_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:stacked_firebase_auth/stacked_firebase_auth.dart';

import '../services/firestore_service.dart';
import '../services/user_service.dart';
import '../ui/bottom_sheets/alert/alert_sheet.dart';
import '../ui/bottom_sheets/success/success_sheet.dart';
import '../ui/views/login/login_view.dart';
import '../ui/views/login_register/login_register_view.dart';
import '../ui/views/register/register_view.dart';
// @stacked-import

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView),
    MaterialRoute(page: StartupView),
    // @stacked-route
    MaterialRoute(page: LoginRegisterView),
    MaterialRoute(page: LoginView),
    MaterialRoute(page: RegisterView),
  ],
  dependencies: [
    LazySingleton(classType: SnackbarService),
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    // @stacked-service
    LazySingleton(classType: FirebaseAuthenticationService),
    LazySingleton(classType: FirestoreService),
    LazySingleton(classType: UserService),
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
    StackedBottomsheet(classType: AlertSheet),
    StackedBottomsheet(classType: SuccessSheet), // @stacked-bottom-sheet
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
    // @stacked-dialog
  ],
  logger: StackedLogger(),
)
class App {}
