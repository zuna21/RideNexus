import 'package:flutter/material.dart';
import 'package:mobile/models/chat_model.dart';
import 'package:mobile/pages/driver/chat_page.dart';

class ChatCard extends StatelessWidget {
  const ChatCard({super.key, required this.chat});

  final ChatCardModel chat;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => const ChatPage(),
        ),
      ),
      child: Card(
        color: chat.isSeen!
            ? Theme.of(context).colorScheme.secondaryContainer
            : Theme.of(context).colorScheme.tertiaryContainer,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Column(
                children: [
                  const CircleAvatar(
                    backgroundImage: NetworkImage("https://picsum.photos/700"),
                  ),
                  Text(chat.senderUsername!)
                ],
              ),
              const SizedBox(
                width: 40,
              ),
              Flexible(
                child: Column(
                  children: [
                    Text(
                      chat.lastMessage!.content!,
                      style: Theme.of(context).textTheme.bodyMedium,
                      overflow: TextOverflow.visible,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          chat.lastMessage!.createdAt!,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
