import 'package:flutter/material.dart';

class Message extends StatelessWidget {
  final bool isMine;

  const Message({super.key, this.isMine = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          isMine ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
          padding: const EdgeInsets.all(8),
          width: 250,
          decoration: BoxDecoration(
              color: isMine
                  ? Theme.of(context).colorScheme.tertiaryContainer
                  : Theme.of(context).colorScheme.secondaryContainer,
              border: Border.all(
                color: Theme.of(context).colorScheme.primary,
              ),
              borderRadius: BorderRadius.circular(5)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Moze li danas to?",
                style: Theme.of(context).textTheme.titleSmall,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "14-08-2024 11:24",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
