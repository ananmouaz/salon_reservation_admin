import 'package:flutter/material.dart';
import 'package:salon_reservation/core/widget/base_page.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  @override
  Widget build(BuildContext context) {
    return const BasePage(content: Column(children: [],));
  }
}
