import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: TextButton(
          onPressed: () {
            Navigator.pushNamed(context, "history");
          },
          child: const Text("History"),
        ),
      ),
      floatingActionButton: Stack(
        children: [
          Positioned(
            bottom: 20,
            right: 0,
            child: TextButton(
              onPressed: () {
                Navigator.pushNamed(context, "");
              },
              child: const Text("go Error"),
            ),
          ),
        ],
      ),
    );
  }
}
