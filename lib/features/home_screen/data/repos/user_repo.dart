import 'package:cloud_firestore/cloud_firestore.dart';

class UserRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Map<String, dynamic>> getUserDetails(String uid) async {
    DocumentSnapshot doc = await _firestore.collection('users').doc(uid).get();
    return doc.data() as Map<String, dynamic>;
  }
}
