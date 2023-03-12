import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AllReviewController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // STREAM REVIEW
  Stream<QuerySnapshot<Map<String, dynamic>>> streamReview({required String uid}) async* {
    yield* firestore.collection('service').doc(uid).collection('review').where('rating', isNotEqualTo: '0').snapshots();
  }
}
