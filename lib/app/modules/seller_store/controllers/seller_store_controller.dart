import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SellerStoreController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // GET NAME USER
  Stream<DocumentSnapshot<Map<String, dynamic>>> streamUser(uid) async* {
    yield* firestore.collection('user').doc(uid).snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> streamPesanan(uid) async* {
    yield* firestore.collection('booking').where('penjualID', isEqualTo: uid).snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> streamJasa(uid) async* {
    yield* firestore.collection('service').where('userID', isEqualTo: uid).snapshots();
  }
}
