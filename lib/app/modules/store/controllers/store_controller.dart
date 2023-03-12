import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class StoreController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // GET NAME USER
  Stream<DocumentSnapshot<Map<String, dynamic>>> streamUser() async* {
    String uid = await auth.currentUser!.uid;

    yield* firestore.collection('user').doc(uid).snapshots();
  }

  // GET ALL USER
  Stream<QuerySnapshot<Map<String, dynamic>>> streamAllUser() async* {
    yield* firestore.collection('user').where('role', isEqualTo: 'ahli servis').snapshots();
  }
}
