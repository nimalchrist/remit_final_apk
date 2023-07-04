import 'package:flutter/material.dart';

// ignore: camel_case_types
class remitAppBar extends StatelessWidget implements PreferredSizeWidget {
  const remitAppBar({Key key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios_rounded,
          size: 20,
        ),
        color: Colors.black,
        onPressed: () {
          print("back button pressed");
          Navigator.pop(context);
        },
      ),
      title: const Text(
        'REMINDING KIT',
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w800,
          fontSize: 20,
          fontFamily: 'inter',
        ),
      ),
      centerTitle: true,
      backgroundColor: Colors.white,
      elevation: 5,
      shadowColor: Colors.black26,
    );
  }
}
