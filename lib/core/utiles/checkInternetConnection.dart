import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:learning_app/core/utiles/helper.dart';

class Checkinternetconnection {
  factory Checkinternetconnection() {
    return _instance;
  }
  Checkinternetconnection._internal();
  static final Checkinternetconnection _instance =
      Checkinternetconnection._internal();
  checkInternetConnection() async {
    InternetConnection().onStatusChange.listen((InternetStatus status) {
      switch (status) {
        case InternetStatus.disconnected:
          Helper.FlutterToast(title: 'No Internet Connection', success: false);
          break;
        case InternetStatus.connected:
          Helper.FlutterToast(
            title: 'The internet is now connected',
            success: true,
          );

          break;
      }
    });
  }
}
