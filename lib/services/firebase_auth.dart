import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyFirebaseAuth {
  final _auth = FirebaseAuth.instance;

  Future register({
    required String email,
    required String password,
    required String userName,
    required BuildContext context,
    required PageController pageController,
  }) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = _auth.currentUser;

      if (user != null) {
        await user.updateDisplayName(userName);
        await user.reload();
      }
      final users = FirebaseFirestore.instance.collection('users');

      await users.doc(_auth.currentUser!.uid).set({});
    } catch (e) {
      if (e.toString().contains('The email address is badly formatted')) {
        if (Scaffold.of(context).mounted) {
          return ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Formato de email inválido')));
        }
      } else if (e
          .toString()
          .contains('The email address is already in use by another account')) {
        return ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text('Email já cadastrado'),
                TextButton(
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
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                    child: Text(
                      'Conectar',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      }
    }
  }

  Future login(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException {
      return ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Não existe um usuário com este email',
          ),
        ),
      );
    }
  }

  Future logout() async {
    await _auth.signOut();
  }

  Future sendCodeToEmail(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  Future<String> verifyCodeFromEmail(String code) async {
    String message = '';
    try {
      await _auth.verifyPasswordResetCode(code);
    } catch (e) {
      if (e.toString() == 'invalid-action-code') {
        message = 'Código inserido inválido!';
      } else if (e.toString() == 'expired-action-code') {
        message = 'Código expirou, envie novamente';
      }
      message = 'Senha atualizada com sucesso!';
    }
    return message;
  }

  Future inputCodeFromEmail(String code, String newPassword) async {
    await _auth.confirmPasswordReset(code: code, newPassword: newPassword);
  }
}
