import 'package:flutter/material.dart';
import 'package:mobile/pages/driver/chat_page.dart';

class ChatCard extends StatelessWidget {
  final bool
      isSeen; // ovo ce se izbrisati jer ce input biti chat koji ce imati isSeen

  const ChatCard({super.key, this.isSeen = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => ChatPage(),
        ),
      ),
      child: Card(
        color: isSeen
            ? Theme.of(context).colorScheme.secondaryContainer
            : Theme.of(context).colorScheme.tertiaryContainer,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              const Column(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage("https://picsum.photos/700"),
                  ),
                  Text("zuna21")
                ],
              ),
              const SizedBox(
                width: 40,
              ),
              Flexible(
                child: Column(
                  children: [
                    Text(
                      "Mozesl li danas oko polak ajkdfj kjakfj kasdjfk jkda jkldajf kjdakfj kfjkajfkjakj fkajfd k 1 dociadfasdfasdfdasfadfadfadsf do grada?",
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
                          "24-07-2024 11:25",
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
