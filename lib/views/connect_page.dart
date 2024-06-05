import 'package:flutter/material.dart';
import 'package:todo_firebase/widgets/login_page.dart';
import 'package:todo_firebase/widgets/register_page.dart';
import 'package:todo_firebase/widgets/send_reset_message.dart';

class ConnectPage extends StatelessWidget {
  ConnectPage({super.key});

  final controller = PageController();
  final globalEmailTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      controller: controller,
      children: [
        LoginPage(
          pageController: controller,
          globalEmailTextController: globalEmailTextController,
        ),
        RegisterPage(
          pageController: controller,
        ),
        SendResetMessage(
          globalEmailTextController: globalEmailTextController,
          pageController: controller,
        ),
      ],
    );
  }
}
