import 'package:flutter/material.dart';
import 'package:mobile/models/chat_model.dart';
import 'package:mobile/services/chat_service.dart';
import 'package:mobile/widgets/cards/chat_card.dart';

class MessagesPage extends StatefulWidget {
  const MessagesPage({super.key});

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  final _chatService = ChatService();
  List<ChatCardModel> _chats = [];

  @override
  void initState() {
    super.initState();
    getDriverChats();
  }

  Future<void> getDriverChats() async {
    List<ChatCardModel> chats = [];
    try {
      chats = await _chatService.getDriverChats();
    } catch (e) {
      print(e);
    }

    setState(() {
      _chats = [...chats];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Poruke"),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: ListView.builder(
        itemCount: _chats.length,
        itemBuilder: (itemBuilder, index) => ChatCard(
          chat: _chats[index],
        ),
      ),
    );
  }
}
