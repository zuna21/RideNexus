import 'package:flutter/material.dart';
import 'package:mobile/pages/driver/driver_home_page.dart';
import 'package:mobile/pages/driver/rides_page.dart';

class RideDialog extends StatelessWidget {
  const RideDialog({super.key, this.title = "Naslov", this.body = "Body"});

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.all(8.0),
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              body,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
            ),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Theme.of(context).colorScheme.tertiaryContainer,
                foregroundColor:
                    Theme.of(context).colorScheme.onTertiaryContainer,
                minimumSize: Size.fromHeight(40),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => DriverHomePage(),
                  ),
                );
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => RidesPage(),
                  ),
                );
              },
              child: Text("Pogledajte"),
            ),
          ],
        ),
      ),
    );
  }
}
