import 'package:flutter/material.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import '../const/api_const.dart';
import '../const/chat_message_mapper.dart';
import '../datas/models/request_model.dart';
import '../datas/models/response_model.dart';
import '../datas/services/chat_api_services.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textController = TextEditingController();
  final ChatApiServices _chatServices = ChatApiServices();

  bool _isLoading = false;
  final List<Message> _message = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("AI Agent App"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _message.length + (_isLoading ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index >= _message.length) {
                    return Text("Thinking ...");
                  }
                  Message message = _message[index];
                  bool isSender = message.role == "user";
                  return BubbleSpecialThree(
                    text: message.content ?? "",
                    isSender: isSender,
                    color: isSender ? Colors.lightBlue : Colors.black12,
                  );
                },
              ),
            ),
            SafeArea(
              child: TextField(
                onChanged: (_) {
                  setState(() {});
                },
                controller: _textController,
                decoration: InputDecoration(
                  suffix: IconButton(
                    onPressed: _textController.text.trim().isEmpty
                        ? null
                        : () {
                            send(_textController.text);
                          },
                    icon: Icon(Icons.send),
                  ),
                  border: OutlineInputBorder(),
                  labelText: "Ask OLLAMA Agent",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void send(String prompt) {
    setState(() {
      _isLoading = true;
      _message.add(Message(role: "user", content: prompt));
    });

    _textController.clear();
    Message answer = Message(role: "assistance", content: "");
    bool isReceived = false;

    _chatServices
        .sendChatStream(
          requestModel: RequestModel(
            model: ApiConst.madelName,
            messages: [
              Messages(
                role: ApiConst.systemMessage["role"],
                content: ApiConst.systemMessage["content"],
              ),
              Messages(role: "user", content: prompt),
              ..._message.map((v) {
                return toMessage(v);
              }),
            ],
            stream: true,
            think: false,
          ),
        )
        .listen((chunk) {
          setState(() {
            _isLoading = false;
            if (!isReceived) {
              _message.add(answer);
              isReceived = true;
            }
            answer.content =
                (answer.content ?? "") + (chunk.message?.content ?? "");
          });
        });
  }
}
