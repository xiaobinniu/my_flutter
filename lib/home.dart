import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
          title: const Text("ChatGPT"),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.all(8.0),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  return _buildMessageItem(_messages[index]);
                },
              ),
            ),
            _buildInputField(),
          ],
        ),
      ),
    );
  }

  void _handleSendMessage(String text, bool isSender) {
    if (text.isEmpty) {
      return;
    }

    setState(() {
      _messages.add(Message(text, isSender));
      loading = true;
      _textController.clear();
      FocusScope.of(context).unfocus();
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    });

    if (isSender) {
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          _handleSendMessage("Hi, I'm ChatGPT ${DateTime.now()}", false);
          loading = false;
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
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
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(12.0),
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
              controller: _textController,
              decoration: const InputDecoration(
                hintText: 'Type a message...',
              ),
              onSubmitted: (_) {
                _handleSendMessage(_textController.text, true);
              },
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
