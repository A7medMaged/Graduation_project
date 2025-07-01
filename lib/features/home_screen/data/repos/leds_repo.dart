import 'package:firebase_database/firebase_database.dart';

class LedsRepo {
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref();

  Stream<Map<String, dynamic>> getRooms() {
    return _dbRef.child('rooms').onValue.map((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>?;
      return {
        'room_one': data?['room_one'] ?? 0,
        'room_two': data?['room_two'] ?? 0,
        'temp_sensor': data?['temp_sensor'] ?? 0,
        'humidity': data?['humidity'] ?? 0,
      };
    });
  }

  Future<void> toggleLed(String room, int currentValue) async {
    await _dbRef.child('rooms').child(room).set(currentValue == 1 ? 0 : 1);
  }
}
