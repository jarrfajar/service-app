import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:get/get.dart';
import 'package:readmore/readmore.dart';

import '../controllers/all_review_controller.dart';

class AllReviewView extends GetView<AllReviewController> {
  final uid = Get.arguments;

  Widget build(BuildContext context) {
    // print(uid);
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        title: const Text(
          'Review Product',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: controller.streamReview(uid: uid),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
            }
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  // physics: const NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> review = snapshot.data!.docs[index].data();

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          review['name'],
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        RatingBar.builder(
                          ignoreGestures: true,
                          initialRating: double.parse(review['rating']),
                          direction: Axis.horizontal,
                          itemCount: 5,
                          itemSize: 22,
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {},
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        (review['rating'] == ''
                            ? Container()
                            : ReadMoreText(
                                review['deskripsi'] != '' ? review['deskripsi'] : '-',
                                trimLines: 4,
                                colorClickableText: Colors.pink,
                                trimMode: TrimMode.Line,
                                trimCollapsedText: 'Show more',
                                trimExpandedText: 'Show less',
                                moreStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                lessStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                style: const TextStyle(fontSize: 16.0),
                              )),
                        const SizedBox(
                          height: 20.0,
                        ),
                      ],
                    );
                  },
                ),
              ),
            );
          }),
    );
  }
}
