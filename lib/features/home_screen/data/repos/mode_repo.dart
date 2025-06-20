import 'package:firebase_database/firebase_database.dart';

class ModeRepository {
  final _database = FirebaseDatabase.instance.ref();

  Stream<bool?> streamR1() {
    return _database.child('Mode/Automatic_r1').onValue.map(
          (event) => event.snapshot.value == true,
        );
  }

  Stream<bool?> streamR2() {
    return _database.child('Mode/Automatic_r2').onValue.map(
          (event) => event.snapshot.value == true,
        );
  }

  Future<void> setR1(bool value) {
    return _database.child('Mode/Automatic_r1').set(value);
  }

  Future<void> setR2(bool value) {
    return _database.child('Mode/Automatic_r2').set(value);
  }
}
