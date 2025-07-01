import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterRepo {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<void> register(
    String email,
    String password,
    String name,
    String phone,
    String role,
    int buildingNo,
    int apartmentNo,
  ) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'email': email,
        'name': name,
        'phone': phone,
        'role': role,
        'id': userCredential.user!.uid,
        'buildingNo': buildingNo,
        'apartmentNo': apartmentNo,
        'registerTime': DateTime.now(),
      });

      await userCredential.user!.sendEmailVerification();
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
