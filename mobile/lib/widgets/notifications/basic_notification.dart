import 'package:flutter/material.dart';

class BasicNotification extends StatelessWidget {
  const BasicNotification({super.key, this.title = "Naslov", this.body = "Tijelo notifikacije"});

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),),
            const SizedBox(height: 10,),
            Text(body, style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),),
            const SizedBox(height: 20,),
            ElevatedButton(onPressed: () {
              Navigator.of(context).pop();
            }, child: const Text("Ok"),),
        ],
        ),
      ),
    );
  }
}