import 'package:flutter/material.dart';
import 'package:todo_firebase/widgets/login_page.dart';
import 'package:todo_firebase/widgets/register_page.dart';

class ConnectPage extends StatelessWidget {
  ConnectPage({super.key});

  final controller = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      controller: controller,
      children: [
        LoginPage(pageController: controller,),
        RegisterPage(pageController: controller,),
      ],
    );
  }
}
