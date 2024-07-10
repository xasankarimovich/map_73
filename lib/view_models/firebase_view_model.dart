import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../data/models/place_model.dart';

class FirebaseViewModel extends ChangeNotifier {
  bool isLoading = false;

  Stream<List<PlaceModel>> getAllPlaceModel() =>
      FirebaseFirestore.instance.collection("categories").snapshots().map(
            (event) =>
                event.docs.map((e) => PlaceModel.fromJson(e.data())).toList(),
          );

  Future<void> insertPlaceModel(
      PlaceModel placeModel, BuildContext context) async {
    try {
      _notify(true);
      var collectionReference =
          await FirebaseFirestore.instance.collection('categories').add(
                placeModel.toJson(),
              );

      await FirebaseFirestore.instance
          .collection('categories')
          .doc(collectionReference.id)
          .update(
        {"id": collectionReference.id},
      );

      _notify(false);
    } on FirebaseException catch (error) {
      throw ExactAssetImage(error.toString());
    }
  }

  Future<void> updateCategory(
      PlaceModel placeModel, BuildContext context) async {
    try {
      _notify(true);
      await FirebaseFirestore.instance
          .collection('categories')
          .doc(placeModel.id)
          .update(
            placeModel.toUpdateJson(),
          );

      _notify(false);
    } on FirebaseException catch (error) {
      throw ExactAssetImage(error.toString());
    }
  }

  Future<void> deleteCategory(String docId, BuildContext context) async {
    try {
      _notify(true);

      await FirebaseFirestore.instance
          .collection('categories')
          .doc(docId)
          .delete();

      _notify(false);
    } on FirebaseException catch (error) {
      throw ExactAssetImage(error.toString());
    }
  }

  _notify(bool value) {
    isLoading = value;
    notifyListeners();
  }
}
