import 'package:flutter/material.dart';

class BilibiliHome extends StatelessWidget {
  const BilibiliHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("哔哩哔哩"),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, 'home');
          },
          icon: Image.network(
            "https://cdn.oaistatic.com/_next/static/media/favicon-32x32.be48395e.png",
            width: 20,
            height: 20,
            fit: BoxFit.contain,
          ),
        ),
      ),
      body: const Column(
        children: [],
      ),
    );
  }
}
