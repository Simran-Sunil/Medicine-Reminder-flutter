import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class CrudMethods {
  Future<void> addData(regData) async {
    Firestore.instance.collection("details").add(regData).catchError((e) {
      print(e);
    });
  }

  getData() async {
    final FirebaseUser user= await FirebaseAuth.instance.currentUser();
    final uid=user.uid;
    return await Firestore.instance.collection("details").where('uid',isEqualTo:uid).snapshots();
  }

  uploadUserInfo(userMap) async{
    await Firestore.instance.collection("users").add(userMap).catchError((e){    //1
      print(e.toString());
    });
  }

getUserFromDocId({String docId}) async {
    var data = await Firestore.instance.collection("details").document(docId).get();
    return data.data['name'];
  }

  deleteData(docId) {
    Firestore.instance
    .collection('details')
    .document(docId)
    .delete()
    .catchError((e) {
      print(e);
    });
  }
}

