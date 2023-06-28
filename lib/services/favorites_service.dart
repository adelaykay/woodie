import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:Woodie/components/media_card.dart';
import 'package:Woodie/model/media.dart';

class FavoritesService {
  static Future<List<Media>> getData() async {
    List<Media> faves = [];
    await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: FirebaseAuth.instance.currentUser!.email!)
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.forEach((doc) {
                doc['favorites']!.forEach((media) {
                  faves.add(Media(
                      id: media['id'] as int,
                      rating: media['rating'] as double,
                      title: media['title'] as String,
                      poster: media['poster'] == null
                          ? ''
                          : media['poster'] as String,
                      backdrop: media['backdrop'] as String,
                      year: media['year'] as String,
                      mediaType: media['mediaType'] as String));
                });
              })
            }).catchError((e)=>debugPrint('failed to retrieve data: $e'));

    print('done');
    return faves;
  }

  static Future<void> updateUser(String? title, double? rating, int? id,
      String? year, String? poster, String? backdrop, String mediaType) {
    // Create a CollectionReference called users that references the firestore collection
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    // Call the user's CollectionReference to update the document
    return users
        .where('email', isEqualTo: FirebaseAuth.instance.currentUser!.email)
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.forEach((doc) {
                var favorites = doc['favorites'];
                favorites.add({
                  'title': title,
                  'rating': rating,
                  'id': id,
                  'year': year,
                  'poster': poster,
                  'backdrop': backdrop,
                  'mediaType': mediaType
                });
                print(favorites);
                users.doc(doc.id).update({'favorites': favorites});
              })
            })
        .catchError((error) => print("Failed to add user: $error"));
  }
}
