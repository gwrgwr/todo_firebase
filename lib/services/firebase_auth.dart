import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

class MyFirebaseAuth {
  final auth = FirebaseAuth.instance;

  Future register(
      {required String email,
      required String password,
      required String userName}) async {
    UserCredential userCredenial = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    User? user = auth.currentUser;

    if (user != null) {
      await user.updateDisplayName(userName);
      await user.reload();
    }
    final users = FirebaseFirestore.instance.collection('users');

    await users.doc(auth.currentUser!.uid).set({});
  }

  Future login({required String email, required String password}) async {
    UserCredential userCredential =
        await auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future logout() async {
    await auth.signOut();
  }
}
