import 'package:flutter/material.dart';
import 'package:todo_firebase/services/firebase_auth.dart';
import 'package:todo_firebase/states/login_states.dart';

class LoginPage extends StatelessWidget {
  LoginPage({required this.pageController, super.key});

  final emailTextController = TextEditingController();
  final senhaTextController = TextEditingController();
  final PageController pageController;
  MyFirebaseAuth myFirebaseAuth = MyFirebaseAuth();
  final controller = LoginStates();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Conectar-se'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Insira seu email',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            TextField(
              controller: emailTextController,
              decoration: InputDecoration(
                  hintText: 'Email',
                  suffixIcon: const Icon(Icons.person_outline),
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
            const SizedBox(height: 20),
            const Text(
              'Insira sua senha',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            ValueListenableBuilder(
              valueListenable: controller,
              builder: (context, value, child) {
                return TextField(
                  controller: senhaTextController,
                  obscureText: value,
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
                onPressed: () {
                  myFirebaseAuth.login(
                    email: emailTextController.text,
                    password: senhaTextController.text,
                  );
                  
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Funfou')));
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  child: Text(
                    'Entrar',
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
                  pageController.jumpToPage(1);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  child: const Text(
                    'Ainda não tem conta?',
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
