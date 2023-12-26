import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_flutter/view/menu.dart';

class Message {
  final String text;
  final bool isSender;
  Message(this.text, this.isSender);
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final List<Message> _messages = [];
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          key: _scaffoldKey,
          title: const Text("ChatGPT"),
          centerTitle: true,
          leading: Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.sort_outlined), // Your custom icon here
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: _messages.isNotEmpty
                  ? ListView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.all(8.0),
                      itemCount: _messages.length,
                      itemBuilder: (context, index) {
                        return _buildMessageItem(_messages[index]);
                      },
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          "assets/images/chatgpt.svg",
                          fit: BoxFit.contain,
                        ),
                        const Text(
                          "How can I help you today?",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
            ),
            _buildInputField(),
          ],
        ),
        drawer: const SafeArea(
          child: Menu(),
        ),
        onDrawerChanged: (isOpened) => {print("onDrawerChanged $isOpened")},
      ),
    );
  }

  void _handleSendMessage(String text, bool isSender) {
    if (text.isEmpty || (loading && isSender)) {
      return;
    }

    setState(() {
      _messages.add(Message(text, isSender));
      loading = true;
      _textController.clear();
      FocusScope.of(context).unfocus();

      Future.delayed(const Duration(seconds: 1), () {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      });
    });

    if (isSender) {
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          _handleSendMessage("Hi, I'm ChatGPT ${DateTime.now()}", false);
          loading = false;
        });
      });
    }
  }

  Widget _buildMessageItem(Message message) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        textDirection: message.isSender ? TextDirection.rtl : TextDirection.ltr,
        children: [
          SizedBox(
            width: 30,
            height: 30,
            child: SvgPicture.asset(
              "assets/images/chatgpt.svg",
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(width: 8.0),
          Container(
            padding: const EdgeInsets.all(12.0),
            constraints: const BoxConstraints(
              maxWidth: 320, // 你可以根据需要设置最大宽度
              minWidth: 0,
            ),
            decoration: BoxDecoration(
              color: message.isSender ? Colors.blue : Colors.green,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              message.text,
              style: const TextStyle(color: Colors.white),
              softWrap: true,
              overflow: TextOverflow.visible,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              onSubmitted: (_) {
                _handleSendMessage(_textController.text, true);
              },
              controller: _textController,
              decoration: const InputDecoration(
                hintText: 'Type a message...',
              ),
              textInputAction: TextInputAction.send,
              inputFormatters: [
                LengthLimitingTextInputFormatter(40),
                // FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9]')),
              ],
            ),
          ),
          IconButton(
            icon: Icon(loading ? Icons.pending : Icons.arrow_upward),
            onPressed: () {
              _handleSendMessage(_textController.text, true);
            },
          ),
        ],
      ),
    );
  }
}
