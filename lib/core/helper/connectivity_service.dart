import 'dart:async';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class ConnectivityService {
  ConnectivityService._();
  static final ConnectivityService instance = ConnectivityService._();

  final _controller = StreamController<InternetStatus>.broadcast();

  Stream<InternetStatus> get stream => _controller.stream;

  void initialize() {
    InternetConnection().hasInternetAccess.then((value) {
      _controller.add(
        value ? InternetStatus.connected : InternetStatus.disconnected,
      );
    });

    InternetConnection().onStatusChange.listen(
      (status) => _controller.add(status),
    );
  }

  void dispose() => _controller.close();
}
