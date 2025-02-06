import 'package:cloud_firestore/cloud_firestore.dart';

class FireBaseApi {
  //insert
  static dynamic insert(String collection, dynamic body) async {
    var db = FirebaseFirestore.instance;
    var res = await db.collection(collection).add(body);
    return res;
  }

  //Get By Field
  static dynamic getByField(
      String collectionName, String field, String value) async {
    var db = FirebaseFirestore.instance;
    var querySnapshot = await db
        .collection(collectionName)
        .where(field, isEqualTo: value)
        .get();
    return  querySnapshot.docs;
  }

  //Get Data
  static dynamic get(String collectionName) async {
    var db = FirebaseFirestore.instance;
    var querySnapshot = await db.collection(collectionName).get();
    return querySnapshot.docs;
  }

  //Update data by Field
  static dynamic updateByField(String collectionName, dynamic data ,String docId) async {
    var db = FirebaseFirestore.instance;
    var querySnapShot =
        await db.collection(collectionName).doc(docId).update(data);
    return querySnapShot;
  }

  //Update data by Field
  static Future<bool> deleteDocument(String collectionName, String docId) async {
    try {
      var db = FirebaseFirestore.instance;
      await db.collection(collectionName).doc(docId).delete();
      return true;
    } catch (err) {
      print(err);
      return false;
    }
  }
}
