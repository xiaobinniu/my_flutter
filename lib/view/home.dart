import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../net/fake_data.dart';
import '../view/menu.dart';
import '../storage/history_data.dart';

// import '../net/openai.dart';
// import '../net/http_client.dart';
// import '../net/api.dart' as config;

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
  DialogueClass dialogue = DialogueClass();

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
                        const SizedBox(height: 16.0),
                        const Text(
                          "How can I help you today?",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
            ),
            Center(
              child: _buildInputField(),
            ),
            const SizedBox(
              height: 5,
            )
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
    });
    _textController.clear();
    FocusScope.of(context).unfocus();

    dialogue.add(Dialogue(isSender ? UserType.system : UserType.user, text));

    if (isSender) {
      Future.delayed(const Duration(seconds: 1), () {
        int index = Random().nextInt(fakeData.length - 1) + 1;
        setState(() {
          _handleSendMessage(fakeData[index], false);
          loading = false;
        });
      });
      Future.delayed(const Duration(milliseconds: 1200), () {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
        );
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
      width: 390,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
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
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none,
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

  // _sendHttp() {
  //   // 发送请求
  //   RequestOpenaiData requestDataBuilder = RequestOpenaiData(text);
  //   Map<String, dynamic> requestData = requestDataBuilder.buildRequestData();
  //   HttpClient httpClient = HttpClient(config.endpoint);
  //   httpClient.postRequest(requestData).then((response) {
  //     if (response["statusCode"] == 200) {
  //       _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
  //     } else {
  //       print("${response['error']?['message']}");
  //     }
  //   }).whenComplete(() {
  //     setState(() {
  //       loading = false;
  //     });
  //   });
  // }
}
