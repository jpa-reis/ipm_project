import 'package:flutter/material.dart';
import 'package:ipm_project/new_page.dart';

class GardenDrawer extends StatelessWidget {
  const GardenDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        ListTile(
          leading: const Icon(Icons.map),
          title: const Text("Jardim Botânico do Porto"),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const NewPage())
            );
          }
        ),
        const ListTile(
          leading: Icon(Icons.photo_album),
          title: Text("Jardim Zoológico")
        ),
        const ListTile(
          leading: Icon(Icons.phone),
          title: Text("Estufa Fria")
        )
      ]
    );
  }
}