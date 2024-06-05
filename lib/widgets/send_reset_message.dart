import 'package:flutter/material.dart';
import 'package:todo_firebase/components/my_snackbar.dart';
import 'package:todo_firebase/services/firebase_auth.dart';

class SendResetMessage extends StatelessWidget {
  SendResetMessage(
      {required this.globalEmailTextController,
      required this.pageController,
      super.key});

  final TextEditingController globalEmailTextController;
  final auth = MyFirebaseAuth();
  final PageController pageController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            pageController.jumpToPage(0);
          },
        ),
        centerTitle: true,
        title: const Text(
          'Recuperar senha',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Seu email',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 5),
            TextField(
              controller: globalEmailTextController,
              decoration: InputDecoration(
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
            FilledButton(
              style: FilledButton.styleFrom(
                minimumSize: const Size(
                  double.infinity,
                  50,
                ),
              ),
              onPressed: () async {
                await auth.sendCodeToEmail(globalEmailTextController.text);
                ScaffoldMessenger.of(context).showSnackBar(
                  MySnackbar.mySnackBar(
                    text: 'Código enviado!',
                  ),
                );
                globalEmailTextController.clear();
                pageController.jumpToPage(0);
              },
              child: const Text(
                'Enviar código',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
