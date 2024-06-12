import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  final Connectivity _connectivity = Connectivity();

  Future<bool> checkConnectivity() async {
    var connectivityResult = await _connectivity.checkConnectivity();
    print("Connectivity result: $connectivityResult");
    if (connectivityResult == ConnectivityResult.none) {
      return false;
    }
    return true;
  }
}
