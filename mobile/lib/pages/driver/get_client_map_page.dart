import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class GetClientMapPage extends StatefulWidget {
  const GetClientMapPage({super.key});

  @override
  State<GetClientMapPage> createState() => _GetClientMapPageState();
}

class _GetClientMapPageState extends State<GetClientMapPage> {
  void _openMap() async {
    // await launchUrl(Uri.parse("https://www.google.com/maps/dir/?api=1&origin=44.731021,18.077764&destination=44.731658,18.083031"));
    final thatBool =
        await launchUrl(Uri.parse("google.navigation:q=44.731658,18.083031"));
    print(thatBool);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lokacija putnika"),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: _openMap,
            child: Text("OpenMap"),
          ),
        ],
      ),
    );
  }
}
