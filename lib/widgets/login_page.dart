import 'package:flutter/material.dart';
import 'package:todo_firebase/services/firebase_auth.dart';
import 'package:todo_firebase/states/login_states.dart';

// ignore: must_be_immutable
class LoginPage extends StatelessWidget {
  LoginPage({required this.pageController, super.key});

  final emailTextController = TextEditingController();
  final senhaTextController = TextEditingController();
  final PageController pageController;
  MyFirebaseAuth myFirebaseAuth = MyFirebaseAuth();
  final controller = LoginStates();
  final GlobalKey<FormFieldState> formFieldKey = GlobalKey();
  final focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Conectar-se'),
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
                  'Insira seu email',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                TextFormField(
                  onTapOutside: (event) =>
                      FocusScope.of(context).requestFocus(FocusNode()),
                  key: formFieldKey,
                  validator: (value) {
                    if (value != null) {
                      if (!(value.contains('@'))) {
                        return 'Email inválido';
                      }
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
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
                    return TextFormField(
                      onTapOutside: (event) =>
                          FocusScope.of(context).requestFocus(FocusNode()),
                      validator: (value) {
                        if (value != null) {
                          if (value.length < 6) {
                            return 'Senha precisa ter ao menos 6 caracteres';
                          }
                        }
                        return null;
                      },
                      keyboardType: TextInputType.visiblePassword,
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
                      if (formFieldKey.currentState!.validate()) {
                        myFirebaseAuth.login(
                          email: emailTextController.text,
                          password: senhaTextController.text,
                          context: context,
                        );
                        FocusScope.of(context).requestFocus(FocusNode());
                      }
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
        ),
      ),
    );
  }
}
