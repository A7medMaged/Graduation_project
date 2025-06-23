import 'package:firebase_database/firebase_database.dart';

class BrightnessRepo {
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref(
    'outing/brightness',
  );

  Stream<double> getBrightnessStream() {
    return _dbRef.onValue.map((event) {
      final data = event.snapshot.value;
      return double.tryParse(data.toString()) ?? 0;
    });
  }

  Future<void> setBrightness(double value) async {
    await _dbRef.set(value.toInt());
  }
}
