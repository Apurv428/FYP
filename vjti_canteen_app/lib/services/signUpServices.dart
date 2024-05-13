import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:food_order_app/screen/auth/login_page.dart';
import 'package:get/get.dart';

signUpUser(String userName, String regId, String userEmail, String userPassword,
    BuildContext context) async {
  User? userid = FirebaseAuth.instance.currentUser;

  try {
    await FirebaseFirestore.instance.collection("users").doc(userid!.uid).set({
      'username': userName,
      'regId': regId,
      'userEmail': userEmail,
      'roll': "user",
      'createdAt': DateTime.now(),
      'userId': userid!.uid,
    }).then((value) =>
        {FirebaseAuth.instance.signOut(), Get.to(() => LoginPage())});
  } on FirebaseAuthException catch (e) {
    print("Error $e");
  }
}
