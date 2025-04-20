import 'package:firebase_database/firebase_database.dart';

class SensorsRepo {
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref();

  // Stream for kitchen sensors
  Stream<Map<String, int>> getKitchenSensors() {
    return _dbRef.child('kitchen').onValue.map((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>?;
      return {
        'flame_sensor': data?['flame_sensor'] ?? 0,
        'gas_sensor': data?['gas_sensor'] ?? 0,
      };
    });
  }
}
