import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:todo_firebase/bloc/todo_bloc.dart';
import 'package:todo_firebase/injections/get_inject.dart';
import 'package:todo_firebase/services/firebase_data.dart';
import 'package:todo_firebase/themes/theme.dart';
import 'package:todo_firebase/views/connect_page.dart';
import 'package:todo_firebase/views/page_view.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoBloc(GetIt.instance.get<FirebaseData>()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: const MaterialTheme(TextTheme()).dark(),
        home: const Route(),
      ),
    );
  }
}

class Route extends StatelessWidget {
  const Route({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return MyPageView();
        } else {
          return ConnectPage();
        }
      },
    );
  }
}
