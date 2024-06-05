import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:todo_firebase/bloc/todo_bloc.dart';
import 'package:todo_firebase/components/splash_screen.dart';
import 'package:todo_firebase/services/firebase_auth.dart';
import 'package:todo_firebase/services/firebase_data.dart';
import 'package:todo_firebase/views/home_page.dart';
import 'package:todo_firebase/views/insert_page.dart';

class MyPageView extends StatelessWidget {
  MyPageView({super.key});

  final myFirebaseAuth = MyFirebaseAuth();
  final firebaseAuth = FirebaseAuth.instance;
  final bloc = TodoBloc(GetIt.instance.get<FirebaseData>());
  final pageController = PageController();
  final taskNameControllerGlobal = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: firebaseAuth.userChanges(),
      builder: (context, snapshot) {
        if (snapshot.data?.displayName != null) {
          return Scaffold(
            drawer: Drawer(
              child: TextButton(
                onPressed: () {
                  myFirebaseAuth.logout();
                },
                child: const Text(
                  'Sair',
                ),
              ),
            ),
            appBar: AppBar(title: Text('Olá ${snapshot.data!.displayName}')),
            body: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: pageController,
              children: [
                HomePage(pageController: pageController, taskNameControllerGlobal: taskNameControllerGlobal),
                InsertPage(pageController: pageController, taskNameControllerGlobal:taskNameControllerGlobal ),
              ],
            ),
          );
        } else {
          Future.delayed(const Duration(seconds: 2));
          return const SplashScreen();
        }
      },
    );
  }
}
