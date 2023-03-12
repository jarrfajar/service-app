import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // SEARCH
  List<QueryDocumentSnapshot<Map<String, dynamic>>> semuaPemain = [];

  Rx<List<QueryDocumentSnapshot<Map<String, dynamic>>>> cariPemain =
      Rx<List<QueryDocumentSnapshot<Map<String, dynamic>>>>([]);

  @override
  void onInit() async {
    super.onInit();
    await firestore
        .collection('service')
        .where('userID', isNotEqualTo: auth.currentUser!.uid)
        .get()
        .then((value) => semuaPemain = value.docs);
    cariPemain.value = semuaPemain;
  }

  void filterPlayer(String playerName) {
    List<QueryDocumentSnapshot<Map<String, dynamic>>> hasil = [];
    // List<QueryDocumentSnapshot<Map<String, dynamic>>> cari = [];

    if (playerName.isEmpty) {
      hasil = semuaPemain;
    } else {
      // hasil = semuaPemain
      //     .where((element) => element['name'].toString().toLowerCase().contains(playerName.toLowerCase()))
      //     .toList();
      hasil = semuaPemain
          .where((element) =>
              element['name'].toString().toLowerCase().contains(playerName.toLowerCase()) ||
              element['namaPenjual'].toString().toLowerCase().contains(playerName.toLowerCase()))
          .toList();
    }
    cariPemain.value = hasil;
  }

  // GET NAME USER
  Stream<DocumentSnapshot<Map<String, dynamic>>> streamUser() async* {
    String uid = await auth.currentUser!.uid;
    print(uid);

    yield* firestore.collection('user').doc(uid).snapshots();
  }

  // GET CATEGORY
  Stream<QuerySnapshot<Map<String, dynamic>>> streamCategory() async* {
    yield* firestore.collection('category').snapshots();
  }

  // GET SERVICE
  Stream<QuerySnapshot<Map<String, dynamic>>> streamService() async* {
    yield* firestore.collection('service').orderBy('createAt', descending: true).snapshots();
  }
}
