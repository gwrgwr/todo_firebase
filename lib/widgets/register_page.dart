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
      appBar: AppBar(
        title: const Text('Registrar-se'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Seu nome',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                TextFormField(
                  validator: (value) {
                    if (value != null) {
                      return 'Campo obrigatório!';
                    }
                    return null;
                  },
                  onTapOutside: (event) =>
                      FocusScope.of(context).requestFocus(FocusNode()),
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
                const SizedBox(height: 10),
                const Text(
                  'Seu email',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                TextFormField(
                  validator: (value) {
                    if (value != null) {
                      if (!(value.contains('@'))) {
                        return 'Email inválido';
                      }
                    }
                    return null;
                  },
                  onTapOutside: (event) =>
                      FocusScope.of(context).requestFocus(FocusNode()),
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    suffixIcon: const Icon(Icons.email_outlined),
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
                const SizedBox(height: 10),
                const Text(
                  'Seu usuário',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                TextFormField(
                  validator: (value) {
                    if (value != null) {
                      return 'Campo obrigatório!';
                    }
                    return null;
                  },
                  onTapOutside: (event) =>
                      FocusScope.of(context).requestFocus(FocusNode()),
                  controller: userController,
                  decoration: InputDecoration(
                      hintText: 'Usuário',
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
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Sua senha',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                ValueListenableBuilder(
                  valueListenable: controller,
                  builder: (context, value, child) {
                    return TextFormField(
                      validator: (value) {
                        if (value != null) {
                          if (value.length < 6) {
                            return 'Senha precisa ter ao menos 6 caracteres';
                          }
                        }
                        return null;
                      },
                      onTapOutside: (event) =>
                          FocusScope.of(context).requestFocus(FocusNode()),
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
                        context: context,
                        pageController: pageController
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
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
                        'Já tem uma conta?',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
