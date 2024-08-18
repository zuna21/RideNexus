import 'package:flutter/material.dart';
import 'package:mobile/models/chat_model.dart';
import 'package:mobile/services/chat_service.dart';
import 'package:mobile/widgets/message.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key, this.driverId, this.chatId});

  final int? driverId;
  final int? chatId;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final chatService = ChatService();
  ChatModel? _chat;
  

  @override
  void initState() {
    super.initState();
    getChat();
  }

  void getChat() {
    if (widget.driverId != null) {
      getClientChatByIds();
    }
  }

  // Ova funkcija je ako se proslijedi driverId (tj. ako user otvori chat kroz vozaca)
  Future<void> getClientChatByIds() async {
    ChatModel? chat;
    try {
      chat = await chatService.getClientChatByIds(widget.driverId!);
    } catch(e) {
      print(e.toString());
    }

    if (chat != null) {
      setState(() {
        _chat = chat;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Poruke"),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: Column(
        children: [
          const Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Message(
                    isMine: false,
                  ),
                  Message(
                    isMine: true,
                  ),
                  Message(
                    isMine: false,
                  ),
                  Message(
                    isMine: true,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    const Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Napiši poruku',
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.send_outlined),
                      style: IconButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
                        foregroundColor: Theme.of(context).colorScheme.onTertiaryContainer,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                    backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                    foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                  child: const Text("Zakaži Vožnju"),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
