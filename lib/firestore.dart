import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';


void addUser(String email, String pass) async {
  CollectionReference collectionReference = FirebaseFirestore.instance.collection('user_creds');
  collectionReference.add({
    'email': email,
    'password': pass
  });
}

Future<String?> getUser() async {
  CollectionReference collectionReference = FirebaseFirestore.instance.collection('user_creds');
  QuerySnapshot querySnapshot = await collectionReference.get();
}