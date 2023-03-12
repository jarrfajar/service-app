import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AllCategoryController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // GET CATEGORY
  Stream<QuerySnapshot<Map<String, dynamic>>> streamCategory() async* {
    yield* firestore.collection('category').snapshots();
  }
}
