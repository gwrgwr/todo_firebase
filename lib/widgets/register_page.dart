import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_firebase/services/firebase_auth.dart';
import 'package:todo_firebase/states/register_states.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({required this.pageController, super.key});

  final nomeController = TextEditingController();
  final emailController = TextEditingController();
  final userController = TextEditingController();
  final senhaController = TextEditingController();
  final PageController pageController;
  final myFirebaseAuth = MyFirebaseAuth();
  final firebaseAuth = FirebaseAuth.instance; 
  final controller = RegisterStates();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Registrar-se'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Seu nome',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            TextField(
              controller: nomeController,
              decoration: InputDecoration(
                  hintText: 'Nome',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  )),
            ),
            SizedBox(height: 10),
            Text(
              'Seu email',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: 'Email',
                suffixIcon: Icon(Icons.email_outlined),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Seu usuário',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            TextField(
              controller: userController,
              decoration: InputDecoration(
                  hintText: 'Usuário',
                  suffixIcon: Icon(Icons.person_outline),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  )),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Sua senha',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            ValueListenableBuilder(
              valueListenable: controller,
              builder: (context, value, child) {
                return TextField(
                  obscureText: value,
                  controller: senhaController,
                  decoration: InputDecoration(
                    hintText: 'Senha',
                    suffixIcon: IconButton(
                      onPressed: () {
                        controller.changeVisibility();
                      },
                      icon: value
                          ? const Icon(Icons.visibility)
                          : const Icon(Icons.visibility_off),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                  ),
                );
              },
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () async {
                  myFirebaseAuth.register(
                    email: emailController.text,
                    password: senhaController.text,
                    userName: userController.text,
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    'Registrar',
                    style: TextStyle(
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: TextButton(
                onPressed: () {
                  pageController.jumpToPage(0);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  child: Text(
                    'Já tem uma conta?',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
