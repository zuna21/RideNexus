import 'package:flutter/material.dart';
import 'package:mobile/widgets/cards/chat_card.dart';

class MessagesPage extends StatelessWidget {
  const MessagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Poruke"),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            ChatCard(),
            ChatCard(
              isSeen: true,
            ),
            ChatCard(
              isSeen: true,
            ),
          ],
        ),
      ),
    );
  }
}
