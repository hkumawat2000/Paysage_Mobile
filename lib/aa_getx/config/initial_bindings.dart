import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

import '../core/utils/connection_info.dart';

class InitialBinding implements Bindings {

  @override
  void dependencies() {

    /// Connectivity
    final Connectivity connectivity = Connectivity();
    Get.lazyPut<ConnectionInfo>(
          () => ConnectionInfoImpl(connectivity),
      fenix: true,
    );


  }

}