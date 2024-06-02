import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_firebase/services/firebase_auth.dart';
import 'package:todo_firebase/views/home_page.dart';

class MyPageView extends StatelessWidget {
  MyPageView({super.key});

  final myFirebaseAuth = MyFirebaseAuth();
  final firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: TextButton(
          onPressed: () {
            myFirebaseAuth.logout();
          },
          child: Text(
            'Sair',
          ),
        ),
      ),
      appBar: AppBar(
        title: StreamBuilder<User?>(
          stream: firebaseAuth.userChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text("Olá, ${snapshot.data!.displayName}");
            } else {
              return Text('Loading');
            }
          },
        ),
      ),
      body: PageView(
        children: [
          HomePage(),
        ],
      ),
    );
  }
}
