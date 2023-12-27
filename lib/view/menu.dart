import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import "../storage/history_data.dart";

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  final List<List<Dialogue>> _chatItems = [];

  bool isSetupVisible = false;

  @override
  void initState() {
    super.initState();

    var map = DialogueClass.getAll();
    print(map);
    var keys = map.keys.toList()..sort();
    print(keys);
    var values = [];
    for (var key in keys) {
      values.add(map[key]);
    }
    setState(() {
      // _chatItems.addAll(values as Iterable<List<Dialogue>>);
    });

    print(values);
  }

  void toggleSetupVisibility() {
    setState(() {
      isSetupVisible = !isSetupVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        scrollbarTheme: ScrollbarThemeData(
          thumbColor:
              MaterialStateProperty.all(const Color.fromRGBO(40, 40, 40, 1)),
          radius: const Radius.circular(5.0),
          thickness: MaterialStateProperty.all(8.0),
        ),
      ),
      child: SizedBox(
        width: 340,
        child: Stack(
          children: [
            Container(
                width: 300,
                padding: const EdgeInsets.fromLTRB(5, 10, 0, 10),
                decoration: const BoxDecoration(
                  color: Colors.black,
                ),
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _builtNewChat(),
                        Expanded(
                          child: Scrollbar(
                            child: ListView.builder(
                              itemCount: _chatItems.length,
                              itemBuilder: (context, index) {
                                return _buildChatItem(_chatItems[index][0]);
                              },
                            ),
                          ),
                        ),
                        _buildUserItem(),
                      ],
                    ),
                    isSetupVisible
                        ? _buildSetup()
                        : Container(
                            key: UniqueKey(),
                          ),
                  ],
                )),
            Positioned(
              top: 20,
              right: 0,
              child: Container(
                width: 30.0,
                height: 30.0,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: IconButton(
                  padding: const EdgeInsets.all(0),
                  icon: const Icon(Icons.close),
                  color: Colors.white,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _builtNewChat() {
    return Container(
      width: 280,
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 100, 100, 100),
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                "assets/images/chatgpt.svg",
                width: 20,
                theme: const SvgTheme(
                  currentColor: Colors.white,
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                "New chat",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const Icon(
            Icons.create_outlined,
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  Widget _buildChatItem(Dialogue item) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Color.fromRGBO(20, 20, 20, 1),
              width: 1,
            ),
          ),
        ),
        padding: const EdgeInsets.all(8),
        height: 36,
        child: Text(
          item.text,
          style: const TextStyle(
            color: Colors.white,
            overflow: TextOverflow.ellipsis,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildUserItem() {
    return GestureDetector(
      onTap: () {
        toggleSetupVisibility();
      },
      child: Container(
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
      ),
    );
  }

  Widget _buildSetup() {
    return Positioned(
      key: UniqueKey(),
      bottom: 50,
      child: Container(
        width: 280,
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 100, 100, 100),
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: Column(
          children: [
            _buildSetupItem(Icons.settings_outlined, "Setting"),
            _buildSetupItem(Icons.settings_outlined, "Setting"),
            _buildSetupItem(Icons.settings_outlined, "Setting"),
            _buildSetupItem(Icons.settings_outlined, "Setting"),
          ],
        ),
      ),
    );
  }

  Widget _buildSetupItem(IconData icon, String text) {
    return Container(
      height: 30,
      margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
      child: Row(
        children: [
          Icon(icon, color: Colors.white),
          const SizedBox(
            width: 8,
          ),
          Text(
            text,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          )
        ],
      ),
    );
  }
}
