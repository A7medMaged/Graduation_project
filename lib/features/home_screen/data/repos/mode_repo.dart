import 'package:firebase_database/firebase_database.dart';

class ModeRepo {
  final _database = FirebaseDatabase.instance.ref();

  Stream<bool?> streamR() {
    return _database
        .child('Mode/Automatic')
        .onValue
        .map((event) => event.snapshot.value == true);
  }

  Future<void> setR(bool value) {
    return _database.child('Mode/Automatic').set(value);
  }
}
