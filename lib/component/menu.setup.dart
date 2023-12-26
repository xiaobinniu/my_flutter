import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MenuSetup extends StatefulWidget {
  const MenuSetup({super.key});

  @override
  State<MenuSetup> createState() => _MenuSettingState();
}

class _MenuSettingState extends State<MenuSetup> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 100, 100, 100),
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SvgPicture.asset("assets/images/chatgpt.svg",
              width: 20,
              theme: const SvgTheme(
                currentColor: Colors.white,
              )),
          const SizedBox(width: 8),
          const Text(
            "user",
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
