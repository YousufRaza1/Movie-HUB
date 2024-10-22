import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

enum NetworkStatus { Online, Offline, Wifi, Cellular }

class NetworkStatusController extends GetxController {
  var networkStatus = NetworkStatus.Offline.obs; // Initially set to offline
  final Connectivity _connectivity = Connectivity();

  @override
  void onInit() {
    super.onInit();
    // Start listening to connectivity changes when controller is initialized
    _connectivity.onConnectivityChanged.listen((List<ConnectivityResult> results) {
      // Since the results is a list, you can handle multiple results here
      // In this case, we will only take the first one for simplicity
      if (results.isNotEmpty) {
        _updateNetworkStatus(results.first);
      }
    });
    // Check the initial network status when the app starts
    _checkInitialConnection();
  }

  // Method to update the network status based on the connectivity result
  void _updateNetworkStatus(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.wifi:
        networkStatus.value = NetworkStatus.Online;
        break;
      case ConnectivityResult.mobile:
        networkStatus.value = NetworkStatus.Online;
        break;
      case ConnectivityResult.none:
      default:
        networkStatus.value = NetworkStatus.Offline;
        break;
    }
  }

  // Method to check the initial connection when the app starts
  Future<void> _checkInitialConnection() async {
    // Assuming the new API returns a List<ConnectivityResult>
    List<ConnectivityResult> results = await _connectivity.checkConnectivity();

    if (results.isNotEmpty) {
      // Use the first connectivity result for the update
      _updateNetworkStatus(results.first);
    } else {
      // Handle the case where there is no connectivity result
      _updateNetworkStatus(ConnectivityResult.none);
    }
  }
}
