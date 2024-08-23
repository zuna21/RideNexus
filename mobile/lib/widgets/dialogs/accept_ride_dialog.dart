import 'package:flutter/material.dart';

class AcceptRideDialog extends StatelessWidget {
  const AcceptRideDialog({super.key, required this.title, required this.body});

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      insetPadding: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleLarge,),
            const SizedBox(height: 10,),
            Text(body, style: Theme.of(context).textTheme.bodyMedium,),
            const SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton.icon(onPressed: (){}, label: const Text("Odbij"), icon: const Icon(Icons.close_outlined),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  foregroundColor: Colors.white,
                ),),
                ElevatedButton.icon(onPressed: (){}, label: const Text("Prihvati"), icon: const Icon(Icons.check_outlined),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.greenAccent,
                  foregroundColor: Colors.black
                ),),
              ],
            )
          ],
        ),
      ),
    );
  }
}