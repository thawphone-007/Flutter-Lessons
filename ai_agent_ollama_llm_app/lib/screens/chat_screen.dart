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
  final ScrollController _scrollController = ScrollController();

  bool _isLoading = false;
  final List<Message> _message = [];

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
    _textController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("AI Agent App"), centerTitle: true),
      body: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: 600),
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: _message.length + (_isLoading ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index >= _message.length) {
                      return Text("Thinking ...");
                    }
                    Message message = _message[index];
                    bool isSender = message.role == "user";
                    if(message.content?.isEmpty == true){
                      return SizedBox.shrink();
                    }

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
                    isDense: true,
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
      ),
    );
  }

  void send(String prompt) {
    setState(() {
      _isLoading = true;
      _message.add(Message(role: "user", content: prompt));
    });

    _textController.clear();
    Message answer = Message(role: "assistant", content: "");
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

            List<ToolCalls>? tools = chunk.message?.toolCalls ?? [];
            for (var tool in tools) {
              String? id = tool.id;
              String? name = tool.function?.name;

              if (name == "show_warning_dialog") {
                Arguments? arguments = tool.function?.arguments;
                String? title = arguments?.title;
                String? content = arguments?.content;

                if (title != null && content != null) {
                  showWarningDialog(title, content);
                }
              }
            }
          });
          _scrollToBottom();
        });
  }

  void _scrollToBottom() {
    if (!_scrollController.hasClients) return;
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: Duration(milliseconds: 50),
      curve: Curves.easeInOut,
    );
  }

  void showWarningDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            FilledButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }
}
