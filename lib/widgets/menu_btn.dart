import 'package:flutter/material.dart';

enum Option { about }

class MenuBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<Option>(
      itemBuilder: (context) => const [
        PopupMenuItem(
          value: Option.about,
          child: Text('Acerca de...'),
        ),
      ],
      onSelected: (option) {
        switch (option) {
          case Option.about:
            showAboutDialog(
              context: context,
              applicationName: 'Radio Chapingo',
              applicationIcon: Container(
                height: 80,
                child: Image.asset(
                  'images/logo_full.png',
                  fit: BoxFit.scaleDown,
                ),
              ),
              applicationVersion: 'versión preliminar',
            );
            break;
        }
      },
    );
  }
}
