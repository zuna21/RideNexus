import 'package:flutter/material.dart';
import 'package:mobile/widgets/message.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

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
